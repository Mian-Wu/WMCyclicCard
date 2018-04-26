//
//  WMCollectionViewFlowLayout.m
//  WMCyclicCard
//
//  Created by 吴冕 on 2018/4/25.
//  Copyright © 2018年 wumian. All rights reserved.
//

#import "WMCollectionViewFlowLayout.h"
//垂直缩放除以系数
static CGFloat ActiveDistance = 400;
//缩放系数  越大缩放越大
static CGFloat ScaleFactor = 0.25;

@implementation WMCollectionViewFlowLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    // 目标区域中包含的cell
    NSArray *attriArray = [super layoutAttributesForElementsInRect:targetRect];
    // collectionView落在屏幕中点的x坐标
    NSUInteger horizontalCenterX = proposedContentOffset.x + (self.collectionView.bounds.size.width / 2.0);
    float offsetAdjustment = CGFLOAT_MAX;
    for (UICollectionViewLayoutAttributes *layoutAttributes in attriArray) {
        CGFloat itemHorizontalCenterX = layoutAttributes.center.x;
        // 找出离中心点最近的
        if(fabs(itemHorizontalCenterX-horizontalCenterX) < fabsf(offsetAdjustment)){
            offsetAdjustment = itemHorizontalCenterX-horizontalCenterX;
        }
    }

    //返回collectionView最终停留的位置
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    for (UICollectionViewLayoutAttributes *attributes in array) {
        float distance = (visibleRect.origin.x + visibleRect.size.width / 2.0)- attributes.center.x;
        float normalizedDistance = fabs(distance / ActiveDistance);
        float zoom = 1 - ScaleFactor * normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    //滑动放大缩小  需要实时刷新layout
    return true;
}

@end
