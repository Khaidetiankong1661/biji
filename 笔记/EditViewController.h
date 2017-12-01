//
//  EditViewController.h
//  笔记
//
//  Created by hongbaodai on 2017/11/29.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 创建后回调 */
typedef void(^DoneBlock)(NSDictionary *dic);
/** 编辑后回调 */
typedef void(^EditDoneBlock)(NSDictionary *dic, NSInteger selectNu);

@interface EditViewController : UIViewController

@property (nonatomic, copy) DoneBlock doneBlock;
@property (nonatomic, copy) EditDoneBlock editDoneBlock;
/** 编辑数据 */
@property (nonatomic, strong) NSDictionary *dataDic;
/** 编辑行 */
@property (nonatomic, assign) NSInteger selectNum;


@end
