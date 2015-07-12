//
//  ViewController.m
//  手势
//
//  Created by 邵银岭 on 15/7/12.
//  Copyright (c) 2015年 邵银岭. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+XMG.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //判断按钮
    switch (self.sign) {
        case 1:
            
            [self rotation];
            self.navigationItem.title = @"旋转";
            break;
            
        case 2:
            self.navigationItem.title = @"拉伸";
            [self expandContract];
            break;
            
        case 3:
            self.navigationItem.title = @"旋转和拉伸";
            [self expandContract];
            [self rotation];
            break;
            
        case 4:
            self.navigationItem.title = @"轻扫";
            [self swipe];
            break;
            
        case 5:
            self.navigationItem.title = @"拖拽";
            [self pan];
            break;
  
        case 6:
            self.navigationItem.title = @"长按";
            [self setUpLongPress];
            break;
            
        case 7:
            self.navigationItem.title = @"各种搞";
            [self setUpLongPress];
            [self pan];
            [self swipe];
            [self rotation];
            [self expandContract];
            break;

        default:
            break;
    }
}
/**
 *  长按
 */
- (void)setUpLongPress
{
    UILongPressGestureRecognizer *longPres = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
    [_imageView addGestureRecognizer:longPres];
}

// 这个方法调用频率跟随手指的变化,最少调用2次
- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [MBProgressHUD showSuccess:@"别按了" toView:self.view];
    }
    
    
}

/**
 *  拖拽
 */
- (void)pan
{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panges:)];
    [_imageView addGestureRecognizer:pan];
}
- (void)panges:(UIPanGestureRecognizer *)pan
{
    // 获取手指偏移量，相对于最原始位置的偏移量
    CGPoint transP = [pan translationInView:_imageView];
    // 改imageView形变
    _imageView.transform = CGAffineTransformTranslate(_imageView.transform, transP.x, transP.y);
    // 复位，相对于上一次
    [pan setTranslation:CGPointZero inView:_imageView];
}
/**
 *  轻扫
 *  轻扫默认的方向：向右
 *  一个轻扫手势只能支持一个方向
 *  一个控件可以添加很多手势
 */
- (void)swipe
{
    //轻扫默认的方向：向右
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizer:)];
    [self.imageView addGestureRecognizer:swipeGesture];
    
    //向左
    UISwipeGestureRecognizer *otherSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizer:)];
    otherSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:otherSwipeGesture];
}

- (void)swipeGestureRecognizer:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [MBProgressHUD showMessage:@"向左轻扫"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }else{
        [MBProgressHUD showMessage:@"向右轻扫"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }
}
/**
 *  多手势
 *
 *  如果返回yes，表示同时支持很多手势
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/**
 *  旋转  需要代理
 */
- (void)rotation
{
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    
    rotation.delegate = self;
    
    [self.imageView addGestureRecognizer:rotation];

}
- (void)rotation:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotationGestureRecognizer.rotation);
    // 复位
    rotationGestureRecognizer.rotation = 0;
}
/**
 *  拉伸 需要代理
 */
- (void)expandContract
{
    
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pin:)];
    pin.delegate = self;
    
    [self.imageView addGestureRecognizer:pin];
}
- (void)pin:(UIPinchGestureRecognizer *)pin
{
    CGFloat pinScale = pin.scale;
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinScale, pinScale);
    //复位
    pin.scale = 1;
    
}
@end
