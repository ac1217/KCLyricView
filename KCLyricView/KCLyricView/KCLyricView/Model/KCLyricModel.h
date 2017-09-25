//
//  KCLyricModel.h
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KCLyricRowModel.h"

/*
 "[id:$00000000]",
 "[ar:\U859b\U4e4b\U8c26]",
 "[ti:\U4e11\U516b\U602a]",
 "[by:]",
 "[hash:2688adb1ca449448388270987bdce6e8]",
 "[al:]",
 "[sign:]",
 "[qq:]",
 "[total:253000]",
 "[offset:0]",
 "[language:eyJjb250ZW50IjpbXSwidmVyc2lvbiI6MX0=]"
 */


@interface KCLyricModel : NSObject

@property (nonatomic,copy) NSString *lyricID;
@property (nonatomic,copy) NSString *ti;
@property (nonatomic,copy) NSString *ar;
@property (nonatomic,copy) NSString *al;
@property (nonatomic,copy) NSString *by;
@property (nonatomic,copy) NSString *lyricHash;
@property (nonatomic,copy) NSString *sign;
@property (nonatomic,assign) NSInteger offset;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,copy) NSString *language;

@property (nonatomic,strong) NSArray <KCLyricRowModel *>*rowModels;

@end
