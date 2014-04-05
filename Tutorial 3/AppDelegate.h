//
//  AppDelegate.h
//  Tutorial 3
//
//  Created by Vensi Developer on 11/4/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>

@property (strong,nonatomic) AVAudioPlayer *audioPlayer;

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) NSString *backMusic;

-(NSMutableDictionary *)decodeData:(NSManagedObject *)managedObject;

@end