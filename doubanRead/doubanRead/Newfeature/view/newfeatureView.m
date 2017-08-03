//
//  newfeatureView.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/13.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "newfeatureView.h"
#define newfeatureImageCount 3

@interface newfeatureView ()<UIScrollViewDelegate>

@end

@implementation newfeatureView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置scrollView的属性
        self.showsHorizontalScrollIndicator = NO ;
        self.showsVerticalScrollIndicator = NO ;
        self.bounces = NO ;
        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES ;
        self.delegate = self;
        self.frame = [UIScreen mainScreen].bounds;
        self.contentSize = CGSizeMake(newfeatureImageCount * ScreenWidth, ScreenHeight);
        [self setupUI];
      
    }
    return self;
}

#pragma mark 新特性界面ScrollView上添加2张图片
-(void)setupUI{
    
    for (int i = 0; i < newfeatureImageCount - 1; i++) {
        UIImageView *view = [[UIImageView alloc]init];
        NSString *imagename = [NSString stringWithFormat:@"%d",i+1];
        UIImage *image = [UIImage imageNamed:imagename];
        view.image = image;
        view.frame = CGRectMake(i * ScreenWidth, 0, ScreenWidth, ScreenHeight);
 
        [self addSubview:view];
    }

}


#pragma mark 监听滚动，最后一页滚动后，把自己移除
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x == (newfeatureImageCount - 1) * ScreenWidth ) {
        [self removeFromSuperview];
    }
    
}

//-(void)dealloc{
//    NSLog(@"newviewbye");
//}

@end
