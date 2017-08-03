//
//  MainController.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/14.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "MainController.h"
#import "NewfeatureController.h"
#import "titleSVModel.h"
#import "FatherTableViewController.h"
#import "EbooksViewController.h"
#import "MagazineViewController.h"
#import "SelfPublishingViewController.h"
#import "navigationbar.h"
#import "SearchTableView.h"
#import "ZDbutton.h"



@interface MainController ()<UIScrollViewDelegate>
@property (nonatomic, weak)  UIScrollView *contentScrollView;
@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UITableView *fatherView;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, strong) NSArray *buttonArr;
@property (nonatomic, weak) UITableView *searchView;
//存放titleSV解析的Plist
@property (nonatomic, strong) NSArray *titleSVArr;
@property (nonatomic, weak) ZDbutton *mulu;
@property (nonatomic, weak) ZDbutton *tushu;
@property (nonatomic, weak) ZDbutton *mine;
@property (nonatomic, weak) ZDbutton *bendi;
@property (nonatomic, assign) NSInteger muluIndex;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MainController

-(NSArray *)buttonArr{
    if (_buttonArr == nil) {
        _buttonArr = [NSArray array];
    }
    return _buttonArr;
}

-(NSArray *)titleSVArr{
    if (_titleSVArr == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"titleSV.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            titleSVModel *model = [titleSVModel titleSVWithDict:dic];
            [tempArr addObject:model];
        }
        _titleSVArr = tempArr;
    }
    return _titleSVArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchBar];
    [self setupContentScrollView];
    [self setupChildController];
    [self setuptitleSV];
    [self setupLeftDownButton];
    [self setupNewFeature];
    [self getNotice];
    [self changeChildController:(UIButton *)self.buttonArr[1]];
    [self didClickMulu];
}


#pragma mark 添加左下角导航按钮
-(void)setupLeftDownButton{
    // 本地
    ZDbutton *bendi = [ZDbutton zdbutton];
    bendi.frame = CGRectMake(190, 580, 50, 76);
    bendi.text = @"本地";
    UIImage *bendiImage = [UIImage initwithpic:@"ic_reading"];
    bendi.tintColor = [UIColor whiteColor];
      bendi.iconButton.backgroundColor = [UIColor colorWithRed:135 /255.0 green:211/255.0 blue:191/255.0 alpha:1];
    [bendi.iconButton setImage:bendiImage forState:UIControlStateNormal];
    self.bendi = bendi;
    [self.view addSubview:bendi];
    //我的
    ZDbutton *mine = [ZDbutton zdbutton];
    mine.frame = CGRectMake(130, 580, 50, 76);
    mine.text = @"我的";
    UIImage *mineImage = [UIImage initwithpic:@"ic_mine"];
    mine.tintColor = [UIColor whiteColor];
      mine.iconButton.backgroundColor = [UIColor colorWithRed:135 /255.0 green:211/255.0 blue:191/255.0 alpha:1];
    [mine.iconButton setImage:mineImage forState:UIControlStateNormal];
    self.mine = mine;
    [self.view addSubview:mine];
    //图书
    ZDbutton *tushu = [ZDbutton zdbutton];
    tushu.frame = CGRectMake(70, 580, 50, 76);
    tushu.text = @"图书";
    UIImage *tushuImage = [UIImage initwithpic:@"ic_store"];
      tushu.iconButton.backgroundColor = [UIColor colorWithRed:135 /255.0 green:211/255.0 blue:191/255.0 alpha:1];
    tushu.tintColor = [UIColor whiteColor];
    [tushu.iconButton setImage:tushuImage forState:UIControlStateNormal];
    self.tushu = tushu;
    [self.view addSubview:tushu];
    //目录
    ZDbutton *mulu = [ZDbutton zdbutton];
    mulu.frame = CGRectMake(10, 580, 50, 76);
    self.muluIndex = 0;
    
    UIImage *muluNomalImage = [UIImage initwithpic:@"ic_nav_close"];
    mulu.tintColor = [UIColor whiteColor];
    [mulu.iconButton setImage:muluNomalImage forState:UIControlStateNormal];
     mulu.iconButton.backgroundColor = [UIColor colorWithRed:135 /255.0 green:211/255.0 blue:191/255.0 alpha:1];
    self.mulu = mulu;
    
    [mulu.iconButton addTarget:self action:@selector(didClickMulu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mulu];
}

/**目录点击事件*/
-(void)didClickMulu{
    
    if (self.muluIndex == 0) {
        [self.timer invalidate];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.bendi.x = 10;
            self.bendi.alpha = 0;
            
            self.mine.x = 10;
            self.mine.alpha = 0;
            
            self.tushu.x = 10;
            self.tushu.alpha = 0;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.mulu.iconButton.st_nomalImage(@"ic_nav");
                 self.mulu.iconButton.backgroundColor = [UIColor colorWithRed:137 /255.0 green:174/255.0 blue:189/255.0 alpha:1];
            });
        }];
        
        self.muluIndex = 1;
    }else{
//        [self.timer invalidate];
        [UIView animateWithDuration:0.2 animations:^{
            self.bendi.x = 190;
            self.bendi.alpha = 1;
            
            self.mine.x = 130;
            self.mine.alpha = 1;
            
            self.tushu.x = 70;
            self.tushu.alpha = 1;
            
            self.mulu.iconButton.st_nomalImage(@"ic_nav_close");
            
             self.mulu.iconButton.backgroundColor = [UIColor colorWithRed:135 /255.0 green:211/255.0 blue:191/255.0 alpha:1];
        }];
        self.muluIndex = 0;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(huishou) userInfo:nil repeats:NO];
        self.timer = timer;
   
    }
    
}

