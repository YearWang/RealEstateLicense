//
//  licensesDownload.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/7.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "LicensesDownload.h"
#import "License.h"
#import "TypeInLicense.h"
#import "BuildingDetail.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation LicensesDownload

+ (NSMutableArray *)getAllLicenses
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:licenseUrlStr]];//下载主页网页数据
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
        
        License *license = [License licenseWithHtmlStr:element];
        if (license.name) {
            [array addObject:license];
        }
    }];
    
    return array;
}


+ (NSMutableArray *)getLicenseDetailFromDetailUrl:(NSString *)url
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    LicenseDetail *licenseDetail = [[LicenseDetail alloc] init];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];//下载预售证详情页网页数据
    NSError *error;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];

    ONOXMLElement *detailParentElement = [doc firstChildWithXPath:@"//table[@bgcolor='#99CCFF']"]; //寻找该 XPath 代表的 HTML 节点
    
    ONOXMLElement *licenseKeyElement = [detailParentElement firstChildWithXPath:@"tr[2]/td[2]"];
    licenseDetail.licenseKey = [licenseKeyElement stringValue]; // 获取 预售证号
    
    ONOXMLElement *companyElement = [detailParentElement firstChildWithXPath:@"tr[3]/td[2]"];
    licenseDetail.company = [companyElement stringValue]; // 获取 开发商
    
    ONOXMLElement *locationElement = [detailParentElement firstChildWithXPath:@"tr[3]/td[4]"];
    licenseDetail.location = [locationElement stringValue]; // 获取 地址
    
    ONOXMLElement *numberOfBuildingsElement = [detailParentElement firstChildWithXPath:@"tr[4]/td[2]"];
    licenseDetail.numberOfBuildings = [numberOfBuildingsElement stringValue]; // 获取 批准动楼栋数
    
    ONOXMLElement *grossAreaElement = [detailParentElement firstChildWithXPath:@"tr[5]/td[4]"];
    licenseDetail.grossArea = [grossAreaElement stringValue]; // 获取 面积
    
    ONOXMLElement *dateElement = [detailParentElement firstChildWithXPath:@"tr[7]/td[2]"];
    licenseDetail.date = [dateElement stringValue]; // 获取 发证日期
    
    NSMutableArray *typesArray = [[NSMutableArray alloc] init];
    //遍历其子节点
    [detailParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {
        TypeInLicense *typeInLicense = [TypeInLicense detailWithHtmlStr:element];
        if (typeInLicense.household && typeInLicense.household != 0)
        {
            [typesArray addObject:typeInLicense];
        }
    }];
    
    for (NSUInteger i = [typesArray count]; i<5; i++) {
        TypeInLicense *typeInLicense = [[TypeInLicense alloc] init];
        typeInLicense.household = 0;
        [typesArray addObject:typeInLicense];
    }
    licenseDetail.allTypesInLicense = typesArray;

    [array addObject:licenseDetail];
    return array;
}

+ (NSMutableArray *)getBuildingsFromBuildingUrl:(NSString *)url
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];//下载项目楼座数据
    NSError *error;
    //NSLog(@"%@第一次",gbkData);
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@第二次",data);
    
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    //NSLog(@"%@",doc);
    
    ONOXMLElement *licenseParentElement = [doc firstChildWithXPath:@"//*[@id='DataList1']"]; //寻找该 XPath 代表的 HTML 节点
    //NSLog(@"%@",licenseParentElement);
    
    //遍历其子节点
    [licenseParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {
        
        BuildingDetail *building = [BuildingDetail buildingsWithHtmlStr:element];
        if (building.buildingName) {
            [array addObject:building];
        }
    }];
    
    return array;
}


@end
