//
//  LaunchAdModel.m
//  qianguan
//
//  Created by alading on 2017/10/24.
//  Copyright © 2017年 QS_Ren. All rights reserved.
//
//  广告数据模型
#import "LaunchAdModel.h"

@implementation LaunchAdModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.content = dict[@"content"];
        self.openUrl = dict[@"openUrl"];
        self.duration = [dict[@"duration"] integerValue];
        self.contentSize = dict[@"contentSize"];
        self.adType = [dict[@"adType"] integerValue];
        self.isSign = [dict[@"isSign"] integerValue];
    }
    return self;
}
-(CGFloat)width
{
    return [[[self.contentSize componentsSeparatedByString:@"*"] firstObject] floatValue];
}
-(CGFloat)height
{
    return [[[self.contentSize componentsSeparatedByString:@"*"] lastObject] floatValue];
}
@end
