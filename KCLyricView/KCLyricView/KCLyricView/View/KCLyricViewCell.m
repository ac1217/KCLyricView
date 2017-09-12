//
//  KCLyricViewCell.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricViewCell.h"


 NSString *const KCLyricViewCellReuseID = @"KCLyricViewCell";

@interface KCLyricViewCell ()

@property (nonatomic,strong) CAShapeLayer *normalMaskLayer;
@property (nonatomic,strong) CAShapeLayer *highlightedMaskLayer;

@end

@implementation KCLyricViewCell

- (CAShapeLayer *)normalMaskLayer
{
    if (!_normalMaskLayer) {
        _normalMaskLayer = [CAShapeLayer layer];
    }
    return _normalMaskLayer;
}

- (CAShapeLayer *)highlightedMaskLayer
{
    if (!_highlightedMaskLayer) {
        _highlightedMaskLayer = [CAShapeLayer layer];
    }
    return _highlightedMaskLayer;
}

- (UILabel *)normalLabel
{
    if (!_normalLabel) {
        _normalLabel = [[UILabel alloc] init];
        _normalLabel.font = [UIFont systemFontOfSize:14];
        _normalLabel.textColor = [UIColor blueColor];
        _normalLabel.layer.mask = self.normalMaskLayer;
    }
    return _normalLabel;
}

- (UILabel *)highlightedLabel
{
    if (!_highlightedLabel) {
        _highlightedLabel = [[UILabel alloc] init];
        _highlightedLabel.font = [UIFont systemFontOfSize:14];
        _highlightedLabel.textColor = [UIColor orangeColor];
        
        _highlightedLabel.layer.mask = self.highlightedMaskLayer;
    }
    return _highlightedLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.normalLabel];
        [self.contentView addSubview:self.highlightedLabel];
    }
    return self;
}


- (void)setRowModel:(KCLyricRowModel *)rowModel
{
    _rowModel = rowModel;
    
    self.normalLabel.text = rowModel.row;
    self.highlightedLabel.text = rowModel.row;
    
    [self setupLayout];
    
    [self setProgress:0];
}

- (void)setupLayout
{
    [self.normalLabel sizeToFit];
    [self.highlightedLabel sizeToFit];
    
    self.normalLabel.center = CGPointMake(self.contentView.bounds.size.width * 0.5, self.contentView.bounds.size.height * 0.5);
    
    self.normalMaskLayer.frame = self.normalLabel.bounds;
    
    self.highlightedLabel.center = self.normalLabel.center;
//
    self.highlightedMaskLayer.frame = self.highlightedLabel.bounds;
    
}


- (void)setProgress:(CGFloat)progress
{
    
    CGRect normalMaskLayerFrame = self.normalLabel.bounds;
    normalMaskLayerFrame.origin.x = self.normalLabel.bounds.size.width * progress;
    normalMaskLayerFrame.size.width = self.normalLabel.bounds.size.width - normalMaskLayerFrame.origin.x;
    
    self.normalMaskLayer.path = [UIBezierPath bezierPathWithRect:normalMaskLayerFrame].CGPath;
    
    CGRect highlightedMaskLayerFrame = self.highlightedLabel.bounds;
    highlightedMaskLayerFrame.size.width = self.highlightedLabel.bounds.size.width * progress;
    
    self.highlightedMaskLayer.path = [UIBezierPath bezierPathWithRect:highlightedMaskLayerFrame].CGPath;
    
}

@end
