//
//  titleSVModel.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/24.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "titleSVModel.h"

@implementation titleSVModel
-(instancetype)initWithSV:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}

+(instancetype)titleSVWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithSV:dict];
}
@end
