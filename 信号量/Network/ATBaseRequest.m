//
//  ATBaseRequest.m
//  信号量
//
//  Created by Ben Lv on 2018/9/3.
//  Copyright © 2018年 avatar. All rights reserved.
//

#import "ATBaseRequest.h"
#import <AFNetworking.h>
@implementation ATBaseRequest

+ (void)getRequestWithMethod:(NSString *)method param:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:method parameters:dicParam progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