-(void)huishou{
    if (self.muluIndex == 0) {
        [self didClickMulu];
    }
    
}

#pragma mark 添加搜索框
-(void)setupSearchBar{
    navigationbar *bar = [navigationbar searchView];
    bar.frame = CGRectMake(0, 0, 375, 44);
    self.navigationItem.titleView = bar;
  
}

#pragma mark 接受通知\实现通知方法
-(void)getNotice{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTitleScrollViewY) name:@"getTitleScrollViewY" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTitleScrollViewFrame:) name:@"changeTitleScrollViewFrame" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didEndDragging:) name:@"didEndDragging" object:nil];


    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pull) name:@"pull" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(push) name:@"push" object:nil];
}

-(void)didEndDragging:(NSNotification*)notify{
    
    CGFloat offY = [notify.userInfo[@"offY"] floatValue];
    
    if (offY > 0 ) {
        if (self.titleScrollView.y < kTabbarMid) {
            [UIView animateWithDuration:0.25 animations:^{
                
                self.titleScrollView.y = kTabbarHiddenY;
            } completion:^(BOOL finished) {
                
                self.titleScrollView.hidden = YES;
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                
                self.titleScrollView.y = kTabbarShowY;
            }];
        }
    }else{
        return;
        
    }
}

-(void)changeTitleScrollViewFrame:(NSNotification *)notify{
    
    CGFloat tabbarY = [notify.userInfo[@"tabbarY"] floatValue];
    self.titleScrollView.y = tabbarY;
    self.titleScrollView.hidden = NO;
    if (self.titleScrollView.y >= kTabbarShowY) {
        self.titleScrollView.y = kTabbarShowY;
    } else if (self.titleScrollView.y <= kTabbarHiddenY) {
        self.titleScrollView.y = kTabbarHiddenY;
        self.titleScrollView.hidden = YES;
    }
}

-(void)getTitleScrollViewY{
    CGFloat titleY = self.titleScrollView.y;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"giveTitleScrollViewY" object:nil userInfo:@{@"titleY":@(titleY)}];   
}

