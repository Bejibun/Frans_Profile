//
//  ViewController.h
//  Tutorial 3
//
//  Created by Vensi Developer on 11/4/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Website.h"
#import "ContactView.h"
#import "ExtraViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    IBOutlet UIImageView *imgView;
    UIImage *img,*img2;
    SystemSoundID beep;
    UIButton *playBtn;
    UIButton *recordBtn;
    IBOutlet UILabel *recStateLabel;
    
    bool isNotRecording;
    NSURL *temporaryRecFile;
    AVAudioRecorder *recorder;
    
}

-(IBAction)showOwner;

-(IBAction)showInformation;

-(IBAction)Website:(id)sender;

-(IBAction)contactMe:(id)sender;

-(IBAction)extras:(id)sender;

-(IBAction)muteUnmute:(id)sender;

-(IBAction)DoRedButton:(id)sender;

-(IBAction)DoBlueButton:(id)sender;

-(IBAction)DoBlackButton:(id)sender;

-(IBAction)playback:(id)sender;

-(IBAction)takePhoto;

-(IBAction)chooseExisting;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIImageView *soundBtn;

@property IBOutlet UIButton *website;

@property IBOutlet UIButton *contactme;

@property IBOutlet UIButton *redbutton;

@property IBOutlet UIButton *bluebutton;

@property IBOutlet UIButton *blackbutton;

@property IBOutlet UIButton *playpause;

@property (strong, nonatomic) IBOutlet UIButton *tap;

@end
