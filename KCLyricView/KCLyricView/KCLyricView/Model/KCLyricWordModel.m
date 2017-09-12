//
//  KCLyricWordModel.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricWordModel.h"

@implementation KCLyricWordModel

- (instancetype)initWithWordContent:(NSString *)wordContent
{
    if (self = [super init]) {
        
        NSArray *wordArray = [wordContent componentsSeparatedByString:@">"];
        
        _word = wordArray.lastObject;
        
        NSArray *timeArray = [wordArray.firstObject componentsSeparatedByString:@","];
        
        _startTime = [timeArray.firstObject integerValue] * 0.001;
        _duration = [timeArray[1] integerValue] * 0.001;
        
    }
    return self;
}

- (NSTimeInterval)endTime
{
    return _startTime + _duration;
}

@end
