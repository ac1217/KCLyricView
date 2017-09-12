//
//  KCLyricView.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricView.h"
#import "KCLyricViewCell.h"

@interface KCLyricView ()<UITableViewDataSource, UITableViewDelegate> {
    
    KCLyricModel *_lyricModel;
    
}
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSIndexPath *currentIndexPath;

@end

@implementation KCLyricView

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[KCLyricViewCell class] forCellReuseIdentifier:KCLyricViewCellReuseID];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSInteger)numberOfRows
{
    if ([_dataSource respondsToSelector:@selector(numberOfRowsInLyricView:)]) {
        return [_dataSource numberOfRowsInLyricView:self];
    }
    return 3;
}

- (NSString *)lyricContent
{
    return [_dataSource lyricContentWithLyricView:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    _currentTime = currentTime;
    
    NSInteger index = [self searchIndex];
    
    if (index < 0) {
        return;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    if (indexPath != _currentIndexPath) {
        
        KCLyricViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentIndexPath];
        
        [cell setProgress:0];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
    }
    
    KCLyricRowModel *rowModel = _lyricModel.rowModels[index];
    
    CGFloat progress = (currentTime - rowModel.startTime) / rowModel.duration;
    
    KCLyricViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [cell setProgress:progress];
    
    _currentIndexPath = indexPath;
    
}

- (NSInteger)searchIndex
{
    NSInteger beginIndex = 0;
    NSInteger endIndex = _lyricModel.rowModels.count - 1;
    
    if (beginIndex > endIndex)
    {
        return -1;
    }
    
    NSInteger middleIndex = -1;
    while (beginIndex <= endIndex) {
        
        middleIndex = (endIndex + beginIndex) * 0.5;
        
        KCLyricRowModel *rowModel = _lyricModel.rowModels[middleIndex];
        
        if (rowModel.startTime <= _currentTime && rowModel.endTime >= _currentTime) {
            
            return middleIndex;
            
        }else if (_currentTime < rowModel.startTime) {
            
            endIndex = middleIndex - 1;
            
        }else if (_currentTime > rowModel.endTime) {
            
            beginIndex = middleIndex + 1;
            
        }
        
    }
    
    return -1;
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lyricModel.rowModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KCLyricViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCLyricViewCellReuseID];
    
    KCLyricRowModel *rowModel = _lyricModel.rowModels[indexPath.row];
    
    cell.rowModel = rowModel;
    
    if (_currentIndexPath == indexPath) {
        
        CGFloat progress = (_currentTime - rowModel.startTime) / rowModel.duration;
        [cell setProgress:progress];
        
    }else {
        
        [cell setProgress:0];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height / self.numberOfRows;
}


- (void)reloadData
{
    NSString *lyricContent = [self lyricContent];
    
    _lyricModel = [[KCLyricModel alloc] initWithLyricContent:lyricContent];
    
    [self.tableView reloadData];
}

@end
