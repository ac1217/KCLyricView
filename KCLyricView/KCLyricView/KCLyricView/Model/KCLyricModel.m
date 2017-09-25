//
//  KCLyricModel.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricModel.h"

@implementation KCLyricModel


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
