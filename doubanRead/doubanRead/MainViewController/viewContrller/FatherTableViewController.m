//
//  FatherTableViewController.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/27.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "FatherTableViewController.h"

@interface FatherTableViewController ()<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic, copy) NSString* TitleScrollViewY;
// 记录当前（开始拖拽时）tabbar的y值
@property (nonatomic, assign) CGFloat tabbarY;

// 记录tableview当前偏移量
@property (nonatomic, assign) CGFloat offsetY;
@end

@implementation FatherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.frame = CGRectMake(0, 0, 375, 667);
//    tv.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
//    self.view.backgroundColor = [UIColor lightGrayColor];
    //接受通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(giveTitleScrollViewY:) name:@"giveTitleScrollViewY" object:nil];}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"22";
    cell.detailTextLabel.text = @"33";

    return cell;
    
}

#pragma mark 监听滚动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getTitleScrollViewY" object:nil];
    self.offsetY = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offY = scrollView.contentOffset.y;
    if (!scrollView.isDragging) {
        return;
    }
    CGFloat delta = self.offsetY - offY ;
    CGFloat tabbarY = delta + self.tabbarY;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeTitleScrollViewFrame" object:nil userInfo:@{@"tabbarY":@(tabbarY)}];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
       CGFloat offY = scrollView.contentOffset.y;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"didEndDragging" object:nil userInfo:@{@"offY":@(offY)}];
}


-(void)giveTitleScrollViewY:(NSNotification *)notify{
    CGFloat titleY = [notify.userInfo[@"titleY"] floatValue];
    self.tabbarY = titleY;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
