//
//  ZDbutton.m
//  xcdF
//
//  Created by 杜守鹏 on 16/1/28.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "ZDbutton.h"

@interface ZDbutton ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZDbutton

+(instancetype)zdbutton{
    ZDbutton *view = [[[NSBundle mainBundle]loadNibNamed:@"ZDbutton" owner:nil options:0]lastObject];

    return view;
}

-(void)setText:(NSString *)text{
    _text = text;
    self.titleLabel.text = text;
    
    self.titleLabel.hidden = [text isEqualToString:@""];
    
}

-(void)awakeFromNib{
    self.iconButton.layer.cornerRadius = 23;
    self.iconButton.layer.masksToBounds = YES;
    self.iconButton.layer.borderColor = [[UIColor whiteColor]CGColor];;
    self.iconButton.layer.borderWidth = 2;
    
    self.titleLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.cornerRadius = 10;
    self.titleLabel.layer.masksToBounds = YES;
  
}
//- (void)drawRect:(CGRect)rect {
//  // 画圆 // 1.获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 2.画圆
//    CGContextAddEllipseInRect(ctx, CGRectMake(2, 28, 46, 46));
//    [[UIColor whiteColor] set];
//    CGContextSetLineWidth(ctx, 2);
//    //3.渲染
//    CGContextStrokePath(ctx);
//}


@end
