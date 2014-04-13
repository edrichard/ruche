//
//  ViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RNViewController.h"

@interface RNViewController ()

@end

@implementation RNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create the data model
    
    //self.pageTitles = @[@"Adresse Postale", @"Téléphone et Mail", nil];
    self.pageTitles = [NSMutableArray arrayWithObjects:
                       @"Adresse Postale",
                       @"Téléphone et Mail",
                       @"Horaires",
                       nil];
    
    self.pageText = [NSMutableArray arrayWithObjects:
                     @"Quartier d’affaires Novaxis\nBâtiment La Persée – 1er étage\n19 Boulevard M. & A. Oyon\n72000 LE MANS",
                     @"Téléphone : +33 (0)2 43 21 00 01\nMail : contact@laruchenumerique.fr",
                     @"Du lundi au jeudi : 9h – 12h30 / 14h – 18h\nLe vendredi : 9h – 18h\nFermée le samedi et le dimanche",
                     nil];
    
   /* self.tabPhoto = [NSMutableArray arrayWithObjects:
                     @"",
                     @"",
                     @"loiRicher.png",
                     nil];
    
    self.tabfonction = [NSMutableArray arrayWithObjects:
                     @"",
                     @"",
                     @"Directeur",
                     nil];
    
    self.tabTwitter = [NSMutableArray arrayWithObjects:
                        @"",
                        @"",
                        @"@LoicRicher",
                        nil];*/
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    RNPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
    RNPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (RNPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    RNPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.labelSection.lineBreakMode = NSLineBreakByWordWrapping;
    pageContentViewController.sectionText = self.pageText[index];
    pageContentViewController.titleText = self.pageTitles[index];
   // pageContentViewController.sectionFonction = self.tabfonction[index];
   // pageContentViewController.sectionTwitter = self.tabTwitter[index];
   // pageContentViewController.fileTwitter = self.tabParam[index];
   // pageContentViewController.filePhoto = self.tabPhoto[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((RNPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((RNPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: NULL];
}


@end
