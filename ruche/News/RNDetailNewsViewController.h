//
//  RNDetailNewsViewController.h
//  ruche
//
//  Created by Eddy RICHARD on 16/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNDetailNewsViewController : UIViewController

@property (nonatomic, copy) NSString *stringTitle;
@property (strong, nonatomic) IBOutlet UILabel *titreLabel;
@property (nonatomic, copy) NSString *dateString;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, copy) NSString *stringDescription;
@property (strong, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (nonatomic, copy) NSString *stringUrl;
@property (strong, nonatomic) IBOutlet UIButton *buttonMore;
//@property (strong, nonatomic) IBOutlet UIWebView *webViewURL;

@end
