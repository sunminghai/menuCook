//
//  SMHImageRunLoop.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/18.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "SMHImageRunLoop.h"

@interface SMHImageRunLoop () <UICollectionViewDataSource, UICollectionViewDelegate>
/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

/** 记录cell 的index */
@property (nonatomic, assign) NSInteger index;
/** 是否正在滚动 */
@property (nonatomic, assign) NSInteger currentPage;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end
/** 重用标识 */
static NSString * const ID = @"SMHImageRunLoopCell";
/** 动画执行的时间 */
static CGFloat const duration = 1.5;

@implementation SMHImageRunLoop



/** 初始化视图, 设置视图的frame */
- (instancetype)initWithFrame:(CGRect)frame {
    SMHImageRunLoop *view = [super initWithFrame:frame];
    
    [view setupUI];
    
    
    
    return view;
}
/** 设置要显示的图片 */
- (void)setImages:(NSArray *)images {
    _images = images;
    
    CGFloat w = self.bounds.size.width * 0.5;
    CGFloat h = 20;
    CGFloat x = (self.bounds.size.width - w) * 0.5;
    CGFloat y = self.bounds.size.height * 0.8;
    
    CGRect rect = CGRectMake(x, y, w, h);
    self.pageControl = [[UIPageControl alloc] initWithFrame:rect];
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    [self addSubview:self.pageControl];
    
    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    self.index = 0;
    
    [self addTimer];
    
}
/** 添加定时器 */
- (void)addTimer {
    self.timer = [NSTimer timerWithTimeInterval:duration target:self selector:@selector(nextCell) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/** 控制器dealloc时 把定时器取消 */
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}


/** 设置视图 */
- (void)setupUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    
    [self addSubview:self.collectionView];
    
    flowLayout.itemSize = self.collectionView.bounds.size;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images ? 3 : 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
     NSInteger index = (self.index + indexPath.item - 1 + self.images.count)%self.images.count;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.images[index]];
    imageView.frame = cell.bounds;
    [cell addSubview:imageView];
    
    return cell;
}
/** 手动拖拽滚动结束时调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    
    self.index = (self.index + page - 1 + self.images.count) % self.images.count;
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [self.collectionView
         scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    });
}
/** 用代码实现滚动结束时调用 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:self.collectionView];
}
/** 开始拖拽时取消定时器 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}
/** 停止拖拽时添加定时器 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}
/** 定时器方法 */
- (void)nextCell {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] atScrollPosition:0 animated:YES];
}

/** 设置当前显示的图片的下标 */
- (void)setIndex:(NSInteger)index {
    _index = index;
    self.pageControl.currentPage = index;
}


@end
