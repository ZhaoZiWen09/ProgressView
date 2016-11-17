//
//  ISProgressView.m
//  JiGuangVPN
//
//  Created by mac on 16/11/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ISProgressView.h"
#import <CoreText/CoreText.h>
@interface ISProgressView()

@property (nonatomic,strong)CALayer *progressLayer;
@property (nonatomic,strong)CALayer *surplusLayer;
@property (nonatomic,assign)CGFloat currentViewWidth;
@property (nonatomic) UIFont *font;

@end

@implementation ISProgressView

//- (instancetype)initWithFrame:(CGRect)frame progressColor:(CGColorRef *)progressColor backgroundColorColor:(CGColorRef *)backgroundColor textString:(NSString *)textString textFont:(UIFont *)textFont textColor:(CGColorRef *)textColor
- (instancetype)initWithFrame:(CGRect)frame duration:(CGFloat)duration
{
    self = [super initWithFrame:frame];
    if (self) {
        self.progressLayer = [CALayer layer];
        self.progressLayer.backgroundColor = [UIColor redColor].CGColor;
        self.progressLayer.frame = CGRectMake(0, 0, 0, frame.size.height);
        self.surplusLayer = [CALayer layer];
        self.surplusLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.surplusLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _font = [UIFont systemFontOfSize:20.];
        //储存当前view的宽度值
        self.currentViewWidth = frame.size.width;
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        scaleAnimation.duration=duration;
        scaleAnimation.removedOnCompletion = YES;
        scaleAnimation.timingFunction = defaultCurve;
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1];
        [self.progressLayer setAnchorPoint:CGPointMake(0, 0)];
        [self.progressLayer addAnimation:scaleAnimation forKey:@"animateTransform"];
        [self.layer addSublayer:self.progressLayer];
        
        dispatch_queue_t asyncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(asyncQueue, ^{
            //显示数字进度，具体自己可以修改
            for (int i = 0; i < 100; i ++) {
                NSString * numberStr = [NSString stringWithFormat:@"%d/%d",i,100];
                                [NSThread sleepForTimeInterval:duration/105];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    CATextLayer * text1 = [self createTextLayer:numberStr];
                    self.surplusLayer.sublayers = nil;
                    
                    [self.surplusLayer addSublayer:text1];
                });
            }
        });
        [self.layer addSublayer:self.surplusLayer];
    }
    return self;
}


- (CATextLayer*)createTextLayer:(NSString*)content {
    CATextLayer *text = [CATextLayer layer];
    CGRect bound = self.bounds;
    bound.origin.y = bound.origin.y + (bound.size.height - 30)/2;
    bound.origin.x = bound.size.width - 110;
    bound.size.height = 30.f;
    [text setFrame:bound];
    [text setString:(id)content];
    [text setAlignmentMode:@"center"];
    [text setFont:CTFontCreateWithName((__bridge CFStringRef)_font.fontName, _font.pointSize, NULL)];
    [text setFontSize:_font.pointSize];
    
    [text setForegroundColor:[UIColor whiteColor].CGColor];
    [text setContentsScale:[[UIScreen mainScreen] scale]];
    [text setBackgroundColor:[UIColor clearColor].CGColor];
    return text;
}

#pragma mark - 重写setter,getter方法

@synthesize progress = _progress;
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (progress <= 0) {
        self.progressLayer.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    }else if (progress <= 1) {
        self.progressLayer.frame = CGRectMake(0, 0, progress *self.currentViewWidth, self.frame.size.height);
    }else {
        self.progressLayer.frame = CGRectMake(0, 0, progress, self.frame.size.height);
    }
}

- (CGFloat)progress {
    return _progress;
}

@synthesize progressColor = _progressColor;
- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.backgroundColor = progressColor.CGColor;
}


- (UIColor *)progressColor {
    return _progressColor;
}

@end
