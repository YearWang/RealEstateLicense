//
//  BuildingDetail.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/3.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "BuildingDetail.h"
#import <Ono.h>

@implementation BuildingDetail

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.buildingName = [aDecoder decodeObjectForKey:@"BuildingName"];
        self.buildingNumber = [aDecoder decodeObjectForKey:@"BuildingNumber"];
        self.buildingMainType = [aDecoder decodeObjectForKey:@"BuildingMainType"];
        self.buildingHouseholdings = [aDecoder decodeIntegerForKey:@"BuildingHouseholdings"];
        self.buildingPrice = [aDecoder decodeIntegerForKey:@"BuildingPrice"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.buildingName forKey:@"BuildingName"];
    [aCoder encodeObject:self.buildingNumber forKey:@"BuildingNumber"];
    [aCoder encodeObject:self.buildingMainType forKey:@"BuildingMainType"];
    [aCoder encodeInteger:self.buildingHouseholdings forKey:@"BuildingHouseholdings"];
    [aCoder encodeInteger:self.buildingPrice forKey:@"BuildingPrice"];
}


+ (instancetype)buildingsWithHtmlStr:(ONOXMLElement *)element
{
    BuildingDetail *b = [[BuildingDetail alloc] init];
    
    ONOXMLElement *buildingNameElement = [element firstChildWithXPath:@"td[2]"]; // 根据 XPath 获取td[2]下含有文章标题的 a 标签
    b.buildingName = [buildingNameElement stringValue];//获取 预售证详情网址
    
    ONOXMLElement *urlElement = [element firstChildWithXPath:@"td[5]/a"]; // 根据 XPath 获取含有文章标题的 a 标签
    b.everyBuildingUrl = [urlElement valueForAttribute:@"href"]; // 获取 项目网址
    
//    ONOXMLElement *companyElement = [element firstChildWithXPath:@"td[4]"]; // 根据 XPath 获取文章发布时间 公司 标签
//    l.company = [companyElement stringValue]; // 获取 开发商
//    
//    ONOXMLElement *districtElement = [element firstChildWithXPath:@"td[5]"]; // 根据 XPath 获取文章发布时间 span 标签
//    l.district = [districtElement stringValue]; // 获取 项目区域
//    
//    ONOXMLElement *dateElement = [element firstChildWithXPath:@"td[6]"]; // 根据 XPath 获取文章发布时间 span 标签
//    l.date = [dateElement stringValue];  // 获取 预售证发布日期
    
    return b;
}

@end
