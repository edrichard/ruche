//
//  RNLoader.m
//  La Ruche Numérique
//
//  Created by Eddy RICHARD on 17/04/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNLoader.h"

@interface RNLoader ()

@property (nonatomic, strong) UIImage *loaderImage;
@property (nonatomic, strong) UIImageView *loaderImageView;
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation RNLoader

- (void) compile {
    self.loaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 36.f, 36.f)];
    self.loaderImage = [UIImage imageNamed:@"loader@2x~iphone.png"];
    self.loaderImageView.image = self.loaderImage;
    self.alpha = 0;
    
    [self addSubview:self.loaderImageView];
    [self bringSubviewToFront:self.loaderImageView];
}

- (void) start {
    self.alpha = 1;
    
    self.animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.animation.duration = 1.1; //speed
    self.animation.additive = NO;
    self.animation.removedOnCompletion = YES;
    self.animation.fillMode = kCAFillModeForwards;
    self.animation.fromValue = [NSNumber numberWithFloat:0];
    self.animation.toValue = [NSNumber numberWithFloat:2*M_PI];
    self.animation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    
    [self.loaderImageView.layer addAnimation:self.animation forKey:@"Spin"];
}

- (void) stop {
    self.alpha = 0;
    [self.loaderImageView.layer removeAllAnimations];
}

@end
