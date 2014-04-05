//
//  CoolViewController.h
//  Frans Profile
//
//  Created by Vensi Developer on 11/26/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/objdetect/objdetect.hpp>

@interface CoolViewController : UIViewController<CvVideoCameraDelegate>

@property (nonatomic, retain) CvVideoCamera* videoCamera;
@property (nonatomic, retain) CALayer *customPreviewLayer;

- (IBAction)startCamera:(id)sender;
- (IBAction)stopCamera:(id)sender;

@end
