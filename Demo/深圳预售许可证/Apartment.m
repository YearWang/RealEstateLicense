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
    NSMutableString *averagePriceString = [NSMutableString stringWithString:[priceElement stringValue]];
    [averagePriceString replaceOccurrencesOfString:@"元/平方米(按建筑面积计)"
                                        withString:@""
                                           options:NSLiteralSearch
                                             range:NSMakeRange(0, averagePriceString.length)];
    [averagePriceString stringByReplacingOccurrencesOfString:@" " withString:@""];
    [averagePriceString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [averagePriceString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    

    NSLog(@"%@",averagePriceString);
    
    ONOXMLElement *floorElement = [doc firstChildWithXPath:@"//table[@width='98%']/tr[3]/td[2]"];
    self.floor = [floorElement stringValue];
    
    ONOXMLElement *roomNumberElement = [doc firstChildWithXPath:@"//table[@width='98%']/tr[3]/td[4]"];
    self.roomNumber = [roomNumberElement stringValue];
    
    ONOXMLElement *usageElement = [doc firstChildWithXPath:@"//table[@width='98%']/tr[3]/td[6]"];
    self.usage = [usageElement stringValue];
    
    ONOXMLElement *grossElement = [doc firstChildWithXPath:@"//table[@width='98%']/tr[5]/td[2]"];
    self.grossFloorArea = [grossElement stringValue];
}


@end
