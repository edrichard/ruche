//
//  RNTwitterCell.m
//  ruche
//
//  Created by Eddy RICHARD on 26/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNTwitterCell.h"

@implementation RNTwitterCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

/*- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize maxSize = CGSizeMake(220.0f, CGFLOAT_MAX);
    
    CGSize requiredSize = [self.screenNameLabel sizeThatFits:maxSize];
    self.screenNameLabel.frame = CGRectMake(self.screenNameLabel.frame.origin.x, self.screenNameLabel.frame.origin.y, requiredSize.width, requiredSize.height);
    
    requiredSize = [self.twetterFeed sizeThatFits:maxSize];
    self.twetterFeed.frame = CGRectMake(self.twetterFeed.frame.origin.x, self.twetterFeed.frame.origin.y, requiredSize.width, requiredSize.height);
    
    // Reposition labels to handle content height changes
    
    CGRect twetterFeedFrame = self.twetterFeed.frame;
    twetterFeedFrame.origin.y = self.screenNameLabel.frame.origin.y + self.screenNameLabel.frame.size.height + 3.0f;
    self.twetterFeed.frame = twetterFeedFrame;

    // Calculate cell height
    self.requiredCellHeight = 15.0f + 3.0f + 7.0f + 15.0f;
    self.requiredCellHeight += self.screenNameLabel.frame.size.height;
    self.requiredCellHeight += self.twetterFeed.frame.size.height;
    
    NSLog(@"\nself.screenNameLabel.frame.size.height :: %f\nself.twetterFeed.frame.size.height :: %f\nself.requiredCellHeight :: %f", self.screenNameLabel.frame.size.height, self.twetterFeed.frame.size.height, self.requiredCellHeight);
}*/

@end
