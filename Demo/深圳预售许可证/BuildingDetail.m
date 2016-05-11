//
//  BuildingDetail.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/3.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "BuildingDetail.h"
#import <Ono.h>

static NSString *const licenseUrlStr = @"http://ris.szpl.gov.cn/bol/";

@implementation BuildingDetail

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.buildingName = [aDecoder decodeObjectForKey:@"BuildingName"];
        self.buildingNumber = [aDecoder decodeObjectForKey:@"BuildingNumber"];
        self.buildingMainType = [aDecoder decodeObjectForKey:@"BuildingMainType"];
        self.buildingHouseholdings = [aDecoder decodeIntegerForKey:@"BuildingHouseholdings"];
        self.buildingPrice = [aDecoder decodeIntegerForKey:@"BuildingPrice"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.buildingName forKey:@"BuildingName"];
    [aCoder encodeObject:self.buildingNumber forKey:@"BuildingNumber"];
    [aCoder encodeObject:self.buildingMainType forKey:@"BuildingMainType"];
    [aCoder encodeInteger:self.buildingHouseholdings forKey:@"BuildingHouseholdings"];
    [aCoder encodeInteger:self.buildingPrice forKey:@"BuildingPrice"];
}

@end
