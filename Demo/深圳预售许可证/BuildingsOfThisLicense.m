//
//  BuildingsOfThisLicense.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/10.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "BuildingsOfThisLicense.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation BuildingsOfThisLicense


- (void)buildingsWithHtmlStr:(ONOXMLElement *)element
{
    ONOXMLElement *buildingNameElement = [element firstChildWithXPath:@"td[2]"]; // 根据 XPath 获取td[2]下含有文章标题的 a 标签
    self.everyBuildingName = [buildingNameElement stringValue];//获取 预售证详情网址
    
    ONOXMLElement *urlElement = [element firstChildWithXPath:@"td[5]/a"]; // 根据 XPath 获取含有文章标题的 a 标签
    NSString *relativeEveryBuildingUrl = [urlElement valueForAttribute:@"href"]; // 获取 项目各栋楼的相对URL
    self.everyBuildingUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,relativeEveryBuildingUrl];
    NSLog(@"%@",self.everyBuildingUrl);
    
    //    ONOXMLElement *companyElement = [element firstChildWithXPath:@"td[4]"]; // 根据 XPath 获取文章发布时间 公司 标签
    //    l.company = [companyElement stringValue]; // 获取 开发商
    //
    //    ONOXMLElement *districtElement = [element firstChildWithXPath:@"td[5]"]; // 根据 XPath 获取文章发布时间 span 标签
    //    l.district = [districtElement stringValue]; // 获取 项目区域
    //
    //    ONOXMLElement *dateElement = [element firstChildWithXPath:@"td[6]"]; // 根据 XPath 获取文章发布时间 span 标签
    //    l.date = [dateElement stringValue];  // 获取 预售证发布日期
    
}


@end
