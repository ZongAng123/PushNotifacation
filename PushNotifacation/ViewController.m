//
//  ViewController.m
//  PushNotifacation
//
//  Created by 纵昂 on 2017/3/3.
//  Copyright © 2017年 纵昂. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel * myMessWithLabel;
@property (nonatomic, strong) UIButton * button12;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myMessWithLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 345, 540, 18)];
    [self.view addSubview:_myMessWithLabel];
    self.button12 =[[UIButton alloc]initWithFrame:CGRectMake(241, 285, 119, 30)];
    self.button12.backgroundColor =[UIColor redColor];
    [self.button12 setTitle:@"发送本地通知" forState:UIControlStateNormal];
    [self.button12 addTarget:self action:@selector(pushBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button12];
    
    [self mySetDatailMess];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backgroundMessOpeartion) name:@"bgckMess" object:nil];
}
-(void)pushBtn:(UIButton *)sender{
    UILocalNotification *localNotifa=[[UILocalNotification alloc]init];
    
    localNotifa.alertBody=@"重大消息:微软把诺基亚品牌卖给了富士康!"; // 通知的内容
    localNotifa.soundName=@"buyao.wav"; //通知的声音
    localNotifa.alertAction=@":查看最新重大新闻"; // 锁屏的时候 相当于 滑动来::查看最新重大新闻
    //    localNotifa.alertTitle=@"弹出标题,我在这里";
    localNotifa.applicationIconBadgeNumber=3;
    localNotifa.fireDate=[NSDate dateWithTimeIntervalSinceNow:5.0]; // 触发通知的时间(5秒后发送通知)
    localNotifa.timeZone=[NSTimeZone defaultTimeZone];  // 设置时区
    localNotifa.repeatInterval=NSCalendarUnitDay; // 通知重复提示的单位，可以是天、周、月
    
    localNotifa.userInfo=@{@"detailMess":@"在移动业务一直没有起色的情况下,微软又要有所动作了,不过这次受害的不是Windows Phone,而是一直多灾多难的诺基亚。"};
    
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotifa]; // 调度通知(启动通知)
}
-(void)mySetDatailMess{
    AppDelegate *appdele=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myMessWithLabel.text=appdele.myMess;
}
#pragma mark 通知设置值
-(void)backgroundMessOpeartion{
    [self mySetDatailMess];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
