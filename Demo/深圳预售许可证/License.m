//
//  License.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/29.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "License.h"

@implementation License

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.district = [aDecoder decodeObjectForKey:@"District"];
        self.date = [aDecoder decodeObjectForKey:@"Date"];
        self.company = [aDecoder decodeObjectForKey:@"Company"];
        self.price = [aDecoder decodeIntegerForKey:@"Price"];
        self.quantity = [aDecoder decodeIntegerForKey:@"Quantity"];
        self.buildings = [aDecoder decodeObjectForKey:@"Buildings"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.district forKey:@"District"];
    [aCoder encodeObject:self.date forKey:@"Date"];
    [aCoder encodeObject:self.company forKey:@"Company"];
    [aCoder encodeInteger:self.price forKey:@"Price"];
    [aCoder encodeInteger:self.quantity forKey:@"Quantity"];
    [aCoder encodeObject:self.buildings forKey:@"Buildings"];
}



@end
