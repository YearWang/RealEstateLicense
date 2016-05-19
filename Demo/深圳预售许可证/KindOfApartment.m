//
//  KindOfApartment.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/13.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "KindOfApartment.h"

@implementation KindOfApartment

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.numberOfTheKind       = [aDecoder decodeObjectForKey:@"NumberOfTheKind"];
        self.averagePriceOfTheKind = [aDecoder decodeFloatForKey:@"AveragePriceOfTheKind"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.numberOfTheKind      forKey:@"NumberOfTheKind"];
    [aCoder encodeFloat:self.averagePriceOfTheKind forKey:@"AveragePriceOfTheKind"];
}

@end
