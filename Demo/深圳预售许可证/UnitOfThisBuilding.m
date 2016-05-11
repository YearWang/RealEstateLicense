//
//  UnitsOfThisBuilding.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/10.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "UnitOfThisBuilding.h"
#import "Apartment.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation UnitOfThisBuilding

- (void)UnitWithHtmlStr:(ONOXMLElement *)element unitNameByAppendingBuildingName:(NSString *)string//给该unit各属性赋值
{
    NSString *relativeUnitUrl = [element valueForAttribute:@"href"];//获取 预售证详情的相对URL
    self.unitUrl = [NSString stringWithFormat:@"%@%@",licenseUrlStr,relativeUnitUrl];
    
    self.buildingUnitName = [NSString stringWithFormat:@"%@-%@",string,[element stringValue]];//获取 预售证详情网址
}


- (NSMutableArray *)getApartments
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSData *gbkData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.unitUrl]];//下载主页网页数据
    NSError *error;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8Str = [[NSString alloc] initWithData:gbkData encoding:enc];
    NSData *data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    
    ONOXMLElement *apartmentParentElement = [doc firstChildWithXPath:@"//div[@id='divShowList']"]; //寻找该 XPath 代表的 HTML 节点
    //遍历其子节点
    [apartmentParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {

        [element.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *_Nonnull stop) {
            
            Apartment *apartment = [[Apartment alloc] init];
            [apartment apartmentWithHtmlStr:element];
            if (apartment.apartmentUrl) {
                [array addObject:apartment];
            }
            
        }];
        
    }];
    
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    NSMutableArray *array4 = [[NSMutableArray alloc] init];
    NSMutableArray *array5 = [[NSMutableArray alloc] init];
    

    for (Apartment *apartment in array) {
        if (!array1) {
            [array1 addObject:apartment];
        }else{
            if ([[array1[0] usage] isEqualToString:apartment.usage]) {
                [array1 addObject:apartment];
            }else{
                [array2 addObject:apartment];
            }
        }
    }
    return array;
}

@end
