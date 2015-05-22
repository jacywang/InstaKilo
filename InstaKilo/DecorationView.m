//
//  DecorationView.m
//  InstaKilo
//
//  Created by JIAN WANG on 5/21/15.
//  Copyright (c) 2015 JWANG. All rights reserved.
//

#import "DecorationView.h"

@implementation DecorationView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        UIImage *backgroundImage = [UIImage imageNamed:@"flora.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = backgroundImage;
        [self addSubview:imageView];
    }
    
    return self;
}

+(NSString *)kind {
    return @"floraDecoration";
}

@end
