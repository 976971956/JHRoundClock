//
//  TheClockView.m
//  BezierPathTexst
//
//  Created by 李江湖 on 2018/8/22.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import "JHTheClockView.h"

#define ViewWidth self.bounds.size.width
#define ViewHeight self.bounds.size.height
//半径
#define ViewR ((ViewHeight/2)-0)
#define angle2RADIAN(X) ((X)/180.0*M_PI)
@interface JHTheClockView ()
@property(nonatomic,strong) CALayer *bgLayer;

@property(nonatomic,strong) CAShapeLayer *hoursLayer;
@property(nonatomic,strong) CAShapeLayer *minuteLayer;
@property(nonatomic,strong) CAShapeLayer *secondLayer;
@property(nonatomic,strong) CATextLayer *textLayer;
@property(nonatomic,strong) NSTimer *timer;

@end
@implementation JHTheClockView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.theDialColor = [UIColor blackColor];
        self.hourColor = [UIColor blackColor];
        self.minuteColor = [UIColor blueColor];
        self.secondColor = [UIColor redColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(upDate) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.theDialColor = [UIColor blackColor];
        self.hourColor = [UIColor blackColor];
        self.minuteColor = [UIColor blueColor];
        self.secondColor = [UIColor redColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(upDate) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];

        self.theDialColor = [UIColor blackColor];
        self.hourColor = [UIColor blackColor];
        self.minuteColor = [UIColor blueColor];
        self.secondColor = [UIColor redColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(upDate) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}
-(void)addUI{
    
    CGPoint center = CGPointMake(ViewWidth*0.5, ViewHeight*0.5);

    //60格分针刻度
    CAShapeLayer *smillLayer = [CAShapeLayer layer];
    UIBezierPath *smillpath = [UIBezierPath bezierPath];
    for (int i = 0 ; i<60; i++) {
        CGPoint pos = [self getRoundPointR:ViewR angle:-90+6*i];
        CGPoint pos1 = [self getRoundPointR:ViewR-5 angle:-90+6*i];
        [smillpath moveToPoint:CGPointMake(pos.x, pos.y)];
        [smillpath addLineToPoint:CGPointMake(pos1.x, pos1.y)];
    }
    smillLayer.path = smillpath.CGPath;
    smillLayer.lineWidth = 1;
    smillLayer.strokeColor = self.theDialColor.CGColor;
    smillLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:smillLayer];
    
//    12格时针刻度和标识
    CAShapeLayer *momentLayer = [CAShapeLayer layer];
    UIBezierPath *momentpath = [UIBezierPath bezierPath];
    NSArray *arr = @[@"12",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
    for (int i = 0 ; i<arr.count; i++) {
//        刻度
        CGPoint pos = [self getRoundPointR:ViewR angle:-90+30*i];
        CGPoint pos1 = [self getRoundPointR:ViewR-8 angle:-90+30*i];
        
        [momentpath moveToPoint:CGPointMake(pos.x, pos.y)];
        [momentpath addLineToPoint:CGPointMake(pos1.x, pos1.y)];
//       标识
        CGPoint pos2 = [self getRoundPointR:ViewR-16 angle:-90+30*i];
        NSString *str = arr[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
        CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]};
        [str drawAtPoint:CGPointMake(pos2.x-size.width/2, pos2.y-7) withAttributes:dict];
    }
    momentLayer.path = momentpath.CGPath;
    momentLayer.lineWidth = 2;
    momentLayer.strokeColor = self.theDialColor.CGColor;
    momentLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:momentLayer];
//    表盘外圆
    CAShapeLayer *backGroundLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:ViewR startAngle:-M_PI_2 endAngle:-M_PI_2+M_PI_2*4 clockwise:YES];
    backGroundLayer.path = path.CGPath;
    backGroundLayer.lineWidth = 1;
    backGroundLayer.strokeColor = self.theDialColor.CGColor;
    backGroundLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:backGroundLayer];
    
    
    CALayer *bgImageLayer = [CALayer layer];
    bgImageLayer.bounds = CGRectMake(0, 0, ViewWidth, ViewHeight);
    
    bgImageLayer.anchorPoint = CGPointMake(0.5, 0.5);
    bgImageLayer.position = CGPointMake(ViewWidth*0.5, ViewHeight*0.5);
    bgImageLayer.contents = (id)[UIImage imageNamed:@"钟表"].CGImage;
    
    [self.layer addSublayer:bgImageLayer];
    
}
-(void)addHours{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(5, 0)];
    [path addLineToPoint:CGPointMake(0, ViewR-(ViewR/2))];
    [path addLineToPoint:CGPointMake(10, ViewR-(ViewR/2))];
    [path closePath];
    CAShapeLayer *hoursLayer = [CAShapeLayer layer];
    hoursLayer.lineJoin = kCALineJoinRound;
    hoursLayer.anchorPoint = CGPointMake(0.5, 1);
    hoursLayer.position = CGPointMake(ViewWidth*0.5, ViewHeight*0.5);
    hoursLayer.bounds = CGRectMake(0, 0, 10, ViewR-(ViewR/2));
