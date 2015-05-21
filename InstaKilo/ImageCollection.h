//
//  ImageCollection.h
//  InstaKilo
//
//  Created by JIAN WANG on 5/21/15.
//  Copyright (c) 2015 JWANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCollection : NSObject

@property (nonatomic, strong) NSMutableArray *myImages;

-(NSMutableArray *)getArrayBySubject;
-(NSMutableArray *)getArrayByLocation;

@end
