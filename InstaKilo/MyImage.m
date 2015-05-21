//
//  MyImage.m
//  InstaKilo
//
//  Created by JIAN WANG on 5/21/15.
//  Copyright (c) 2015 JWANG. All rights reserved.
//

#import "MyImage.h"

@implementation MyImage

-(instancetype)initWithImageName:(NSString *)imageName andSubject:(NSString *)subject andLocation:(NSString *)location {
    self = [super init];
    if (self) {
        _image = [UIImage imageNamed:imageName];
        _subject = subject;
        _location = location;
    }
    return self;
}

@end
