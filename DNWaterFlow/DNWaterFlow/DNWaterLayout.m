//
//  DNWaterLayout.m
//  DNWaterFlow
//
//  Created by mainone on 16/6/2.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNWaterLayout.h"

@interface DNWaterLayout ()

/**
 *  存放每列高度的字典
 */
@property (nonatomic, strong) NSMutableDictionary *dicOfheight;
/**
 *  存放所有item的attrubutes属性
 */
@property (nonatomic, strong) NSMutableArray *array;

/**
 *  计算每个item高度Block
 */
@property (nonatomic, copy) HeightBlock block;

@end

@implementation DNWaterLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initAllObject];
    }
    return self;
}

- (void)computeIndexCellHeightWidthWidthBlock:(CGFloat(^)(NSIndexPath *indexPath, CGFloat width))block {
    if (self.block != block) {
        self.block = block;
    }
}

//准备布局
- (void)prepareLayout {
    [super prepareLayout];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < self.lineNumber; i++) {
        [self.dicOfheight setObject:@(self.sectionInset.top) forKey:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    //得到每个item的属性值进行存储
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self.array addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

//设置滚动区域范围
- (CGSize)collectionViewContentSize {
    __block NSString *maxHeightline = @"0";
    [self.dicOfheight enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([[self.dicOfheight objectForKey:maxHeightline] floatValue] < [obj floatValue]) {
            maxHeightline = key;
        }
    }];
    return CGSizeMake(self.collectionView.bounds.size.width, [[self.dicOfheight objectForKey:maxHeightline] floatValue] + self.sectionInset.bottom);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //通过indexPath创建一个item属性attr
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //计算item宽
    CGFloat itemW = (self.collectionView.bounds.size.width - (self.sectionInset.left + self.sectionInset.right) - (self.lineNumber - 1) * self.lineSpacing) / self.lineNumber;
    CGFloat itemH = 0;
    //计算item高
    if (self.block != nil) {
        itemH = self.block(indexPath, itemW);
    }else{
        NSAssert(itemH != 0,@"Please implement computeIndexCellHeightWithWidthBlock Method");
    }
    //计算item的frame
    CGRect frame;
    frame.size = CGSizeMake(itemW, itemH);
    //循环遍历找出高度最短行
    __block NSString *lineMinHeight = @"0";
    [self.dicOfheight enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
        if ([self.dicOfheight[lineMinHeight] floatValue] > [obj floatValue]) {
            lineMinHeight = key;
        }
    }];
    int line = [lineMinHeight intValue];
    //找出最短行后，计算item位置
    frame.origin = CGPointMake(self.sectionInset.left + line * (itemW + self.lineSpacing), [self.dicOfheight[lineMinHeight] floatValue]);
    self.dicOfheight[lineMinHeight] = @(frame.size.height + self.rowSpacing + [self.dicOfheight[lineMinHeight] floatValue]);
    attr.frame = frame;
    
    return attr;
}

//返回视图框内item的属性，可以直接返回所有item属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _array;
}

#pragma mark - 初始化
//设置默认值
- (void)initAllObject {
    self.lineNumber   = 3;                              // 默认行数
    self.rowSpacing   = 10.0f;                          //默认行间距
    self.lineSpacing  = 10.0;                           //默认列间距
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);   //默认内边距
}

- (NSMutableDictionary *)dicOfheight {
    if (!_dicOfheight) {
        _dicOfheight = [[NSMutableDictionary alloc] init];
    }
    return _dicOfheight;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}

@end
