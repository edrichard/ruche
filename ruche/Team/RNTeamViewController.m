//
//  RNTeamViewController.m
//  ruche
//
//  Created by Eddy RICHARD on 15/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNTeamViewController.h"

@interface RNTeamViewController ()

@end

@implementation RNTeamViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Go to Home.

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: NULL];
}

@end
