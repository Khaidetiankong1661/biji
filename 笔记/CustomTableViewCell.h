//
//  CustomTableViewCell.h
//  笔记
//
//  Created by hongbaodai on 2017/11/29.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

+ (instancetype)customTableViewCellWithTableView:(UITableView *)tableView;

- (void)setDataWithArr:(NSString *)str;

@end
