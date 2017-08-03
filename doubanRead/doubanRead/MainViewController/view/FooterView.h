//
//  FooterView.h
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/31.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FooterView;

@protocol FooterViewDelgate <NSObject>

- (void)footerView:(FooterView *)footerView didClickButton:(UIButton *)button;

@end

@interface FooterView : UIView

@property (nonatomic, weak) id<FooterViewDelgate>delegate;

+(instancetype)footerView;

@end
