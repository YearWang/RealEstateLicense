//
//  DateModel.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/4.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "DateModel.h"
#import "License.h"

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
        self.licenses = [[NSMutableArray alloc] initWithCapacity:20];
        
            License *license;
        
            license = [[License alloc] init];
            license.name = @"中骏蓝湾翠岭花园一期";
            license.district = @"龙岗";
            license.date = [NSDate date];
            license.company = @"深圳泛亚房地产开发有限公司";
            license.price = 34521;
            license.quantity = 1450;
            [self.licenses addObject:license];
        
            license = [[License alloc] init];
            license.name = @"佳兆业中央广场三期";
            license.district = @"龙岗";
            license.date = [NSDate date];
            license.company = @"宝吉工艺品（深圳）有限公司";
            license.price = 12345;
            license.quantity = 380;
            [self.licenses addObject:license];
            [self saveLicenses];
        
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
