//
//  Pet.h
//  Phonagotchi
//
//  Created by Chris Dean on 2018-02-22.
//  Copyright © 2018 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Pet : NSObject

@property (nonatomic) UIImage *defaultImage;
@property (nonatomic) UIImage *grumpyImage;
@property (nonatomic) UIImage *sleepyImage;
@property (nonatomic) BOOL isGrumpy;
@property (nonatomic) int restfulness;

-(void)petting:(float)velocity;

@end
