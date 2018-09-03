//
//  ATBaseRequest.h
//  信号量
//
//  Created by Ben Lv on 2018/9/3.
//  Copyright © 2018年 avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id data);
typedef void(^FailureBlock)(NSInteger resultId,NSString *errorMsg);

@interface ATBaseRequest : NSObject

+ (void)getRequestWithMethod:(NSString *)method param:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
