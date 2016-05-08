//
//  DateModel.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/4.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "DateModel.h"
#import "License.h"
#import "LicensesDownload.h"

@implementation DateModel

#pragma mark - 数据加载和保存

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Licenses.plist"];
}

- (void)saveLicenses
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.licenses forKey:@"Licenses"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadLicenses
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.licenses = [unarchiver decodeObjectForKey:@"Licenses"];
        [unarchiver finishDecoding];
    }else{
        self.licenses = [[NSMutableArray alloc] init];
        License *license;
        
        NSMutableArray *originalArray = [LicensesDownload getAllLicenses];
        for (LicensesDownload *originalLicense in originalArray) {
            license = [[License alloc] init];
            license.name = originalLicense.name;
            license.district = originalLicense.district;
            license.date = originalLicense.date;
            license.company = originalLicense.company;
            
            //把两行代码合成了一行，是为了不要再次引入 #import “LicenseDetail”，直接把得到的一个 licenseDetail类放入数组
            NSMutableArray *array = [LicensesDownload getLicenseDetailFromDetailUrl:originalLicense.detailUrl];
            license.licenseDetail = [array firstObject];
            
            [self.licenses addObject:license];
        }
        
        
        //    for (License *license in _licenses) {
        //        BuildingDetail *building1 = [[BuildingDetail alloc] init];
        //        BuildingDetail *building2 = [[BuildingDetail alloc] init];
        //        building1.buildingName = [NSString stringWithFormat:@"1Buildings of %@",license.name];
        //        building2.buildingName = [NSString stringWithFormat:@"2Buildings of %@",license.name];
        //        [license.buildings addObject:building1];
        //        [license.buildings addObject:building2];
        //    }
    }
}


#pragma maik - init初始化

- (instancetype)init
{
    if (self = [super init]) {
        [self loadLicenses];
    }
    return self;
}

@end