//    hoursLayer.backgroundColor = [UIColor blackColor].CGColor;
    hoursLayer.path = path.CGPath;
    hoursLayer.strokeColor = self.hourColor.CGColor;
    hoursLayer.fillColor = self.hourColor.CGColor;
    [self.layer addSublayer:hoursLayer];
    self.hoursLayer = hoursLayer;
}
-(void)addMinute{
    CGFloat weight = 8;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(weight/2, 0)];
    [path addLineToPoint:CGPointMake(0, ViewR-(ViewR/10))];
    [path addLineToPoint:CGPointMake(weight, ViewR-(ViewR/10))];
    [path closePath];
    CAShapeLayer *minuteLayer = [CAShapeLayer layer];
    minuteLayer.anchorPoint = CGPointMake(0.5, 1);
    minuteLayer.position = CGPointMake(ViewWidth*0.5, ViewHeight*0.5);
    minuteLayer.bounds = CGRectMake(0, 0, weight, ViewR-(ViewR/10));
    minuteLayer.path = path.CGPath;
    minuteLayer.strokeColor = self.minuteColor.CGColor;
    minuteLayer.fillColor = self.minuteColor.CGColor;
    [self.layer addSublayer:minuteLayer];
    self.minuteLayer = minuteLayer;
}
-(void)addSec{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.alignmentMode = @"center";
    textLayer.anchorPoint = CGPointMake(0.5, 0.5);
    textLayer.position = CGPointMake(ViewWidth*0.5, ViewHeight*0.5+40);
    textLayer.bounds = CGRectMake(0, 0, 100, 20);
    textLayer.string = @"00:00:00";
   
    
    textLayer.fontSize = 12;
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:textLayer];
    self.textLayer = textLayer;
    
    CGFloat weight = 6;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(weight/2, 0)];
    [path addLineToPoint:CGPointMake(0, ViewR-(ViewR/40))];
    [path addLineToPoint:CGPointMake(weight, ViewR-(ViewR/40))];
    [path closePath];
    CAShapeLayer *secondLayer = [CAShapeLayer layer];
    secondLayer.anchorPoint = CGPointMake(0.5, 1);
    secondLayer.position = CGPointMake(ViewWidth*0.5, ViewHeight*0.5);
    secondLayer.bounds = CGRectMake(0, 0, weight, ViewR-(ViewR/40));
    secondLayer.path = path.CGPath;
    secondLayer.strokeColor =self.secondColor.CGColor;
    secondLayer.fillColor = self.secondColor.CGColor;
    [self.layer addSublayer:secondLayer];
    self.secondLayer = secondLayer;
}
-(void)addCenter{
    CGFloat weight = 12;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(weight/2, weight/2) radius:weight/2 startAngle:-M_PI_2 endAngle:-M_PI_2+4*M_PI_2 clockwise:YES];
    [path closePath];

    CAShapeLayer *secondLayer = [CAShapeLayer layer];
    secondLayer.anchorPoint = CGPointMake(0.5, 0.5);
    secondLayer.position = CGPointMake(ViewWidth*0.5, ViewHeight*0.5);
    secondLayer.bounds = CGRectMake(0, 0, weight, weight);
    secondLayer.path = path.CGPath;
    secondLayer.strokeColor = [UIColor greenColor].CGColor;
    secondLayer.fillColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:secondLayer];

}
-(void)upDate{
    //获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compoents = [calendar components:NSCalendarUnitSecond|NSCalendarUnitMinute|NSCalendarUnitHour fromDate:[NSDate date]];
    CGFloat sec = compoents.second;
    CGFloat minute = compoents.minute;
    CGFloat hour = compoents.hour;
//    NSLog(@"%f:%f:%f",hour,minute,sec);
    CGFloat secondA = sec * 6;
    CGFloat minuteA = minute * 6;
//    算出时针一格旋转多少度
    CGFloat hourA = hour *30;
    hourA += minute * 0.5;
    self.secondLayer.transform = CATransform3DMakeRotation(angle2RADIAN(secondA), 0, 0, 1);
    self.minuteLayer.transform = CATransform3DMakeRotation(angle2RADIAN(minuteA), 0, 0, 1);
    self.hoursLayer.transform = CATransform3DMakeRotation(angle2RADIAN(hourA), 0, 0, 1);
    self.textLayer.string = [NSString stringWithFormat:@"%02.f:%02.f:%02.f",hour,minute,sec];
}
-(CGPoint)getRoundPointR:(CGFloat)r angle:(CGFloat)angle{
    CGPoint center = CGPointMake(ViewWidth*0.5, ViewHeight*0.5);
//    CGFloat r = ViewHeight/2;
//    CGFloat angle = -90+180;
    CGFloat x = center.x + r * cos(angle *(M_PI/180));
    CGFloat y = center.y + r * sin(angle *(M_PI/180));
    return CGPointMake(x, y);
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self addUI];
    [self addSec];
    [self addMinute];
    [self addHours];

    [self addCenter];
    

    [self upDate];

}

-(void)removeLayer{
    NSArray<CALayer *> *subLayers = self.layer.sublayers;
//    NSArray<CALayer *> *removedLayers = [subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//        return [evaluatedObject isKindOfClass:[CAShapeLayer class]];
//    }]];
    [subLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
}
-(void)upDateColor{
//    self.hoursLayer.strokeColor = self.hourColor.CGColor;
//    self.hoursLayer.fillColor = self.hourColor.CGColor;
//    self.minuteLayer.strokeColor = self.minuteColor.CGColor;
//    self.minuteLayer.fillColor = self.minuteColor.CGColor;
//    self.secondLayer.strokeColor =self.secondColor.CGColor;
//    self.secondLayer.fillColor = self.secondColor.CGColor;

}
-(void)setHourColor:(UIColor *)hourColor{
    _hourColor = hourColor;
    [self upDateColor];
}
-(void)setMinuteColor:(UIColor *)minuteColor{
    _minuteColor = minuteColor;
    [self upDateColor];

}
-(void)setSecondColor:(UIColor *)secondColor{
    _secondColor = secondColor;
    [self upDateColor];

}
-(void)setTheDialColor:(UIColor *)theDialColor{
    _theDialColor = theDialColor;
    [self upDateColor];

}
@end
