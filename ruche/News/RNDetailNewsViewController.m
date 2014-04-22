//
//  RNDetailNewsViewController.m
//  ruche
//
//  Created by Eddy RICHARD on 16/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNDetailNewsViewController.h"
#import "NSString+HTML.h"

@interface RNDetailNewsViewController ()

@end

@implementation RNDetailNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.titreLabel sizeToFit];
    self.titreLabel.numberOfLines = 0;
    [self.titreLabel layoutIfNeeded];
    self.titreLabel.textColor = [UIColor RN_COLOR_NEWS];
    self.titreLabel.text = self.stringTitle;
    
    self.dateLabel.text = self.dateString;
    
    [self.descriptionLabel sizeToFit];
    [self.descriptionLabel layoutIfNeeded];
    NSString *description = [self stringByStrippingHTML:self.stringDescription];
    self.descriptionLabel.text = [description stringByDecodingHTMLEntities];
    self.descriptionLabel.textAlignment = NSTextAlignmentJustified;
    
    [self.buttonMore addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushButton:(id)sender
{
    NSString* stringURL = [NSString stringWithFormat:@"%@", self.stringUrl];
    NSString* webStringURL = [stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:webStringURL];
    [[UIApplication sharedApplication] openURL:url];
}

- (NSString *)stringByStrippingHTML:(NSString *)inputString
{
    NSMutableString *outString;
    
    if (inputString) {
        outString = [[NSMutableString alloc] initWithString:inputString];
        
        if ([inputString length] > 0) {
            NSRange r;
            
            while ((r = [outString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
                [outString deleteCharactersInRange:r];
            }      
        }
    }
    
    return outString; 
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
