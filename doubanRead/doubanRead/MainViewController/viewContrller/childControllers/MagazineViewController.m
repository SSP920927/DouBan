//
//  MagazineViewController.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/27.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "MagazineViewController.h"

@interface MagazineViewController ()

@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blueColor];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"杂志";
    cell.detailTextLabel.text = @"33";
    
    return cell;
    
}

@end
