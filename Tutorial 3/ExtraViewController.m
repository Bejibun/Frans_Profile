//
//  ExtraViewController.m
//  Frans Profile
//
//  Created by Vensi Developer on 11/26/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import "ExtraViewController.h"

@interface ExtraViewController ()

@end

@implementation ExtraViewController
@synthesize playButton,recordButton,stopButton;

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
    self.navigationItem.title = @"FUN Time";
    // Do any additional setup after loading the view from its nib.
    playButton.enabled = NO;
    stopButton.enabled = NO;
    
    [self.scrollView setContentSize:CGSizeMake(200, 720)];
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    audioRecorder = [[AVAudioRecorder alloc]
                     initWithURL:soundFileURL
                     settings:recordSettings
                     error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
        
    } else {
        [audioRecorder prepareToRecord];
    }
    

}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *EmbedCode = @"<iframe width=\"280\" height=\"200\" src=\"http://www.youtube.com/embed/nbp3Ra3Yp74\" frameborder=\"0\" allowfullscreen></iframe>";
    [[self webView] loadHTMLString:EmbedCode baseURL:nil];
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

-(void) recordAudio
{
    if (!audioRecorder.recording)
    {
        playButton.enabled = NO;
        stopButton.enabled = YES;
        [audioRecorder record];
    }
}
-(void)stop
{
    stopButton.enabled = NO;
    playButton.enabled = YES;
    recordButton.enabled = YES;
    
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
}
-(void) playAudio
{
    if (!audioRecorder.recording)
    {
        stopButton.enabled = YES;
        recordButton.enabled = NO;
        
        NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc]
                       initWithContentsOfURL:audioRecorder.url
                       error:&error];
        
        audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
            [audioPlayer play];
    }
}

-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    recordButton.enabled = YES;
    stopButton.enabled = NO;
}
-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player
                                error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}
-(void)audioRecorderDidFinishRecording:
(AVAudioRecorder *)recorder
                          successfully:(BOOL)flag
{
}
-(void)audioRecorderEncodeErrorDidOccur:
(AVAudioRecorder *)recorder
                                  error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}

-(IBAction)selfie
{
    picker3 = [[UIImagePickerController alloc]init];
    picker3.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker3.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    picker3.delegate = self;
    
    [picker3 setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker3 animated:YES completion:NULL];
}

-(IBAction)maps
{
    MapsViewController *nextViewController= [[MapsViewController alloc ]initWithNibName:@"MapsViewController" bundle:nil];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

-(IBAction)coolFeature:(id)sender
{
    CoolViewController *nextViewController= [[CoolViewController alloc ]initWithNibName:@"CoolViewController" bundle:nil];
    [self.navigationController pushViewController:nextViewController animated:YES];
}


@end
