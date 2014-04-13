//
//  UILabel+Boldify.h
//  ruche
//
//  Created by Eddy RICHARD on 11/04/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Boldify)

- (void) boldSubstring: (NSString*) substring;
- (void) boldRange: (NSRange) range;

@end
