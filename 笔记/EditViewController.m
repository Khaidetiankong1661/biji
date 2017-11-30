//
//  EditViewController.m
//  笔记
//
//  Created by hongbaodai on 2017/11/29.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "EditViewController.h"
#import "FileModel.h"

@interface EditViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation EditViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (IBAction)doneAction:(UIBarButtonItem *)sender
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[FileModel returnArr]];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"str"] = self.textView.text;
    
    dic[@"time"] = [self strWithDate];
    [arr insertObject:dic atIndex:0];
    
    [FileModel writeArrWithArr:arr];
    [self.navigationController popViewControllerAnimated:YES];

}

- (NSString *)strWithDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd  HH:mm"];
    NSString *strfor = [formatter stringFromDate:date];
    return strfor;
}

- (IBAction)canCelAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
