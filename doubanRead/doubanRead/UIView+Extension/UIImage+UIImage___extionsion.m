//
//  UIImage+UIImage___extionsion.m
//  dd
//
//  Created by 杜守鹏 on 16/1/21.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "UIImage+UIImage___extionsion.h"

@implementation UIImage (UIImage___extionsion)

+(UIImage *)initwithpic:(NSString *)name{
    
//    UIImageView *view = [[UIImageView alloc]init];
    
        UIImage *image = [UIImage imageNamed:name];

    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
//    view.tintColor = color;
    
    
    return image;
}
@end
