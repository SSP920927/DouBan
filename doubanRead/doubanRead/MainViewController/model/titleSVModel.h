//
//  titleSVModel.h
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/24.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface titleSVModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;

-(instancetype)initWithSV:(NSDictionary *)dict;
+(instancetype)titleSVWithDict:(NSDictionary *)dict;

@end
