//
//  Apartment.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/10.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "Apartment.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation Apartment

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.apartmentNumberWithSquareMetre = [aDecoder decodeObjectForKey:@"ApartmentNumberWithSquareMetre"];
        self.apartmentUrl = [aDecoder decodeObjectForKey:@"ApartmentUrl"];
        self.roomNumber = [aDecoder decodeObjectForKey:@"RoomNumber"];
        self.kindNumber = [aDecoder decodeObjectForKey:@"KindNumber"];
        self.floor = [aDecoder decodeObjectForKey:@"Floor"];
        self.usage = [aDecoder decodeObjectForKey:@"Usage"];
        self.grossFloorArea = [aDecoder decodeFloatForKey:@"GrossFloorArea"];
        self.averagePrice = [aDecoder decodeFloatForKey:@"AveragePrice"];
        self.totalPrice = [aDecoder decodeFloatForKey:@"TotalPrice"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.apartmentNumberWithSquareMetre forKey:@"ApartmentNumberWithSquareMetre"];
    [aCoder encodeObject:self.apartmentUrl forKey:@"ApartmentUrl"];
    [aCoder encodeObject:self.roomNumber forKey:@"RoomNumber"];
    [aCoder encodeObject:self.kindNumber forKey:@"KindNumber"];
    [aCoder encodeObject:self.floor forKey:@"Floor"];
    [aCoder encodeObject:self.usage forKey:@"Usage"];
    [aCoder encodeFloat:self.grossFloorArea forKey:@"GrossFloorArea"];
    [aCoder encodeFloat:self.averagePrice forKey:@"AveragePrice"];
    [aCoder encodeFloat:self.totalPrice forKey:@"TotalPrice"];
    
}

- (void)apartmentWithHtmlStr:(ONOXMLElement *)element //给该apartment各属性赋值
{
    ONOXMLElement *apartmentNumberElement = [element firstChildWithXPath:@"div[1]"];
    self.apartmentNumberWithSquareMetre = [apartmentNumberElement stringValue];
    
    ONOXMLElement *apartmentUrlElement = [element firstChildWithXPath:@"div[2]/a"];
    NSString *relativeApartmentUrl = [apartmentUrlElement valueForAttribute:@"href"];
    if (relativeApartmentUrl) {
        self.apartmentUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,relativeApartmentUrl];
    }
}


- (void)getApartmentDetail
{
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.apartmentUrl]];//下载主页网页数据
    NSError *error;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    
    ONOXMLElement *priceElement = [doc firstChildWithXPath:@"//table[@width='98%']/tr[2]/td[4]"];
    NSString *averagePriceString = [priceElement stringValue];
    averagePriceString = [averagePriceString stringByReplacingOccurrencesOfString:@"[^0-9.]"
                                                                       withString:@""
                                                                          options:NSRegularExpressionSearch
                                                                            range:NSMakeRange(0, [averagePriceString length])];
    self.averagePrice = [averagePriceString floatValue];
        
    ONOXMLElement *floorElement = [doc firstChildWithXPath:@"//table[@width='98%']/tr[3]/td[2]"];
    self.floor = [floorElement stringValue];
    
    ONOXMLElement *roomNumberElement = [doc firstChildWithXPath:@"//table[@width='98%']/tr[3]/td[4]"];
    self.roomNumber = [roomNumberElement stringValue];
    
    NSUInteger length = [self.roomNumber length];
    NSRange rang = NSMakeRange(length-3, 2);
    NSString * strRang = [self.roomNumber substringWithRange:rang];
    self.kindNumber = strRang;

    
    ONOXMLElement *usageElement = [doc firstChildWithXPath:@"//table[@width='98%']/tr[3]/td[6]"];
    self.usage = [usageElement stringValue];
    
    ONOXMLElement *grossElement = [doc firstChildWithXPath:@"//table[@width='98%']/tr[5]/td[2]"];
    NSString *grossFloorAreaString = [grossElement stringValue];
    grossFloorAreaString = [grossFloorAreaString stringByReplacingOccurrencesOfString:@"平方米" withString:@""];
    self.grossFloorArea = [grossFloorAreaString floatValue];    
}


- (float)totalPrice
{
    return self.averagePrice*self.grossFloorArea;
}


@end
