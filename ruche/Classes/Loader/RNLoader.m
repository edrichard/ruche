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

@property (nonatomic, strong) UIView *overlay;

@end

@implementation RNLoader

- (void) compile {
    
    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 55.f, 55.f)];
    self.overlay.backgroundColor = [UIColor blackColor];
    self.overlay.alpha = 0.2f;
    self.overlay.layer.cornerRadius = 5;
    
    [self addSubview:self.overlay];
    
    self.loaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake((20.f/2), (20.f/2), 36.f, 36.f)];
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
