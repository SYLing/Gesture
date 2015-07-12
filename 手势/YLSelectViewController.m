//
//  YLSelectViewController.m
//  手势
//
//  Created by 邵银岭 on 15/7/12.
//  Copyright (c) 2015年 邵银岭. All rights reserved.
//

#import "YLSelectViewController.h"
#import "ViewController.h"

@interface YLSelectViewController ()
@property (assign, nonatomic)int sign;

@end

@implementation YLSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)select:(UIButton *)sender {
    
    self.sign = (int)sender.tag;

    [self performSegueWithIdentifier:@"selectGesture" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ViewController *gestureVC = segue.destinationViewController;

    gestureVC.sign = self.sign;
}

@end
