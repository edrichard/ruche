//
//  RNDisplayMap.h
//  ruche
//
//  Created by Eddy RICHARD on 11/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface RNDisplayMap : NSObject <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
