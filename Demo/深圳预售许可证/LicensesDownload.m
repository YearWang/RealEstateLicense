//
//  licensesDownload.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/7.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "LicensesDownload.h"
#import "License.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation LicensesDownload

+ (NSMutableArray *)getAllLicenses
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:licenseUrlStr]];//下载主页网页数据
    NSError *error;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str    = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data         = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    ONOXMLDocument *doc  = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    
    ONOXMLElement *licenseParentElement = [doc firstChildWithXPath:@"//table[@width='100%']/tr/td/table"];
    
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
