//
//  NSString+DNFrame.h
//  DNWaterFlow
//
//  Created by mainone on 16/6/2.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (DNFrame)

/**
 *  计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

@end
