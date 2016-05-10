//
//  BuildingDetail.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/3.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "BuildingDetail.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

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


/*
- (void)buildingsWithHtmlStr:(ONOXMLElement *)element
{
    ONOXMLElement *buildingNameElement = [element firstChildWithXPath:@"td[2]"]; // 根据 XPath 获取td[2]下含有文章标题的 a 标签
    self.buildingName = [buildingNameElement stringValue];//获取 预售证详情网址
    
    ONOXMLElement *urlElement = [element firstChildWithXPath:@"td[5]/a"]; // 根据 XPath 获取含有文章标题的 a 标签
    NSString *relativeEveryBuildingUrl = [urlElement valueForAttribute:@"href"]; // 获取 项目各栋楼的相对URL
    self.buildingUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,relativeEveryBuildingUrl];
    NSLog(@"%@",self.buildingUrl);
//    ONOXMLElement *companyElement = [element firstChildWithXPath:@"td[4]"]; // 根据 XPath 获取文章发布时间 公司 标签
//    l.company = [companyElement stringValue]; // 获取 开发商
//    
//    ONOXMLElement *districtElement = [element firstChildWithXPath:@"td[5]"]; // 根据 XPath 获取文章发布时间 span 标签
//    l.district = [districtElement stringValue]; // 获取 项目区域
//    
//    ONOXMLElement *dateElement = [element firstChildWithXPath:@"td[6]"]; // 根据 XPath 获取文章发布时间 span 标签
//    l.date = [dateElement stringValue];  // 获取 预售证发布日期
    
}
*/

- (NSMutableArray *)getEveryBuildingPage
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.buildingUrl]];//下载主页网页数据
    NSError *error;
    //NSLog(@"%@第一次",gbkData);
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@第二次",data);
    
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    //NSLog(@"%@",doc);
    
    ONOXMLElement *licenseParentElement = [doc firstChildWithXPath:@"//table[@width='100%']/tr/td/table"]; //寻找该 XPath 代表的 HTML 节点
    //SLog(@"%@",licenseParentElement);
    
    //遍历其子节点
    [licenseParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {
        
        License *license = [[License alloc] init];
        [license licenseWithHtmlStr:element];
        
        if (license.name) {
            [array addObject:license];
        }
    }];
    
    return array;
}

@end
