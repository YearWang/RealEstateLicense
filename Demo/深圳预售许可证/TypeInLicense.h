//
//  TypeInLicense.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/8.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ONOXMLElement;


@interface TypeInLicense : NSObject <NSCoding>

@property (nonatomic, copy) NSString *kind;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, assign) NSUInteger household;

+ (instancetype)detailWithHtmlStr:(ONOXMLElement *)element;

@end
