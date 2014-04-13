//
//  RNMapKitViewController.h
//  ruche
//
//  Created by Eddy RICHARD on 11/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class RNDisplayMap;

@interface RNMapKitViewController : UIViewController <MKMapViewDelegate> {
    
    IBOutlet MKMapView *mapView;
}

@property (retain, nonatomic) IBOutlet MKMapView *mapView;

@end
