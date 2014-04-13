//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RNPageContentViewController.h"

@interface RNPageContentViewController ()

@end

@implementation RNPageContentViewController

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
    
    self.titreSection.text = self.titleText;
    
    self.labelSection.text = self.sectionText;
    //self.labelFonction.text = self.sectionFonction;
    
    //self.photoSection.image = [UIImage imageNamed:self.filePhoto];
   // self.logoTwitter.image = [UIImage imageNamed:self.fileTwitter];

   // [self.btTwitter setTitle:self.sectionTwitter forState:UIControlStateNormal];
    
    
    
   
    
    //self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    //self.titleLabel.text = self.titleText;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
