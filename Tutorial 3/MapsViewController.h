//
//  MapsViewController.h
//  Frans Profile
//
//  Created by Vensi Developer on 12/18/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKAnnotation.h>
#import "JFMapAnnotation.h"

@interface MapsViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)addCitiesToMap:(id)sender;
- (void)addGestureRecogniserToMapView;
- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer;
- (NSMutableArray *)parseJSONCities;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *myPlace;

@end