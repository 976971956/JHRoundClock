//
//  ViewController.m
//  JHRoundClock
//
//  Created by 江湖 on 2018/8/22.
//  Copyright © 2018年 江湖. All rights reserved.
//

#import "ViewController.h"
#import "JHTheClockView.h"
#import "ClockCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ClockCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    JHTheClockView *view = [[JHTheClockView alloc]initWithFrame:CGRectMake(10, 64, 355, 355)];
//    [self.view addSubview:view];
//    view.theDialColor = [UIColor redColor];
//    view.hourColor = [UIColor grayColor];
//    view.minuteColor = [UIColor greenColor];
//    view.secondColor = [UIColor cyanColor];
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClockCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.clockview.theDialColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        cell.clockview.hourColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        cell.clockview.minuteColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        cell.clockview.secondColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
