//
//  ImageCollection.m
//  InstaKilo
//
//  Created by JIAN WANG on 5/21/15.
//  Copyright (c) 2015 JWANG. All rights reserved.
//

#import "ImageCollection.h"
#import "MyImage.h"

@implementation ImageCollection

-(instancetype)init {
    self = [super init];
    if (self) {
        _myImages = [NSMutableArray arrayWithArray:@[
                    [[MyImage alloc] initWithImageName:@"flower1.jpg" andSubject:@"Flower" andLocation:@"Vancouver"],
                    [[MyImage alloc] initWithImageName:@"flower2.jpg" andSubject:@"Flower" andLocation:@"Vancouver"],
                    [[MyImage alloc] initWithImageName:@"flower3.jpg" andSubject:@"Flower" andLocation:@"Toronto"],
                    [[MyImage alloc] initWithImageName:@"flower4.jpg" andSubject:@"Flower" andLocation:@"Montreal"],
                    [[MyImage alloc] initWithImageName:@"flower5.jpg" andSubject:@"Flower" andLocation:@"Toronto"],
                    [[MyImage alloc] initWithImageName:@"mountain1.jpg" andSubject:@"Mountain" andLocation:@"Toronto"],
                    [[MyImage alloc] initWithImageName:@"mountain2.jpg" andSubject:@"Mountain" andLocation:@"Toronto"],
                    [[MyImage alloc] initWithImageName:@"mountain3.jpg" andSubject:@"Mountain" andLocation:@"Montreal"],
                    [[MyImage alloc] initWithImageName:@"mountain4.jpg" andSubject:@"Mountain" andLocation:@"Montreal"],
                    [[MyImage alloc] initWithImageName:@"mountain5.jpg" andSubject:@"Mountain" andLocation:@"Vancouver"],
        ]];
    }
    return self;
}

-(NSMutableArray *)getArrayBySubject {
    NSMutableArray *arrayBySubject = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (MyImage *image in _myImages) {
        if (dict[image.subject]) {
            [dict[image.subject] addObject:image];
        } else {
            dict[image.subject] = [NSMutableArray arrayWithArray:@[image]];
        }
    }
    
    for (NSString *subject in dict) {
        [arrayBySubject addObject:@[subject, dict[subject]]];
    }
    return arrayBySubject;
}

-(NSMutableArray *)getArrayByLocation {
    NSMutableArray *arrayByLocation = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    for (MyImage *image in _myImages) {
        if (dict[image.location]) {
            [dict[image.location] addObject:image];
        } else {
            [dict setValue:[NSMutableArray arrayWithObject:image] forKey:image.location];
        }
    }
    
    for (NSString *subject in dict) {
        [arrayByLocation addObject:@[subject, dict[subject]]];
    }
    
    return arrayByLocation;
}

@end

