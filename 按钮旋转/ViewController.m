//
//  ViewController.m
//  按钮旋转
//
//  Created by GKLIFE-12 on 15/10/29.
//  Copyright © 2015年 GKLIFE-12. All rights reserved.
//

#import "ViewController.h"
#import "PlaceholderTextView.h"

#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 * M_PI)

typedef enum {
    RotateStateStop,
    RotateStateRunning,
}RotateState;

@interface ViewController ()
{
    //旋转角度
    CGFloat imageViewAngle;
    //旋转ImageView
    UIImageView *imageView;
    //旋转状态
    RotateState rotateState;
}

@property (weak, nonatomic) IBOutlet UISwitch *sw;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *textview;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"按钮旋转测试";
    [self buildBarButtonItem];
    
    self.sw.offImage = [UIImage imageNamed:@"12.png"];
    self.sw.tintColor = [UIColor orangeColor];
    
    self.textview.placeholder = @"请输入姓名";
    
}

-(void)buildBarButtonItem{
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon.png"]];
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.bounds = CGRectMake(0, 0, 40, 40);
    //设置视图为圆形
    imageView.layer.masksToBounds = YES;
    imageView.layer.contentsScale = 20.0f;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addSubview:imageView];
    [button addTarget:self action:@selector(animate) forControlEvents:UIControlEventTouchUpInside];
    imageView.center = button.center;
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barItem;
}

-(void)animate{
    //改变imageview的旋转状态
    if (rotateState == RotateStateStop) {
        rotateState = RotateStateRunning;
        [self rotateAnimate];
    }else{
        rotateState = RotateStateStop;
    }
    
    NSLog(@"%@",self.textview.text);
}

-(void)rotateAnimate{
    imageViewAngle += 50;
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(imageViewAngle));
    } completion:^(BOOL finished) {
        if (rotateState == RotateStateRunning) {
            [self rotateAnimate];
        }
    }];
}

@end
