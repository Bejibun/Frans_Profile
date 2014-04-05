//
//  MapsViewController.m
//  Frans Profile
//
//  Created by Vensi Developer on 12/18/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import "MapsViewController.h"

@interface MapsViewController ()

@end

@implementation MapsViewController
@synthesize mapView;

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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Maps";
    self.navigationItem.rightBarButtonItem = self.myPlace;
    mapView.showsUserLocation = YES;
    mapView.showsBuildings = YES;

    [mapView setDelegate:self];
    [self addGestureRecogniserToMapView];
}

- (void)addGestureRecogniserToMapView{
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(addPinToMap:)];
    lpgr.minimumPressDuration = 0.5; //
    [self.mapView addGestureRecognizer:lpgr];
    
}

- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    JFMapAnnotation *toAdd = [[JFMapAnnotation alloc]init];
    
    toAdd.coordinate = touchMapCoordinate;
    toAdd.subtitle = @"Subtitle";
    toAdd.title = @"Title";
    
    [self.mapView addAnnotation:toAdd];
    
}

- (IBAction)addCitiesToMap:(id)sender{
    
    __block NSArray *annoations;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        annoations = [self parseJSONCities];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [self.mapView addAnnotations:annoations];
            
        });
    });
    
}

- (NSMutableArray *)parseJSONCities{
    
    NSMutableArray *retval = [[NSMutableArray alloc]init];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"place"
                                                         ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:kNilOptions
                                                      error:&error];
    
    for (JFMapAnnotation *record in json) {
        
        JFMapAnnotation *temp = [[JFMapAnnotation alloc]init];
        [temp setTitle:[record valueForKey:@"City"]];
        [temp setSubtitle:[record valueForKey:@"Country"]];
        [temp setCoordinate:CLLocationCoordinate2DMake([[record valueForKey:@"Latitude"]floatValue], [[record valueForKey:@"Longitude"]floatValue])];
        [retval addObject:temp];
        
    }
    
    return retval;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
