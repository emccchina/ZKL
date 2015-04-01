//
//  MessageModel.h
//  ZKL
//
//  Created by champagne on 15-3-26.
//  Copyright (c) 2015年 EMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : MTLModel
<MTLJSONSerializing>

@property (nonatomic,assign) NSInteger errorno;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDictionary *result;


@end
