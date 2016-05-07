//
//  licensesDownload.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/7.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "licensesDownload.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation licensesDownload

+ (NSMutableArray *)getAllLicenses
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:licenseUrlStr]];//下载网页数据
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
        
        licensesDownload *license = [licensesDownload licenseWithHtmlStr:element];
        if (license.name) {
            [array addObject:license];
        }
    }];
    
    return array;
}

+ (instancetype)licenseWithHtmlStr:(ONOXMLElement *)element
{
    licensesDownload *l = [licensesDownload new];
    
    ONOXMLElement *detailElement = [element firstChildWithXPath:@"td[2]/a"]; // 根据 XPath 获取td[2]下含有文章标题的 a 标签
    l.detailUrl = [detailElement valueForAttribute:@"href"];//获取 预售证详情网址
    l.licenseKey = [detailElement stringValue]; // 获取预售证号码
    
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

- (NSMutableArray *)getLicenseDetailFromDetailUrl:(NSString *)url
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];//下载网页数据
    NSError *error;
    //NSLog(@"%@第一次",gbkData);
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@第二次",data);
    
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    //NSLog(@"%@",doc);
    
    ONOXMLElement *detailParentElement = [doc firstChildWithXPath:@"//table[@bgcolor='#99CCFF']"]; //寻找该 XPath 代表的 HTML 节点
    //NSLog(@"%@",detailParentElement);
    
    //遍历其子节点
    [detailParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {
        NSLog(@"%@",element);
        licensesDownload *licenseDetail = [licensesDownload detailWithHtmlStr:element];
        if (licenseDetail.household && ![licenseDetail.household isEqualToString:@"-- "]) {// containsString:@"居住、住宅，办公，公寓，商务公寓，商业，产业研发用房，商务办公，商业性办公"
            [array addObject:licenseDetail];
        }
    }];
    
    return array;
}

+ (instancetype)detailWithHtmlStr:(ONOXMLElement *)element
{
    licensesDownload *d = [licensesDownload new];
    
    ONOXMLElement *typeElement = [element firstChildWithXPath:@"td[2]"]; // 根据 XPath 获取td[2]下含有文章标题的 a 标签
    d.type = [typeElement stringValue]; // 获取 用途
    
    ONOXMLElement *areaElement = [element firstChildWithXPath:@"td[4]"]; // 根据 XPath 获取含有文章标题的 a 标签
    d.area = [areaElement stringValue]; // 获取 该用途面积
    
    ONOXMLElement *householdElement = [element firstChildWithXPath:@"td[6]"]; // 根据 XPath 获取含有文章标题的 a 标签
    d.household = [householdElement stringValue]; // 获取 该用途套数
    
    return d;
}

@end
