//
//  ZDbutton.h
//  xcdF
//
//  Created by 杜守鹏 on 16/1/28.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDbutton : UIView
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (nonatomic, copy) NSString *text;
//
+(instancetype)zdbutton;

@end
