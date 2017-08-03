//
//  EbooksViewController.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/27.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "EbooksViewController.h"

@interface EbooksViewController ()

@end

@implementation EbooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor yellowColor];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"图书";
    cell.detailTextLabel.text = @"33";
    
    return cell;
    
}

@end
