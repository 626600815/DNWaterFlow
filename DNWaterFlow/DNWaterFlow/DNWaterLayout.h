//
//  DNWaterLayout.h
//  DNWaterFlow
//
//  Created by mainone on 16/6/2.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^HeightBlock)(NSIndexPath *indexPath , CGFloat width);


@interface DNWaterLayout : UICollectionViewLayout

/**
 *  列数
 */
@property (nonatomic, assign) NSInteger lineNumber;

/**
 *  行间距
 */
@property (nonatomic, assign) CGFloat rowSpacing;

/**
 *  列间距
 */
@property (nonatomic, assign) CGFloat lineSpacing;

/**
 *  内边距
 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/**
 *  计算cell的宽高 (一定要实现这个方法哦)
 */
- (void)computeIndexCellHeightWidthWidthBlock:(HeightBlock)block;

@end
