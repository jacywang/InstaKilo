//
//  MyImage.h
//  InstaKilo
//
//  Created by JIAN WANG on 5/21/15.
//  Copyright (c) 2015 JWANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyImage : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *location;

-(instancetype)initWithImageName:(NSString *)imageName andSubject:(NSString *)subject andLocation:(NSString *)location;

@end
