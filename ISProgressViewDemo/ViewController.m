//
//  ViewController.m
//  ISProgressViewDemo
//
//  Created by mac on 16/11/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "ISProgressView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ISProgressView * progressView =[[ISProgressView alloc]initWithFrame:CGRectMake(10, 100, 150, 50) duration:10.f];
    
    progressView.clipsToBounds = YES;
    progressView.layer.cornerRadius = 20;
    progressView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.77 blue:0.18 alpha:1].CGColor;
    [progressView setProgressColor:[UIColor greenColor]];
    progressView.progress = 0.7;
    [self.view addSubview:progressView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
