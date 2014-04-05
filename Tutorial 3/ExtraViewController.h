//
//  ExtraViewController.h
//  Frans Profile
//
//  Created by Vensi Developer on 11/26/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "CoolViewController.h"
#import "MapsViewController.h"
#import <AVFoundation/AVFoundation.h>

@class CoolViewController;

@interface ExtraViewController : UIViewController<AVAudioRecorderDelegate,AVAudioPlayerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>
{
    UIImagePickerController *picker3;
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    UIButton *playButton;
    UIButton *recordButton;
    UIButton *stopButton;
}

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

-(IBAction) recordAudio;
-(IBAction) playAudio;
-(IBAction) stop;
-(IBAction) selfie;
-(IBAction) maps;
-(IBAction) coolFeature:(id)sender;

@end
