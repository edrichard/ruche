//
//  RNMapKitViewController.m
//  ruche
//
//  Created by Eddy RICHARD on 11/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import "RNMapKitViewController.h"
#import "RNDisplayMap.h"
#import "RNHomeViewController.h"

@interface RNMapKitViewController ()

@end

@implementation RNMapKitViewController

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
    
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    MKCoordinateRegion region = {{0.0, 0.0}, {0.0, 0.0}};
    region.center.latitude = 47.99508429999999;
    region.center.longitude = 0.1883585000000494;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [self.mapView setRegion:region animated:YES];
    
    [self.mapView setDelegate:self];
    
    RNDisplayMap *annotation = [[RNDisplayMap alloc] init];
    annotation.title = @"La Ruche Numérique";
    annotation.subtitle = @"19 Boulevard M. & A. Oyon – 72000 LE MANS";
    annotation.coordinate = region.center;
    [self.mapView addAnnotation:annotation];
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(
    id <MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
    }
    else {
        [mapView.userLocation setTitle:@"Je me trouve ici !"];
    }
    return pinView;
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
