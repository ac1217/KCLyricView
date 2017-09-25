//
//  KCLyricWordModel.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricWordModel.h"

@implementation KCLyricWordModel

- (NSTimeInterval)endTime
{
    return _startTime + _duration;
}

@end
