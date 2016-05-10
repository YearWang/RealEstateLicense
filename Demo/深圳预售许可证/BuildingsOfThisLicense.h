//
//  BuildingsOfThisLicense.h
//  深圳预售许可证
//
//  Created by 王岩 on 16/5/10.
//  Copyright © 2016年 OneYear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ONOXMLElement;

@interface BuildingsOfThisLicense : NSObject

@property (nonatomic, copy) NSString *everyBuildingName;

@property (nonatomic, copy) NSString *everyBuildingUrl;


- (void)buildingsWithHtmlStr:(ONOXMLElement *)element;

@end
