//
//  Pet.m
//  Phonagotchi
//
//  Created by Chris Dean on 2018-02-22.
//  Copyright © 2018 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"

@implementation Pet

- (instancetype)init
{
    self = [super init];
    if (self) {
        _defaultImage = [UIImage imageNamed:@"default.png"];
        _grumpyImage = [UIImage imageNamed:@"grumpy.png"];
    }
    return self;
}

-(void)petting:(float)velocity {
    //if velocity is a certain velocity, is pet grumpy??
    if(velocity > 1000) {
        self.isGrumpy = YES;
    } else {
        self.isGrumpy = NO;
    }
}

@end
