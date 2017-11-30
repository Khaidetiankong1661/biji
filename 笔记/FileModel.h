//
//  FileModel.h
//  笔记
//
//  Created by hongbaodai on 2017/11/29.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject
/**
 写入内存

 @param arr 存入的数据
 */
+ (void)writeArrWithArr:(NSArray *)arr;

/**
 从内存中取出数据

 @return 存入的数据
 */
+ (NSArray *)returnArr;


@end
