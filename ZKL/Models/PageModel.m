//
//  PageModel.m
//  ZKL
//
//  Created by champagne on 15-3-26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "PageModel.h"

@implementation PageModel

+(PageModel *)initWithDict:(NSDictionary *)pageDict
{
    PageModel *page = [[PageModel init] alloc];
    page.currentPage = [[pageDict safeObjectForKey:@"currentPage"] integerValue];
    page.pageSize = [[pageDict safeObjectForKey:@"pageSize"] integerValue];
    page.total = [[pageDict safeObjectForKey:@"total"] integerValue];
    page.rows = pageDict[@"rows"];
    return page;
}

@end
