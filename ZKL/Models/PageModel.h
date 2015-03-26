//
//  PageModel.h
//  ZKL
//
//  Created by champagne on 15-3-26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import "BaseViewController.h"

@interface PageModel : NSObject

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,strong) NSMutableArray  *rows;

+(PageModel *) initWithDict:(NSDictionary *)pageDict;

@end
