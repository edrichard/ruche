//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNPageContentViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titreSection;
@property (strong, nonatomic) IBOutlet UILabel *labelSection;

@property NSUInteger pageIndex;

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *sectionText;

@end
