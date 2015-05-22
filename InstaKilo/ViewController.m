//
//  ViewController.m
//  InstaKilo
//
//  Created by JIAN WANG on 5/21/15.
//  Copyright (c) 2015 JWANG. All rights reserved.
//

#import "ViewController.h"
#import "InstaCollectionViewCell.h"
#import "InstaCollectionReusableHeaderView.h"
#import "ImageCollection.h"
#import "MyImage.h"
#import "DecorationView.h"
#import "InstaFlowLayout.h"

@interface ViewController () {
    NSMutableArray *_imageArray;
}

@property (nonatomic, weak) IBOutlet UICollectionView *myCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ImageCollection *imageCollection= [[ImageCollection alloc] init];
    _imageArray = [imageCollection getArrayBySubject];
    
    InstaFlowLayout *flowLayout = [[InstaFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(self.myCollectionView.frame.size.width, 20);
    [self.myCollectionView setCollectionViewLayout:flowLayout];
}

#pragma mark - CollectionView datasource and delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _imageArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_imageArray[section][1] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InstaCollectionViewCell *cell = [self.myCollectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    MyImage *myImage = _imageArray[indexPath.section][1][indexPath.row];
    cell.myImageView.image = myImage.image;
    cell.subjectLabel.text = myImage.subject;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        InstaCollectionReusableHeaderView *headerView = [self.myCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader" forIndexPath:indexPath];
        headerView.headerLabel.text = _imageArray[indexPath.section][0];
        reusableView = headerView;
    }
    
    return reusableView;
}

@end
