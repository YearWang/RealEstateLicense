//
//  DateModel.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/4.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject

@property (nonatomic, strong) NSMutableArray *licenses;

- (void)saveLicenses;

@end
