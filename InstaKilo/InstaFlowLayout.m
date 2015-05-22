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
    UICollectionViewLayoutAttributes *decorationAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:[DecorationView kind] withIndexPath:indexPath];
    
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
        //[InstaFlowLayout tweakCellAttributes:attributes];
    }
    
    // Decorator
    [allAttributes addObject:[self layoutAttributesForDecorationViewOfKind:[DecorationView kind] atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];
    
    return allAttributes;
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
