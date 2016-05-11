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



@end
