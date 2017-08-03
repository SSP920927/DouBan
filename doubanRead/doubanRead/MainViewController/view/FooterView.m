//
//  FooterView.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/31.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "FooterView.h"

@interface FooterView ()
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation FooterView

+(instancetype)footerView{
    
    FooterView *footer = [[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:nil options:0] lastObject];
    
    
    return footer;
}

-(void)awakeFromNib{
    self.clearButton.layer.cornerRadius = 18;
    self.clearButton.layer.borderWidth = 2;
    self.clearButton.layer.masksToBounds = YES;
    self.clearButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
}

- (IBAction)didClickClearButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(footerView:didClickButton:)]) {
        [self.delegate footerView:self didClickButton:button];
    }
}

@end
