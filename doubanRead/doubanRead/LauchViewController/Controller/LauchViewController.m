//
//  LauchViewController.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/13.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "LauchViewController.h"
#import "NewfeatureController.h"

@interface LauchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *lauchLogo;
@property (weak, nonatomic) IBOutlet UILabel *banbenLabel;


@end

@implementation LauchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark 实现动画 让鸟起飞，label跟着跑，alpha变为1
-(void)viewDidAppear:(BOOL)animated{
    
   [UIView animateWithDuration:3 delay:0.6 usingSpringWithDamping:0.78 initialSpringVelocity:0 options:0 animations:^{
       self.lauchLogo.centerY = 180;
       self.banbenLabel.centerY = 180 + self.lauchLogo.height * 0.5 + 15 + self.banbenLabel.height *0.5; 
        self.banbenLabel.alpha = 1;
       [self.lauchLogo layoutIfNeeded];
       [self.banbenLabel layoutIfNeeded];
       
   } completion:^(BOOL finished) {
    //动画完成，给appdelegate发通知，切换控制器到NewfeatureController
       [[NSNotificationCenter defaultCenter]postNotificationName:@"changeRootControllerToMainController" object:nil];
//       UIWindow *win = [UIApplication sharedApplication].keyWindow;
//       win.rootViewController = [[NewfeatureController alloc ]init];
   }];
}





@end
