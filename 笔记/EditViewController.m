//
//  EditViewController.m
//  笔记
//
//  Created by hongbaodai on 2017/11/29.
//  Copyright © 2017年 wang. All rights reserved.
//

#define KW [UIScreen mainScreen].bounds.size.width
#define KH [UIScreen mainScreen].bounds.size.height

#import "EditViewController.h"
#import "FileModel.h"
#import <UserNotifications/UserNotifications.h>

@interface EditViewController ()<UITextViewDelegate>
{
    UILabel *labe;
    UIView *backView;
    
    CGFloat keyboardY;
    NSNumber *duration;
    NSNumber *curve;
    BOOL isShow;

}

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UITextView *texttView;

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation EditViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTextView];
    [self addBackView];
    [self addItemAction];
    
    [self.textView becomeFirstResponder];
    [self addNotifacation];
}

- (void)addNotifacation
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

/**
 键盘弹出
 */
- (void)keyboardWillShow:(NSNotification *)noti
{
    if (!keyboardY) {
        NSDictionary *dic = [noti userInfo];
        NSValue *value = [dic objectForKey:UIKeyboardFrameEndUserInfoKey];
        keyboardY = value.CGRectValue.origin.y;
        duration = [dic objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        curve = [dic objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        [self showBackView];
    }
    if (isShow == NO) {
        [self showBackView];
    }
}

/**
 底部view出现
 */
- (void)showBackView
{
    isShow = YES;
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        CGRect fra = backView.frame;
        fra.origin.y = keyboardY - 40;
        
        backView.frame = fra;
    } completion:^(BOOL finished) {}];
}

/**
 底部view隐藏
 */
- (void)hideBackView
{
    isShow = NO;

    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        CGRect fra = backView.frame;
        fra.origin.y = KH - 40;
        
        backView.frame = fra;
    } completion:^(BOOL finished) {
    }];
}

/**
 添加底部view
 */
- (void)addBackView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSInteger cou = 313;
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, KH - 40, KW, cou)];

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, KW + 2, 40)];
    topView.layer.masksToBounds = YES;
    topView.layer.borderWidth = 0.5;
    topView.layer.borderColor = [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1].CGColor;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), KW, CGRectGetHeight(backView.frame) - CGRectGetHeight(topView.frame))];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(topView.frame))];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn setTitle:@"时间" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(topView.frame) - 60 - 5, 0, 60, CGRectGetHeight(topView.frame))];
    cancel.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [cancel setTitle:@"完成" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(commitClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancel];
    
    labe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, CGRectGetHeight(topView.frame))];
    CGPoint cen =  labe.center;
    labe.textAlignment = NSTextAlignmentCenter;
    cen.x = CGRectGetWidth(topView.frame) / 2;
    cen.y = CGRectGetHeight(topView.frame) / 2;

    labe.center = cen;
    labe.font = [UIFont systemFontOfSize:14.0f];
    labe.text = @"";
    [topView addSubview:labe];

    [bottomView addSubview:self.datePicker];
    self.datePicker.frame = CGRectMake(0, 0, KW, CGRectGetHeight(bottomView.frame));
    [backView addSubview:topView];
    [backView addSubview:bottomView];
    
    [self.view addSubview:backView];
    
}

- (void)addTextView
{
    UITextView *view = [[UITextView alloc] initWithFrame:CGRectMake(0, 65, KW, KH - 65)];
    view.delegate = self;
    
    self.texttView = view;
    
    [self.view addSubview:view];
}

- (void)addItemAction
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = left;
    
}

#pragma mark - UIBarButtonItem 点击事件
- (void)rightAction
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[FileModel returnArr]];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"str"] = self.texttView.text;
    NSString *time;
    if (labe.text.length > 0) {
        time = labe.text;
    } else {
        time = [self strWithDate];
    }
     
    dic[@"time"] = time;
    [arr insertObject:dic atIndex:0];
    
    [FileModel writeArrWithArr:arr];
    
    
    if (self.doneBlock) {
        self.doneBlock(dic);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftAction
{
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

/**
 datepicker值改变
 */
- (void)changeValue
{
    //获取挑选的日期
    NSDate *date =_datePicker.date;
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    //设定转换格式
    dateForm.dateFormat = @"yyy-MM-dd  HH:mm";
    //由当前获取的NSDate数据，转换为日期字符串，显示在私有成员变量_textField上
    labe.text = [dateForm stringFromDate:date];
    // 添加通知
    [self addNotifacion];
}

- (void)addNotifacion
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"记录事项通知";
    content.body = self.texttView.text;
    content.badge = @1;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    
    NSString *requertIdentifier = @"RequestIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger];
 
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error);
    }];
}

/**
 完成按钮
 */
- (void)commitClicked
{
    [self.view endEditing:YES];
    [self hideBackView];
}

/**
 时间按钮
 */
- (void)btnClicked:(UIButton *)but
{
    if ([but.titleLabel.text isEqualToString:@"时间"]) {
        [but setTitle:@"键盘" forState:UIControlStateNormal];
        [self.view endEditing:YES];
        
    } else if ([but.titleLabel.text isEqualToString:@"键盘"]) {
        [but setTitle:@"时间" forState:UIControlStateNormal];
        [self.texttView becomeFirstResponder];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

#pragma mark - 懒加载
- (UIDatePicker *)datePicker
{
    if (_datePicker == nil) {
        //创建DatePicker
        _datePicker = [[UIDatePicker alloc] init];
        //挑选显示日期的模式
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        //设置语言：中文
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //添加事件
        [_datePicker addTarget:self action:@selector(changeValue)forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
