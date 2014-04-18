//
//  RNTwitterCell.h
//  ruche
//
//  Created by Eddy RICHARD on 26/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNTwitterCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *twetterFeed;

@end
