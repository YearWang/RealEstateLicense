//
//  License.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/29.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface License : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSString *company;

@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger quantity;

@end
