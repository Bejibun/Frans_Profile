//
//  ViewController.m
//  Tutorial 3
//
//  Created by Vensi Developer on 11/4/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#define deg2rad (M_PI/180.0f)

@interface ViewController ()

@end

@implementation ViewController
@synthesize redbutton,blackbutton,bluebutton;

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
    
    [self.redbutton.layer setCornerRadius:8.0f];
    [self.redbutton.layer setMasksToBounds:YES];
    [self.redbutton.layer setBorderWidth:1.0f];
    [self.redbutton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.bluebutton.layer setCornerRadius:8.0f];
    [self.bluebutton.layer setMasksToBounds:YES];
    [self.bluebutton.layer setBorderWidth:1.0f];
    [self.bluebutton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.blackbutton.layer setCornerRadius:8.0f];
    [self.blackbutton.layer setMasksToBounds:YES];
    [self.blackbutton.layer setBorderWidth:1.0f];
    [self.blackbutton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.scrollView setContentSize:CGSizeMake(200, 720)];
    
    [self.tap addTarget:self action:@selector(buttonTouchDownRepeat:event:) forControlEvents:UIControlEventTouchDown];
    
    isNotRecording = YES;
    playBtn.hidden = YES;
    recStateLabel.text = @"Not Recording";
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    NSFileManager *filehandler = [NSFileManager defaultManager];
    [filehandler removeItemAtURL:temporaryRecFile error:nil];
    recorder = nil;
    temporaryRecFile = nil;
    playBtn.hidden = YES;
}

-(IBAction)recording
{
    if(isNotRecording)
    {
        isNotRecording = NO;
        [recordBtn setTitle:@"Stop" forState:UIControlStateNormal];
        playBtn.hidden = YES;
        recStateLabel.text = @"Recording";
        temporaryRecFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"RecordedFile"]];
        recorder = [[AVAudioRecorder alloc]initWithURL:temporaryRecFile settings:nil error:nil];
        [recorder setDelegate:self];
        [recorder prepareToRecord];
        [recorder record];
    }
    else
    {
        isNotRecording = YES;
        [recordBtn setTitle:@"Rec" forState:UIControlStateNormal];
        playBtn.hidden = NO;
        recStateLabel.text = @"Not Recording";
        [recorder stop];
    }
}

-(IBAction)playback:(id)sender
{
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:temporaryRecFile error:nil];
    player.volume = 1;
    [player setDelegate:self];
    [player play];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
        [self.scrollView setScrollEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showOwner
{
    UIAlertView *owneralert = [[UIAlertView alloc]initWithTitle:@"Frans Raharja Kurniawan" message:@"Computer Information Science B.S." delegate:nil cancelButtonTitle:@"Like" otherButtonTitles:nil];
    owneralert.backgroundColor = [UIColor grayColor];
    [owneralert show];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"clap" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &beep);
    
    AudioServicesPlaySystemSound(beep);
}

-(IBAction)showInformation
{
    UIAlertView *informationalert = [[UIAlertView alloc] initWithTitle:@"Personal Information" message:@"Address : 485 Harley Dr APT 427 \n Columbus, OH 43202 \n Phone: 614-477-9257" delegate:nil cancelButtonTitle:@"Love It" otherButtonTitles:nil];
    informationalert.frame = CGRectMake(0, 0, 300, 200);
    informationalert.backgroundColor = [UIColor grayColor];
    [informationalert show];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"clap" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &beep);
    
    AudioServicesPlaySystemSound(beep);
}

-(IBAction)Website:(id)sender
{
    Website *nextViewController= [[Website alloc ]initWithNibName:@"Website" bundle:nil];
    [self.navigationController pushViewController:nextViewController animated:YES];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"beep" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &beep);
    
    AudioServicesPlaySystemSound(beep);
}

-(IBAction)contactMe:(id)sender
{
    ContactView *nextViewController= [[ContactView alloc]initWithNibName:@"ContactView" bundle:nil];
    [self.navigationController pushViewController:nextViewController animated:YES];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"beep" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &beep);
    
    AudioServicesPlaySystemSound(beep);
}

-(void)extras:(id)sender
{
    ExtraViewController *nextViewController= [[ExtraViewController alloc ]initWithNibName:@"ExtraViewController" bundle:nil];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

-(IBAction)DoRedButton:(id)sender
{
    [self.redbutton setTitle:@"Red!" forState:UIControlStateNormal];
    [self.bluebutton setTitle:@"Blue" forState:UIControlStateNormal];
    [self.blackbutton setTitle:@"Black" forState:UIControlStateNormal];
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.window.backgroundColor = [UIColor redColor];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"baa" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &beep);
    
    AudioServicesPlaySystemSound(beep);

}

-(IBAction)DoBlueButton:(id)sender
{
    [self.bluebutton setTitle:@"Blue!" forState:UIControlStateNormal];
    [self.redbutton setTitle:@"Red" forState:UIControlStateNormal];
    [self.blackbutton setTitle:@"Black" forState:UIControlStateNormal];
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.window.backgroundColor = [UIColor blueColor];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"chicken" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &beep);
    
    AudioServicesPlaySystemSound(beep);

}

-(IBAction)DoBlackButton:(id)sender
{
    [self.blackbutton setTitle:@"Black!" forState:UIControlStateNormal];
    [self.redbutton setTitle:@"Red" forState:UIControlStateNormal];
    [self.bluebutton setTitle:@"Blue" forState:UIControlStateNormal];
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.window.backgroundColor = [UIColor blackColor];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"dog" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &beep);
    
    AudioServicesPlaySystemSound(beep);
}

- (IBAction)muteUnmute:(id)sender
{
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:appdelegate.backMusic] error:NULL];
    
    self.playpause.selected = !self.playpause.selected;

    if(!self.playpause.selected)
    {
        // Play
        img = [UIImage imageNamed:@"play.png"];
        [self.soundBtn setImage:img];
        [appdelegate.audioPlayer play];

    }
    else
    {
        // Stop
        img = [UIImage imageNamed:@"mute.png"];
        [self.soundBtn setImage:img];
        [appdelegate.audioPlayer pause];

    }
}

-(void) buttonTouchDownRepeat:(id)sender event:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    if(touch.tapCount == 1)
    {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"scream_1" ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &beep);
        AudioServicesPlaySystemSound(beep);
    }
    else
    {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"scream_2" ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &beep);
        AudioServicesPlaySystemSound(beep);
    }
}

-(IBAction)takePhoto
{
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
}

-(IBAction)chooseExisting
{
    picker2 = [[UIImagePickerController alloc]init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    img2 = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imgView setImage:img2];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
