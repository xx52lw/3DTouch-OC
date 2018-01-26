//
//  PhoneInfoManager.h
//  3DTouch-OC
//
//  Created by 张星星 on 16/10/27.
//  Copyright © 2016年 张星星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneInfoManager : NSObject
/**
 *  获取设备型号
 *
 *  @return 设备型号
 */
+ (NSString *)getCurrentDeviceModel;

/**
 *  获取内存大小
 *
 *  @return 内存大小
 */
+ (double)logMemoryInfo;

/**
 *  获取使用空间
 *
 *  @return 使用空间
 */
+ (long long)freeDiskSpaceInBytes;
@end
