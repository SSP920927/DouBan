//
//  SearchCell.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/31.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}
- (IBAction)didClickBookNameButton:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"didClickBookNameButton" object:self userInfo:@{@"buttonText":sender.titleLabel.text}];
    
}


@end
