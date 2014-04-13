//
//  RNNewsCell.h
//  ruche
//
//  Created by Eddy RICHARD on 15/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNNewsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titreNews;
@property (strong, nonatomic) IBOutlet UILabel *dateNews;
@property (strong, nonatomic) IBOutlet UIImageView *logoNext;

@end
