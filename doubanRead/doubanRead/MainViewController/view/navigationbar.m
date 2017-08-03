//
//  navigationbar.m
//  导航栏
//
//  Created by 杜守鹏 on 16/1/18.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "navigationbar.h"



@interface navigationbar ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIButton *noticeButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *change;

@end

@implementation navigationbar

+(navigationbar *)searchView{
      navigationbar *bar = [[[NSBundle mainBundle]loadNibNamed:@"Empty" owner:nil options:0]lastObject];
    return bar;
}

-(void)awakeFromNib{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background"]];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UITextField *searchField=[((UIView *)[self.searchBar.subviews objectAtIndex:0]).subviews lastObject];
    searchField.layer.cornerRadius = 15;
    searchField.layer.masksToBounds = YES;
    self.searchBar.delegate = self;
    
    self.cancelButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self getNoticeFromeSearchCell];


}

#pragma mark 接受来自searchCell的通知，填充searchBar.text及滚动取消第一响应者
-(void)getNoticeFromeSearchCell{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickBookNameButton:) name:@"didClickBookNameButton" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endEdit) name:@"endEdit" object:nil];
}

-(void)endEdit{
    [self endEditing:YES];
    self.searchBar.text = @"";
}

-(void)didClickBookNameButton:(id)sender{
    
    NSDictionary *dict = [sender userInfo];
    NSString *str = dict[@"buttonText"];
    self.searchBar.text = str;
    [self searchBar:self.searchBar textDidChange:str];
    [self searchBarSearchButtonClicked:self.searchBar];

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
      self.noticeButton.alpha = 0;
    self.cancelButton.alpha = 1;
    [UIView animateWithDuration:1 animations:^{
      
         self.change.constant = 60;
    }];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pull" object:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    //发送请求，搜索相关书籍
//    NSLog(@"%@",searchText);
//    NSLog(@"---%@",self.searchBar.text);
    NSLog(@"发送请求给服务器进行搜索");
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    //发通知给searchTableView，进行数组操作
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeHistoryArr" object:nil userInfo:@{@"searchText":searchBar.text}];

     }


- (IBAction)didclickcancel:(id)sender {
    [self endEditing:YES];
    
    [UIView animateWithDuration:0 animations:^{
        self.noticeButton.alpha = 1;
        self.cancelButton.alpha = 0;
        self.change.constant = 45;
    }];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"push" object:nil];
    
}

@end
