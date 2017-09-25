//
//  KCLyricTool.h
//  KCLyricView
//
//  Created by iMac on 2017/9/13.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCLyricModel.h"

@interface KCLyricTool : NSObject

+ (void)lyricModelWithKRC:(NSString *)lyricContent completion:(void(^)(KCLyricModel *lyricModel))completion;
+ (void)lyricModelWithLRC:(NSString *)lyricContent completion:(void(^)(KCLyricModel *lyricModel))completion;

+ (KCLyricModel *)lyricModelWithKRC:(NSString *)lyricContent;
+ (KCLyricModel *)lyricModelWithLRC:(NSString *)lyricContent;
@end
