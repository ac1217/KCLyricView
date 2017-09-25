//
//  KCLyricWordModel.h
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCLyricWordModel : NSObject

@property (nonatomic,assign) NSTimeInterval startTime;
@property (nonatomic,assign) NSTimeInterval duration;

@property (nonatomic,assign, readonly) NSTimeInterval endTime;

@property (nonatomic,copy) NSString *word;

@end
