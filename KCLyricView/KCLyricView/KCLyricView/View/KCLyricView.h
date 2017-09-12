//
//  KCLyricView.h
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCLyricModel.h"
@class KCLyricView;
@protocol KCLyricViewDataSource <NSObject>

- (NSString *)lyricContentWithLyricView:(KCLyricView *)lyricView;

@optional
- (NSInteger)numberOfRowsInLyricView:(KCLyricView *)lyricView;

@end

@interface KCLyricView : UIView
@property (nonatomic,strong, readonly) KCLyricModel *lyricModel;

@property (nonatomic,assign) NSTimeInterval currentTime;

@property (nonatomic,weak) id<KCLyricViewDataSource> dataSource;

- (void)reloadData;

@end
