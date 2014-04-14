//
//  RNHomeViewController.m
//  ruche
//
//  Created by Eddy RICHARD on 10/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNHomeViewController.h"
#import "RNMapKitViewController.h"

@interface RNHomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btEvents;
@property (weak, nonatomic) IBOutlet UIButton *btNews;
@property (weak, nonatomic) IBOutlet UIButton *btRuche;
@property (weak, nonatomic) IBOutlet UIButton *btTeam;

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
    
    [self checkInternet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) checkInternet
{
    UIImageView *titreView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 156)];
    UIImage *titreImg = [UIImage imageNamed:@"rucheTitle"];
    titreView.image = titreImg;
    [self.view addSubview:titreView];
    
    Reachability *reach = [Reachability reachabilityWithHostName:RN_HOST];
    NetworkStatus internetStats = [reach currentReachabilityStatus];
    
    if (internetStats == NotReachable) {
        UIAlertView *alerterror = [[UIAlertView alloc] initWithTitle:@"Erreur Internet" message:@"Merci de vérifiez votre connexion Internet." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerterror setDelegate:self];
        [alerterror show];
        
        self.btEvents.alpha = 0;
        self.btNews.alpha = 0;
        self.btTeam.alpha = 0;
        self.btRuche.alpha = 0;
        
    } else {
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
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
        exit(0);
}

@end
