//
//  NewfeatureController.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/13.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "NewfeatureController.h"
#import "newfeatureView.h"

@interface NewfeatureController ()

@end

@implementation NewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    //将newfeature界面传给控制器
    self.view = [[newfeatureView alloc]init];

}
//
//-(void)dealloc{
//    
//    NSLog(@"newcontroller bye");
//}

@end
