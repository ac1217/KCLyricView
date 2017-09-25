//
//  KCLyricTool.m
//  KCLyricView
//
//  Created by iMac on 2017/9/13.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricTool.h"

@implementation KCLyricTool

+ (void)lyricModelWithLRC:(NSString *)lyricContent completion:(void(^)(KCLyricModel *lyricModel))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        KCLyricModel *lyricModel = [self lyricModelWithLRC:lyricContent];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !completion  ? : completion(lyricModel);
        });
        
    });
    
}

+ (void)lyricModelWithKRC:(NSString *)lyricContent completion:(void(^)(KCLyricModel *lyricModel))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        KCLyricModel *lyricModel = [self lyricModelWithKRC:lyricContent];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !completion  ? : completion(lyricModel);
        });
        
    });
    
}

+ (KCLyricModel *)lyricModelWithLRC:(NSString *)lyricContent
{
    
    if (!lyricContent.length) {
        return nil;
    }
    
    KCLyricModel *lyricModel = [[KCLyricModel alloc] init];
    
    NSMutableArray *rowArray = [lyricContent componentsSeparatedByString:@"\n"].mutableCopy;
    
    
    for (NSString *rowString in rowArray) {
        
        if (!rowString.length) {
            continue;
        }
        
        NSString *rowContent = rowString;
        
        
        
    }
    
    return lyricModel;
    
}

+ (KCLyricModel *)lyricModelWithKRC:(NSString *)lyricContent
{
    
    if (!lyricContent.length) {
        return nil;
    }
    
    KCLyricModel *lyricModel = [[KCLyricModel alloc] init];
    
    NSMutableArray *rowArray = [lyricContent componentsSeparatedByString:@"\r\n"].mutableCopy;
    
    NSMutableArray *rowModels = @[].mutableCopy;
    
    for (NSString *rowString in rowArray) {
        
        
        if (!rowString.length) {
            continue;
        }
        
        NSString *rowContent = rowString;
        
        if ([rowContent hasSuffix:@"]"]) {
            
            NSArray *headerKeyValueArray = [[rowContent substringWithRange:NSMakeRange(1, rowContent.length - 2)] componentsSeparatedByString:@":"];
            
            [lyricModel setValue:headerKeyValueArray.lastObject forKey:headerKeyValueArray.firstObject];
            
        }else {
            
            KCLyricRowModel *rowModel = [[KCLyricRowModel alloc] init];
            [rowModels addObject:rowModel];
            
            NSRange timeStartRange = [rowContent rangeOfString:@"["];
            NSRange timeEndRange = [rowContent rangeOfString:@"]"];
            
            NSArray *timeArray = [[rowContent substringWithRange:NSMakeRange(timeStartRange.location + 1, timeEndRange.location - timeStartRange.location - 1)] componentsSeparatedByString:@","];
            
            rowModel.startTime = [timeArray.firstObject integerValue] * 0.001;
            rowModel.duration = [timeArray.lastObject integerValue] * 0.001;
            
            rowContent = [rowContent substringFromIndex:timeEndRange.location + 2];
            
            NSMutableArray *wordModels = @[].mutableCopy;
            
            NSArray *wordContentArray = [rowContent componentsSeparatedByString:@"<"];
            NSMutableString *row = [NSMutableString string];
            for (NSString *wordContent in wordContentArray) {
                
                KCLyricWordModel *wordModel = [[KCLyricWordModel alloc] init];
                
                NSArray *wordArray = [wordContent componentsSeparatedByString:@">"];
                
                wordModel.word = wordArray.lastObject;
                
                NSArray *timeArray = [wordArray.firstObject componentsSeparatedByString:@","];
                
                wordModel.startTime = [timeArray.firstObject integerValue] * 0.001 + rowModel.startTime;
                wordModel.duration = [timeArray[1] integerValue] * 0.001;
                
                [row appendString:wordModel.word];
                [wordModels addObject:wordModel];
            }
            
            rowModel.wordModels = wordModels;
            rowModel.row = row;
        }
        
    }
    
    
    lyricModel.rowModels = rowModels;
    
    return lyricModel;
}

@end
