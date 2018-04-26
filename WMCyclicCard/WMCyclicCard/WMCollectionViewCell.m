//
//  WMCollectionViewCell.m
//  WMCyclicCard
//
//  Created by 吴冕 on 2018/4/25.
//  Copyright © 2018年 wumian. All rights reserved.
//

#import "WMCollectionViewCell.h"
@interface WMCollectionViewCell()

@property(nonatomic,strong) UIImageView *cardImgView;

@property(nonatomic,strong) UILabel *cardNameLabel;

@end

@implementation WMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.masksToBounds = true;
        self.contentView.layer.cornerRadius = 5.0;

        self.cardImgView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 180);

        self.cardNameLabel.frame = CGRectMake(0, CGRectGetMaxY(self.cardImgView.frame), self.cardImgView.frame.size.width, self.contentView.frame.size.height - CGRectGetMaxY(self.cardImgView.frame));
        self.cardNameLabel.textAlignment = NSTextAlignmentCenter;
        self.cardNameLabel.textColor = [UIColor blackColor];
        self.cardNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (UIImageView *)cardImgView{
    if (!_cardImgView) {
        _cardImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_cardImgView];
    }
    return _cardImgView;
}

- (UILabel *)cardNameLabel{
    if (!_cardNameLabel) {
        _cardNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_cardNameLabel];
    }
    return _cardNameLabel;
}

- (void)setCardImageName:(NSString *)cardImageName{
    _cardImageName = cardImageName;
    self.cardImgView.image = [UIImage imageNamed:cardImageName];
}

- (void)setCardLabelName:(NSString *)cardLabelName{
    self.cardNameLabel.text = cardLabelName;
}

@end