-(void)pull{
    SearchTableView *view = [[SearchTableView alloc]init];
    self.searchView = view;
    [self.view addSubview:view];
    
}

-(void)push{
    
    [self.searchView removeFromSuperview];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark 添加子控制器

-(void)setupChildController{
    SelfPublishingViewController *spVc = [[SelfPublishingViewController alloc]init];
    spVc.title = @"自出版";
    [self addChildViewController:spVc];
    
    EbooksViewController *ebkVc = [[EbooksViewController alloc]init];
    spVc.title = @"图书";
    [self addChildViewController:ebkVc];
    
    MagazineViewController *mgzVc = [[MagazineViewController alloc]init];
    spVc.title = @"杂志";
    [self addChildViewController:mgzVc];
}


#pragma mark 设置contentScrollView，用来放置子控制器
-(void)setupContentScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
//    scrollView.backgroundColor = [UIColor yellowColor];
    scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(TitleCounts * ScreenWidth, 0);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.contentScrollView = scrollView;
}


#pragma mark 设置titleScrollView
-(void)setuptitleSV{

    UIScrollView *titleScrollView = [[UIScrollView alloc]init];
    
    titleScrollView.frame = CGRectMake(0, 64,ScreenWidth , 35);
    CGFloat buttonW = ScreenWidth  /  TitleCounts;
    NSMutableArray *arr = [NSMutableArray array];
    //添加按钮
    for (int i = 0; i<self.titleSVArr.count; i++) {
        titleSVModel *model = self.titleSVArr[i];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 1000 + i;
        btn.st_nomalTitle(model.name).st_nomalImage(model.image)  ;
        btn.st_backgroundColor([UIColor lightGrayColor]);
        btn.st_nomalTitleColor([UIColor greenColor]).st_selectedTitleColor([UIColor purpleColor]);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.frame = CGRectMake(i * buttonW, 0, buttonW, titleScrollView.height);
        [btn addTarget:self action:@selector(changeChildController:) forControlEvents:UIControlEventTouchUpInside];
        [arr addObject:btn];
        
        [titleScrollView addSubview:btn];
    }
         self.buttonArr = arr;
         self.titleScrollView = titleScrollView;
        [self.view addSubview:titleScrollView];
 
}

//button点击方法实现

-(void)changeChildController:(UIButton *)btn{

    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;
        NSInteger index = btn.tag - 1000;
    CGPoint  offset = self.contentScrollView.contentOffset;
    offset.x = index * ScreenWidth;
    [self.contentScrollView setContentOffset:offset animated:YES];

}

#pragma mark  添加新特性页面
-(void)setupNewFeature{
    //添加containerView
    self.navigationController.view.backgroundColor = [UIColor redColor];
    NewfeatureController *newfc = [[NewfeatureController alloc]init];
    [self.navigationController addChildViewController:newfc];
    [self.navigationController.view addSubview:newfc.view];
    
    [newfc removeFromParentViewController];
    
}


-(void)did{
    NSLog(@"22");
}


#pragma mark uiscrollViewDelegate
//结束动画（进入界面就会调用）
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    CGFloat width = scrollView.width;
    CGFloat height = scrollView.height;
    CGFloat offsetX = scrollView.contentOffset.x ;
    NSInteger index = offsetX / width;
        self.selectedButton.selected = NO;
    UIButton *btn =(UIButton *)self.buttonArr[index];
      btn.selected = YES;
    self.selectedButton = btn;
    
    UITableViewController *willShowVc = (UITableViewController *)self.childViewControllers[index];
 
    if ([willShowVc isViewLoaded]) {
        return;
    }
    willShowVc.tableView.frame = CGRectMake(offsetX, 0, width, height);
    willShowVc.tableView.contentInset = UIEdgeInsetsMake(35, 0, 64, 0);
    [scrollView addSubview:willShowVc.view];
    
}
//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view addSubview:self.titleScrollView];
    self.titleScrollView.y = 64;
    
}
//减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
@end
