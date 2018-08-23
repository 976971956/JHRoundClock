//
//  ViewController.m
//  JHRoundClock
//
//  Created by 江湖 on 2018/8/22.
//  Copyright © 2018年 江湖. All rights reserved.
//

#import "ViewController.h"
#import "JHTheClockView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JHTheClockView *view = [[JHTheClockView alloc]initWithFrame:CGRectMake(10, 64, 355, 355)];
    [self.view addSubview:view];
    view.theDialColor = [UIColor redColor];
    view.hourColor = [UIColor grayColor];
    view.minuteColor = [UIColor greenColor];
    view.secondColor = [UIColor cyanColor];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
