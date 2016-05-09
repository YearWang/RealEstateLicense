//
//  License.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/29.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "License.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation License

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.district = [aDecoder decodeObjectForKey:@"District"];
        self.date = [aDecoder decodeObjectForKey:@"Date"];
        self.company = [aDecoder decodeObjectForKey:@"Company"];
        self.price = [aDecoder decodeIntegerForKey:@"Price"];
        self.quantity = [aDecoder decodeIntegerForKey:@"Quantity"];
        self.buildings = [aDecoder decodeObjectForKey:@"Buildings"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.district forKey:@"District"];
    [aCoder encodeObject:self.date forKey:@"Date"];
    [aCoder encodeObject:self.company forKey:@"Company"];
    [aCoder encodeInteger:self.price forKey:@"Price"];
    [aCoder encodeInteger:self.quantity forKey:@"Quantity"];
    [aCoder encodeObject:self.buildings forKey:@"Buildings"];
}


+ (instancetype)licenseWithHtmlStr:(ONOXMLElement *)element
{
    License *l = [[License alloc] init];
    
    ONOXMLElement *detailElement = [element firstChildWithXPath:@"td[2]/a"]; // 根据 XPath 获取td[2]下含有文章标题的 a 标签
    l.detailUrl = [detailElement valueForAttribute:@"href"];//获取 预售证详情网址
    
    ONOXMLElement *nameElement = [element firstChildWithXPath:@"td[3]/a"]; // 根据 XPath 获取含有文章标题的 a 标签
    l.buildingUrl = [nameElement valueForAttribute:@"href"]; // 获取 项目网址
    l.name = [nameElement stringValue]; // 获取 项目名字
    
    ONOXMLElement *companyElement = [element firstChildWithXPath:@"td[4]"]; // 根据 XPath 获取文章发布时间 公司 标签
    l.company = [companyElement stringValue]; // 获取 开发商
    
    ONOXMLElement *districtElement = [element firstChildWithXPath:@"td[5]"]; // 根据 XPath 获取文章发布时间 span 标签
    l.district = [districtElement stringValue]; // 获取 项目区域
    
    ONOXMLElement *dateElement = [element firstChildWithXPath:@"td[6]"]; // 根据 XPath 获取文章发布时间 span 标签
    l.date = [dateElement stringValue];  // 获取 预售证发布日期
    
    return l;
}

- (void)setDetailUrl:(NSString *)detailUrl
{
    _detailUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,detailUrl];
}

- (void)setBuildingUrl:(NSString *)buildingUrl
{
    _buildingUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,buildingUrl];
}


@end
