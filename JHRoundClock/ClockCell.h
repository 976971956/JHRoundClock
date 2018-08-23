//
//  ClockCell.h
//  JHRoundClock
//
//  Created by 李江湖 on 2018/8/23.
//  Copyright © 2018年 江湖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHTheClockView.h"
@interface ClockCell : UITableViewCell
@property (weak, nonatomic) IBOutlet JHTheClockView *clockview;

@end
