//
//  CustomTableViewCell.m
//  笔记
//
//  Created by hongbaodai on 2017/11/29.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation CustomTableViewCell

+ (instancetype)customTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identi";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setDataWithDic:(NSDictionary *)dic
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        self.label.text = dic[@"str"];
        self.time.text = dic[@"time"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
