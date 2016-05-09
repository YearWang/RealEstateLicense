//
//  TypeInLicense.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/8.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "TypeInLicense.h"
#import <Ono.h>

@implementation TypeInLicense

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.kind = [aDecoder decodeObjectForKey:@"Type"];
        self.area = [aDecoder decodeObjectForKey:@"Area"];
        self.household = [aDecoder decodeIntegerForKey:@"Household"];

    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.kind forKey:@"Type"];
    [aCoder encodeObject:self.area forKey:@"Area"];
    [aCoder encodeInteger:self.household forKey:@"Household"];
}

+ (instancetype)detailWithHtmlStr:(ONOXMLElement *)element
{
    TypeInLicense *t = [[TypeInLicense alloc] init];
    
    ONOXMLElement *typeElement = [element firstChildWithXPath:@"td[2]"]; // 根据 XPath 获取td[2]下含有文章标题的 a 标签
    t.kind = [typeElement stringValue]; // 获取 用途
    
    ONOXMLElement *areaElement = [element firstChildWithXPath:@"td[4]"]; // 根据 XPath 获取含有文章标题的 a 标签
    t.area = [areaElement stringValue]; // 获取 该用途面积
    
    ONOXMLElement *householdElement = [element firstChildWithXPath:@"td[6]"]; // 根据 XPath 获取含有文章标题的 a 标签
    t.household = [[householdElement stringValue] integerValue]; // 获取 该用途套数
    
    return t;
}


@end
