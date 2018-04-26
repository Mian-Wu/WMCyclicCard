//
//  ViewController.m
//  WMCyclicCard
//
//  Created by 吴冕 on 2018/4/26.
//  Copyright © 2018年 wumian. All rights reserved.
//

#import "ViewController.h"
#import "WMCollectionViewFlowLayout.h"
#import "WMCollectionViewCell.h"

static int  GroupCountNum = 100; //默认组数为100，可以设成200，300
static float Padding = 20.0;

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong) UIView *bgview;

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) UILabel *showLabel;

@property(nonatomic, strong) UILabel *currentLabel;

@property(nonatomic, strong) NSMutableArray *imageArr;

@property(nonatomic, strong) NSMutableArray *indexArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i < GroupCountNum; i++) {
        for (int j = 0; j < self.imageArr.count; j++) {
            [self.indexArr addObject:@(j)];
        }
    }
    
    //     定位到 第50组(中间那组)
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:GroupCountNum / 2 * self.imageArr.count inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.indexArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WMCollectionViewCell *cell = (WMCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"WMCollectionViewCell" forIndexPath:indexPath];
    
    NSInteger index = [self.indexArr[indexPath.row] intValue];
    cell.index = [NSString stringWithFormat:@"%zd",index];
    cell.cardImageName = self.imageArr[index];
    cell.cardLabelName = @"奔跑吧，小蜗牛~";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WMCollectionViewCell *cell = (WMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.currentLabel.text = [NSString stringWithFormat:@"点击第%zd张图片",([cell.index intValue] + 1)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    CGPoint pointInView = [self.view convertPoint:self.collectionView.center toView:self.collectionView];
    NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pointInView];
    NSUInteger index = indexPathNow.row % self.imageArr.count;
    self.showLabel.text = [NSString stringWithFormat:@"滚动至第%zd张",index + 1];
    // 动画停止, 重新定位到 第50组(中间那组) 模型
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:GroupCountNum / 2 * self.imageArr.count + index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    self.currentLabel.text = @"点击第 张图片";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma make - 懒加载
- (UIView *)bgview{
    if (!_bgview) {
        _bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 240)];
        _bgview.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_bgview];
    }
    return _bgview;
}

-(UILabel *)showLabel{
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bgview.frame) + 20, [UIScreen mainScreen].bounds.size.width, 20)];
        _showLabel.text = @"滚动至第0张";
        _showLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_showLabel];
    }
    return _showLabel;
}

- (UILabel *)currentLabel{
    if (!_currentLabel) {
        _currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.showLabel.frame) + 20, [UIScreen mainScreen].bounds.size.width, 20)];
        _currentLabel.text = @"点击第 张图片";
        _currentLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_currentLabel];
    }
    return _currentLabel;
}

- (NSMutableArray *)imageArr{
    if(!_imageArr){
        _imageArr = [NSMutableArray arrayWithObjects:@"num_1",@"num_2",@"num_3",@"num_4",@"num_5",nil];
    }
    return _imageArr;
}

- (NSMutableArray *)indexArr{
    if (!_indexArr) {
        _indexArr = [NSMutableArray array];
    }
    return _indexArr;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        WMCollectionViewFlowLayout *layout = [[WMCollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = Padding;
        layout.minimumInteritemSpacing = Padding;
        layout.sectionInset = UIEdgeInsetsMake(Padding, 0, Padding, 0);
        //        CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - Padding * 2) * 0.5;
        CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - Padding * 2);
        layout.itemSize = CGSizeMake(itemW, self.bgview.frame.size.height - Padding * 2);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bgview.bounds)) collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(0, Padding, 0, Padding);
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.collectionViewLayout = layout;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[WMCollectionViewCell class] forCellWithReuseIdentifier:@"WMCollectionViewCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


@end
