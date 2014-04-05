//
//  CoolViewController.m
//  Frans Profile
//
//  Created by Vensi Developer on 11/27/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import "CoolViewController.h"
#import "NavigationController.h"
using namespace cv;

NSString* const faceCascadeFilename = @"haarcascade_frontalface_alt2";
const int HaarOptions = CV_HAAR_FIND_BIGGEST_OBJECT | CV_HAAR_DO_ROUGH_SEARCH;

@interface CoolViewController ()

@end

@implementation CoolViewController
{
    IBOutlet UIImageView* imageView;
    CvVideoCamera* videoCamera;
    CascadeClassifier faceCascade;
}

@synthesize videoCamera;

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
    self.navigationItem.title = @"Face Detection";
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 50;
    self.videoCamera.grayscaleMode = NO;
    self.videoCamera.delegate = self;
    NSString* faceCascadePath = [[NSBundle mainBundle] pathForResource:faceCascadeFilename ofType:@"xml"];
    faceCascade.load([faceCascadePath UTF8String]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus

- (void)processImage:(Mat&)image;
{
    Mat grayscaleFrame;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"santahat" ofType:@"bmp"];
    Mat hatBuffer = imread([filePath cStringUsingEncoding:NSUTF8StringEncoding]);
    cvtColor(image, grayscaleFrame, CV_BGR2GRAY);
    equalizeHist(grayscaleFrame, grayscaleFrame);
    Mat hatResized;
    std::vector<cv::Rect> faces;
    faceCascade.detectMultiScale(grayscaleFrame, faces, 1.1, 2, HaarOptions, cv::Size(80, 80));
    
    for (int i = 0; i < faces.size(); i++)
    {
        if(!hatBuffer.data)
        {
            NSLog(@"No Data image in hatBuffer");
        }

        //cv::resize(hatBuffer, hatResized,cv::Size(faces[i].width -20,faces[i].height - 20));
        cv::Point pt1(faces[i].x + faces[i].width, faces[i].y + faces[i].height);
        cv::Point pt2(faces[i].x, faces[i].y);
        //cv::Rect hatRegion(faces[i].x+10, faces[i].y-hatResized.rows, hatResized.cols, hatResized.rows);
        cv::rectangle(image, pt1, pt2, cvScalar(0, 255, 0, 0), 2, 8 ,0);
        //hatResized.copyTo(image);
        //cv::rectangle(image, hatRegion, cvScalar(0, 255, 0, 0), 0, 8 ,0);
    }
}

#endif

#pragma mark - UI Actions

- (IBAction)startCamera:(id)sender
{
    [videoCamera start];
}

- (IBAction)stopCamera:(id)sender
{
    [self.videoCamera stop];
}


@end
