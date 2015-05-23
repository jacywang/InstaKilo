//
//  InstaFlowLayout.m
//  InstaKilo
//
//  Created by JIAN WANG on 5/21/15.
//  Copyright (c) 2015 JWANG. All rights reserved.
//

#import "InstaFlowLayout.h"
#import "DecorationView.h"

# pragma mark - Constants

#define CENTER_OFFSET_BOUND		20
#define ROTATION_ANGLE_BOUND	5 // degrees

# pragma mark - Macros

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@interface InstaFlowLayout()

@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;

@end

@implementation InstaFlowLayout

-(instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(100, 100);
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        [self registerClass:[DecorationView class] forDecorationViewOfKind:[DecorationView kind]];
    }
    return self;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *decorationAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    
    decorationAttributes.frame = CGRectMake(0.0, 0.0, self.collectionViewContentSize.width, self.collectionViewContentSize.height);
    decorationAttributes.zIndex = 0;
    
    return decorationAttributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray* allAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    // Determine attributes for cells, supplementary views, and decoration views in rectangle
    for (UICollectionViewLayoutAttributes* attributes in allAttributes) {
        
        // All elements initially at Z level 1
        attributes.zIndex = 1;
        
        // Cells
        [InstaFlowLayout tweakCellAttributes:attributes];
    }
    
    // Decorator
    [allAttributes addObject:[self layoutAttributesForDecorationViewOfKind:[DecorationView kind] atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];
    
    return allAttributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPaths = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
    }
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
}

-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deleteIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes) {
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        }
        // Configure attributes ...
        CGRect rect = attributes.frame;
        attributes.frame = CGRectMake(self.collectionView.center.x, self.collectionView.superview.bounds.size.height, rect.size.width, rect.size.height);
    }
    
    return attributes;
}

+ (void)tweakCellAttributes:(UICollectionViewLayoutAttributes*)cellAttributes {
    
    if (cellAttributes.representedElementCategory != UICollectionElementCategoryCell) return;
    
    // Offset center by bounded random amount
    double centerXOffset = arc4random_uniform(CENTER_OFFSET_BOUND + 1) - (CENTER_OFFSET_BOUND / 2.0);
    double centerYOffset = arc4random_uniform(CENTER_OFFSET_BOUND + 1) - (CENTER_OFFSET_BOUND / 2.0);
    cellAttributes.center = CGPointMake(cellAttributes.center.x + centerXOffset,
                                        cellAttributes.center.y + centerYOffset);
    
    // Rotate by bounded random angle
    double rotationAngle = arc4random_uniform(ROTATION_ANGLE_BOUND + 1) - (ROTATION_ANGLE_BOUND / 2.0);
    cellAttributes.transform = CGAffineTransformMakeRotation(RADIANS(rotationAngle));
}

@end
