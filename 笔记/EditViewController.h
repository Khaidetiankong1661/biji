//
//  EditViewController.h
//  笔记
//
//  Created by hongbaodai on 2017/11/29.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoneBlock)(NSDictionary *dic);

@interface EditViewController : UIViewController

@property (nonatomic, copy) DoneBlock doneBlock;

@end
