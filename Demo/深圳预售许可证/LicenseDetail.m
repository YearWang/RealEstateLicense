//
//  LicenseDetail.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/30.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "LicenseDetail.h"
#import "TypeInLicense.h"
#import <Ono.h>

@implementation LicenseDetail

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.location = [aDecoder decodeObjectForKey:@"Location"];
        self.company = [aDecoder decodeObjectForKey:@"Company"];
        self.licenseKey = [aDecoder decodeObjectForKey:@"LicenseKey"];
        self.date = [aDecoder decodeObjectForKey:@"Date"];
        self.grossArea = [aDecoder decodeObjectForKey:@"GrossArea"];
        self.numberOfBuildings = [aDecoder decodeObjectForKey:@"NumberOfBuildings"];
        
        self.allTypesInLicense = [aDecoder decodeObjectForKey:@"AllTypesInLicense"];
    
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.location forKey:@"Location"];
    [aCoder encodeObject:self.company forKey:@"Company"];
    [aCoder encodeObject:self.licenseKey forKey:@"LicenseKey"];
    [aCoder encodeObject:self.date forKey:@"Date"];
    [aCoder encodeObject:self.grossArea forKey:@"GrossArea"];
    [aCoder encodeObject:self.numberOfBuildings forKey:@"NumberOfBuildings"];
    
    [aCoder encodeObject:self.allTypesInLicense forKey:@"AllTypesInLicense"];
    
}



- (void)getLicenseDetailWithDetailUrl:(NSString *)url //获取该预售证的预售证相信信息,并把预售证详情赋给该预售证的licenseDetail属性
{
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];//下载预售证详情页网页数据
    NSError *error;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    
    ONOXMLElement *detailParentElement = [doc firstChildWithXPath:@"//table[@bgcolor='#99CCFF']"]; //寻找该 XPath 代表的 HTML 节点
    
    ONOXMLElement *licenseKeyElement = [detailParentElement firstChildWithXPath:@"tr[2]/td[2]"];
    self.licenseKey = [licenseKeyElement stringValue]; // 获取 预售证号
    
    ONOXMLElement *companyElement = [detailParentElement firstChildWithXPath:@"tr[3]/td[2]"];
    self.company = [companyElement stringValue]; // 获取 开发商
    
    ONOXMLElement *locationElement = [detailParentElement firstChildWithXPath:@"tr[3]/td[4]"];
    self.location = [locationElement stringValue]; // 获取 地址
    
    ONOXMLElement *numberOfBuildingsElement = [detailParentElement firstChildWithXPath:@"tr[4]/td[2]"];
    self.numberOfBuildings = [numberOfBuildingsElement stringValue]; // 获取 批准动楼栋数
    
    ONOXMLElement *grossAreaElement = [detailParentElement firstChildWithXPath:@"tr[5]/td[4]"];
    self.grossArea = [grossAreaElement stringValue]; // 获取 面积
    
    ONOXMLElement *dateElement = [detailParentElement firstChildWithXPath:@"tr[7]/td[2]"];
    self.date = [dateElement stringValue]; // 获取 发证日期
    
    NSMutableArray *typesArray = [[NSMutableArray alloc] init];
    //遍历其子节点
    [detailParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {
        TypeInLicense *typeInLicense = [TypeInLicense detailWithHtmlStr:element];
        if (typeInLicense.household && typeInLicense.household != 0)
        {
            self.totalNumberOfHouseholds += typeInLicense.household;
            [typesArray addObject:typeInLicense];
        }
    }];
    
    for (NSUInteger i = [typesArray count]; i<5; i++) {
        TypeInLicense *typeInLicense = [[TypeInLicense alloc] init];
        typeInLicense.household = 0;
        [typesArray addObject:typeInLicense];
    }
    self.allTypesInLicense = typesArray;
}





@end
