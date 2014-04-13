//
//  RNHomeViewController.m
//  ruche
//
//  Created by Eddy RICHARD on 10/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNHomeViewController.h"
#import "RNMapKitViewController.h"
#import "Reachability.h"

@interface RNHomeViewController ()

@property (nonatomic, weak) UILabel *alertLabel;

@property (weak, nonatomic) IBOutlet UIButton *btEvents;
@property (weak, nonatomic) IBOutlet UIButton *btNews;
@property (weak, nonatomic) IBOutlet UIButton *btRuche;
@property (weak, nonatomic) IBOutlet UIButton *btTeam;

-(void)reachabilityChanged:(NSNotification*)note;

@end

@implementation RNHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.navigationController.navigationBarHidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    UIImageView *titreView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 156)];
    UIImage *titreImg = [UIImage imageNamed:@"rucheTitle"];
    titreView.image = titreImg;
    [self.view addSubview:titreView];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160, 320, 265)];
    UIImage *logoImg = [UIImage imageNamed:@"logo"];
    logoView.image = logoImg;
    [self.view addSubview:logoView];
    
    self.btEvents.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btEvents.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btEvents setTitle: @"Les\névénement" forState: UIControlStateNormal];
    [self.btEvents setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view bringSubviewToFront:self.btEvents];
    
    [self.view bringSubviewToFront:self.btNews];
    
    [self.view bringSubviewToFront:self.btTeam];
    
    self.btRuche.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btRuche.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btRuche setTitle: @"Nous\nrejoindre" forState: UIControlStateNormal];
    [self.view bringSubviewToFront:self.btRuche];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reachabilityChanged:(NSNotification*) notification
{
	Reachability *reachability = notification.object;
    
	if(reachability.currentReachabilityStatus == NotReachable)
		NSLog(@"Internet off");
	else
		NSLog(@"Internet on");
}

@end
