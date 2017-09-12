//
//  KCLyricRowModel.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricRowModel.h"

@implementation KCLyricRowModel


- (NSTimeInterval)endTime
{
    return _startTime + _duration;
}


- (instancetype)initWithRowContent:(NSString *)rowContent
{
    if (self = [super init]) {
        
        NSRange timeStartRange = [rowContent rangeOfString:@"["];
        NSRange timeEndRange = [rowContent rangeOfString:@"]"];
        
        NSArray *timeArray = [[rowContent substringWithRange:NSMakeRange(timeStartRange.location + 1, timeEndRange.location - timeStartRange.location - 1)] componentsSeparatedByString:@","];
        
        _startTime = [timeArray.firstObject integerValue] * 0.001;
        _duration = [timeArray.lastObject integerValue] * 0.001;
        
        rowContent = [rowContent substringFromIndex:timeEndRange.location + 2];
        
        NSMutableArray *wordModels = @[].mutableCopy;
        
        NSArray *wordContentArray = [rowContent componentsSeparatedByString:@"<"];
        NSMutableString *row = [NSMutableString string];
        for (NSString *wordContent in wordContentArray) {
            
            KCLyricWordModel *wordModel = [[KCLyricWordModel alloc] initWithWordContent:wordContent];
            [row appendString:wordModel.word];
            [wordModels addObject:wordModel];
        }
        _row = row;
        _wordModels = wordModels;
        
    }
    return self;
}

@end
