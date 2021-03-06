//
//  DateModel.m
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/4.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import "DateModel.h"
#import "License.h"
#import "LicenseDetail.h"
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
    NSLog(@"%@",path);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.licenses = [unarchiver decodeObjectForKey:@"Licenses"];
        [unarchiver finishDecoding];
        
    }else{
        
        self.licenses = [[NSMutableArray alloc] init];
        NSMutableArray *originalArray = [LicensesDownload getAllLicenses];
        self.licenses = originalArray;
        
        for (License *originalLicense in self.licenses)
        {
            
            //获得各个预售证的详情页信息
            LicenseDetail *detail = [[LicenseDetail alloc] init];
            [detail getLicenseDetailWithDetailUrl:originalLicense.detailUrl];
            
            // 给license的licenseDetail属性的各个属性赋值
            originalLicense.licenseDetail = detail;
            originalLicense.quantity      = detail.totalNumberOfHouseholds;

        }
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
