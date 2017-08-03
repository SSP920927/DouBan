//
//  SearchTableView.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/28.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "SearchTableView.h"
#import "FooterView.h"
#import "SearchCell.h"
#import "ZDTableViewCell.h"

@interface SearchTableView ()<UITableViewDelegate,UITableViewDataSource,FooterViewDelgate>

@property (nonatomic, strong) NSMutableArray *historyArr;

@end

@implementation SearchTableView

-(NSMutableArray *)historyArr{
    if (_historyArr == nil) {
        
        _historyArr = [NSMutableArray array];
        
    }
    return _historyArr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor greenColor];
        self.frame = [UIScreen mainScreen].bounds;
        self.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 163;
        self.rowHeight = UITableViewAutomaticDimension;

        [self getNoticeFromeNavigationbar];
   
    }
    return self;
}


#pragma mark 接受通知，改变历史数组
-(void)getNoticeFromeNavigationbar{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeHistoryArr:) name:@"changeHistoryArr"object:nil];

}

-(void)changeHistoryArr:(id)sender{
    NSDictionary *dict = [sender userInfo];
    NSString *str = dict[@"searchText"];
  
    
    for (int i = 0; i < self.historyArr.count; i++) {
        NSString *hisStr = self.historyArr[i];
        if ([str isEqualToString:hisStr]) {
            [self.historyArr removeObjectAtIndex:i];
        }
    }
    
    [self.historyArr insertObject:str atIndex:0];
    if(self.historyArr.count > 7){
        [self.historyArr removeObjectAtIndex:7];
    }
    [self reloadData];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark 设置footerView
-(void)setupFooterView{
    
    FooterView *footer = [FooterView footerView];
    footer.delegate = self;
    self.tableFooterView = footer;
    if (self.historyArr.count == 0) {
        self.tableFooterView.hidden = YES;
    }
}

-(void)footerView:(FooterView *)footerView didClickButton:(UIButton *)button{
    [self.historyArr removeAllObjects];
    [self reloadData];
}
#pragma mark 数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else {
        return self.historyArr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString *ID = @"searchCell";
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SearchCell" owner:nil options:0]lastObject];
        }
         return cell;
    }else {
        NSString *IDd = @"celld";
        ZDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDd];
        if (cell == nil) {
            cell = [[ZDTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDd];
        }
   
        cell.textLabel.text = self.historyArr[indexPath.row];
         return cell;
        
    }

   
}

// 组头文本
- (NSString *)tableView:(nonnull UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        tableView.backgroundColor = [UIColor whiteColor];
        return @"d222";
    }else{
        return @"ppp";
    }
}


#pragma mark 自定义headerView 用来显示白色
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建headerView
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0,0.0,ScreenWidth,100.0)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    // 显示名
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(5.0,5.0,ScreenWidth - 10,24.0);
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20.0];
    label.backgroundColor = [UIColor clearColor];
    if (section == 0) {
        label.text = @"热门搜索";
    }else{
        if (self.historyArr.count == 0) {
            view.hidden = YES;
        }
         label.text = @"搜索历史";
    }

    [view addSubview:label];
    
    return view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        FooterView *footer = [FooterView footerView];
        footer.delegate = self;
        self.tableFooterView = footer;
        if (self.historyArr.count == 0) {
            self.tableFooterView.hidden = YES;
        }
         return footer;
    }
   
   
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 36;
    }else{
        return 0;
    }
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"endEdit" object:nil];
}

@end
