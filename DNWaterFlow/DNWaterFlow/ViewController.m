//
//  ViewController.m
//  DNWaterFlow
//
//  Created by mainone on 16/6/2.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ViewController.h"
#import "DNWaterLayout.h"
#import "DNWaterCell.h"

static NSString *const DNIndentifierCell = @"DNCollectionViewCell";

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) DNWaterLayout *waterLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:@"DNWaterCell" bundle:nil] forCellWithReuseIdentifier:DNIndentifierCell];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载数据
- (void)loadData {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 10; i++) {
            for (NSInteger i = 1; i <= 20; i ++) {
                NSString *imageName = [NSString stringWithFormat:@"%ld.jpg",(long)i];
                [self.dataArray addObject:imageName];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
        });
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DNWaterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DNIndentifierCell forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[self.dataArray objectAtIndex:indexPath.item]];
    cell.titleStr = @"        今天天气还不错,要不要出去玩玩,要是不出去玩,那就在家窝着吧,你说是不是";
    return cell;
}

#pragma mark - 初始化
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.waterLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (DNWaterLayout *)waterLayout {
    if (!_waterLayout) {
        _waterLayout = [[DNWaterLayout alloc] init];
        _waterLayout.lineNumber = 2;
        _waterLayout.rowSpacing = 2;
        _waterLayout.lineSpacing = 2;
        _waterLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        __weak typeof(self) weakSelf = self;
        [_waterLayout computeIndexCellHeightWidthWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            NSString *imageName = weakSelf.dataArray[indexPath.row];
            UIImage *image      = [UIImage imageNamed:imageName];
            CGFloat itemH       = image.size.height / image.size.width * width;
            return itemH;
        }];
    }
    return _waterLayout;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


@end
