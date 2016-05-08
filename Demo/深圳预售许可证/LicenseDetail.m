//
//  LicenseDetail.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/4/30.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "LicenseDetail.h"

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


@end
