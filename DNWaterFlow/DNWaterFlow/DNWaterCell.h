//
//  DNWaterCell.h
//  DNWaterFlow
//
//  Created by mainone on 16/6/2.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNWaterCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSString *titleStr;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;
@end
