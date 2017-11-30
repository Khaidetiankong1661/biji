//
//  FileModel.m
//  笔记
//
//  Created by hongbaodai on 2017/11/29.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "FileModel.h"

@implementation FileModel

+ (NSString *)returnFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {
        NSLog(@"没找到");
    }
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"Savedatas.plist"];
    return appFile;
}

+ (void)writeArrWithArr:(NSArray *)arr
{
    NSString *str = [FileModel returnFile];
    [[NSArray arrayWithArray:arr] writeToFile:str atomically:NO];
}

+ (NSArray *)returnArr
{
    NSMutableArray *saveDataArray=nil;
    NSString *str = [FileModel returnFile];

    if([[NSFileManager defaultManager] fileExistsAtPath:str]){
        saveDataArray = [NSMutableArray arrayWithContentsOfFile:str];
    } else{
        saveDataArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Savedatas" ofType:@"plist"]];
    }
    return [NSArray arrayWithArray:saveDataArray];
}


@end
