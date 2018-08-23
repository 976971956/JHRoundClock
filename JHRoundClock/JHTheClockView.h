//
//  TheClockView.h
//  BezierPathTexst
//
//  Created by 李江湖 on 2018/8/22.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHTheClockView : UIView
//表盘颜色
@property(nonatomic,strong) UIColor *theDialColor;
//时针颜色
@property(nonatomic,strong) UIColor *hourColor;
//分针颜色
@property(nonatomic,strong) UIColor *minuteColor;
//秒针颜色
@property(nonatomic,strong) UIColor *secondColor;

@end
