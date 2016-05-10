//
//  License.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/29.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "License.h"
#import <Ono.h>
#import "BuildingDetail.h"

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


- (void)licenseWithHtmlStr:(ONOXMLElement *)element  //给该license各属性赋值
{
    ONOXMLElement *detailElement = [element firstChildWithXPath:@"td[2]/a"]; // 根据 XPath 获取td[2]下含有文章标题的 a 标签
    NSString *string = [detailElement valueForAttribute:@"href"];//获取 预售证详情的相对URL
    if (string) {
        NSMutableString *relativeDetailUrl = [NSMutableString stringWithString:string];
        [relativeDetailUrl deleteCharactersInRange:NSMakeRange(0, 2)];
        self.detailUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,relativeDetailUrl];
    }
    
    ONOXMLElement *nameElement = [element firstChildWithXPath:@"td[3]/a"]; // 根据 XPath 获取含有文章标题的 a 标签
    NSString *relativeBuildingUrl = [nameElement valueForAttribute:@"href"]; // 获取 项目各栋楼的相对URL
    self.buildingUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,relativeBuildingUrl];
    self.name = [nameElement stringValue]; // 获取 项目名字
    
    ONOXMLElement *companyElement = [element firstChildWithXPath:@"td[4]"]; // 根据 XPath 获取文章发布时间 公司 标签
    self.company = [companyElement stringValue]; // 获取 开发商
    
    ONOXMLElement *districtElement = [element firstChildWithXPath:@"td[5]"]; // 根据 XPath 获取文章发布时间 span 标签
    self.district = [districtElement stringValue]; // 获取 项目区域
    
    ONOXMLElement *dateElement = [element firstChildWithXPath:@"td[6]"]; // 根据 XPath 获取文章发布时间 span 标签
    self.date = [dateElement stringValue];  // 获取 预售证发布日期
}



- (NSMutableArray *)getWholeBuildings
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.buildingUrl]];//下载项目楼座数据
    NSError *error;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    
    ONOXMLElement *licenseParentElement = [doc firstChildWithXPath:@"//*[@id='DataList1']"]; //寻找该 XPath 代表的 HTML 节点

    //遍历其子节点,提取其中wholeBuilding的信息
    [licenseParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {
        
        BuildingDetail *building = [[BuildingDetail alloc] init];
        [building buildingsWithHtmlStr:element];

        if (building.buildingName) {
            [array addObject:building];
        }
    }];
    return array;
}



@end
