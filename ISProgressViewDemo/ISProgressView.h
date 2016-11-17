//
//  ISProgressView.h
//  JiGuangVPN
//
//  Created by mac on 16/11/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISProgressView : UIView
//@property (nonatomic,strong)CALayer *progressLayer;
/**
 //进度参数取值范围0.0~1.0
 */
@property (nonatomic,assign)CGFloat progress;//进度参数取值范围0.0~1.0

//@property (nonatomic,assign)CGFloat duration;
/**
 进度颜色，如果想改变背景色，直接改动ISProgressView.layer.backgroundColor
 */
@property (nonatomic,strong)UIColor *progressColor;//颜色

- (instancetype)initWithFrame:(CGRect)frame duration:(CGFloat)duration;
@end
