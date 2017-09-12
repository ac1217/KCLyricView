//
//  KCLyricModel.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricModel.h"

@implementation KCLyricModel

- (instancetype)initWithLyricContent:(NSString *)lyricContent
{
    if (self = [super init]) {
        
        NSArray *rowArray = [lyricContent componentsSeparatedByString:@"\n\n"];
        
        NSArray *headerArray = [rowArray subarrayWithRange:NSMakeRange(0, 11)];
        
        for (NSString *header in headerArray) {
            
             NSArray *headerKeyValueArray = [[header substringWithRange:NSMakeRange(1, header.length - 2)] componentsSeparatedByString:@":"];
            
            [self setValue:headerKeyValueArray.lastObject forKey:headerKeyValueArray.firstObject];
            
        }
        
        NSArray *bodyArray = [rowArray subarrayWithRange:NSMakeRange(11, rowArray.count - 11)];
        NSMutableArray *rowModels = @[].mutableCopy;
        for (NSString *rowContent in bodyArray) {
            KCLyricRowModel *rowModel = [[KCLyricRowModel alloc] initWithRowContent:rowContent];
            [rowModels addObject:rowModel];
        }
        self.rowModels = rowModels;
        
        
    }
    return self;
}

- (void)setLanguage:(NSString *)language
{
    _language = [language copy];
    
    /*
    NSData *data =  [[NSData alloc] initWithBase64EncodedString:language options:0];
    
    NSString *str = [NSString stringWithCString:data.bytes encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", str);*/
    
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    if ([key isEqualToString:@"hash"]) {
        _lyricHash = value;
    }else if ([key isEqualToString:@"id"]) {
        _lyricID = value;
    }
}

@end
