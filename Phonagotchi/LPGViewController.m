//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"

@interface LPGViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) Pet *pet;
@property (nonatomic) BOOL isAppleBeingPinched;
@property CGRect originalFrame;
@property (nonatomic) IBOutlet UIImageView *appleView;

@end

@implementation LPGViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.pet = [[Pet alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    
    [self.view addSubview:self.petImageView];
    [self.view bringSubviewToFront:self.appleView];
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    self.petImageView.userInteractionEnabled = YES;
    self.appleView.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *pettingRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePetting:)];
    [self.petImageView addGestureRecognizer:pettingRecognizer];
    

}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}



- (IBAction)panApple:(UIPanGestureRecognizer *)sender {
    
    
    CGPoint appleLocation = [sender locationInView:self.view];
    self.appleView.center = appleLocation;
    
        switch(sender.state) {
            case UIGestureRecognizerStateBegan:
                self.originalFrame = self.appleView.frame;
                break;
                
            
            case UIGestureRecognizerStateEnded: {
                if(CGRectContainsPoint(self.petImageView.frame, appleLocation)) {
                    self.appleView.alpha = 0;
                    
                    [UIView animateWithDuration:2 animations:^{
                        self.appleView.frame = self.originalFrame;
                    }completion:^(BOOL finished) {
                        self.appleView.alpha = 1;
                    }];
                    
                } else {
                    [UIView animateWithDuration:2 animations:^{
                        CGFloat newYLocation = CGRectGetMaxY(self.view.frame) + CGRectGetHeight(self.appleView.frame);
                        
                        self.appleView.center = CGPointMake(self.appleView.frame.origin.x, newYLocation);
                        
                    } completion:^(BOOL finished) {
                        self.appleView.frame = self.originalFrame;
                        self.appleView.alpha = 1;
                    }];
                }
                
                break;
            }
            default:
                break;
        }
    
    
}


-(void)handlePetting:(UIPanGestureRecognizer*)pettingRecognizer {

    CGPoint vel = [pettingRecognizer velocityInView:self.petImageView];
    CGFloat velocity = sqrt((vel.x*vel.x)+(vel.y*vel.y));
    [self.pet petting:velocity];
    if(self.pet.isGrumpy) {
        self.petImageView.image = self.pet.grumpyImage;
    } else {
        self.petImageView.image = self.pet.defaultImage;
    }
    NSLog(@"%.02f", velocity);

    
}

@end



