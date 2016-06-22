//
//  DNWaterCell.m
//  DNWaterFlow
//
//  Created by mainone on 16/6/2.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNWaterCell.h"
#import "NSString+DNFrame.h"


@implementation DNWaterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
    
    CGFloat height = [titleStr heightWithFont:self.titleLabel.font constrainedToWidth:self.titleLabel.frame.size.width];
    self.titleHeight.constant = height;
    
}

@end
