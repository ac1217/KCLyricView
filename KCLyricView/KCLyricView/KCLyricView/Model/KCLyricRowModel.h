//
//  KCLyricRowModel.h
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCLyricWordModel.h"

@interface KCLyricRowModel : NSObject

- (instancetype)initWithRowContent:(NSString *)rowContent;

@property (nonatomic,assign) NSTimeInterval startTime;
@property (nonatomic,assign) NSTimeInterval duration;

@property (nonatomic,assign, readonly) NSTimeInterval endTime;

@property (nonatomic,copy) NSString *row;

@property (nonatomic,strong) NSArray <KCLyricWordModel *>*wordModels;

@end
