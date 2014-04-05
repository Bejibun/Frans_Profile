//
//  AppDelegate.m
//  Tutorial 3
//
//  Created by Vensi Developer on 11/4/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.backMusic = [[NSBundle mainBundle]pathForResource:@"Music1" ofType:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:self.backMusic] error:NULL];
    //self.audioPlayer.delegate = self;
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer play];
    
    ViewController *viewcontroller = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    viewcontroller.title = @"Frans";
    NavigationController *navcontroller = [[NavigationController alloc]initWithRootViewController:viewcontroller ];
    navcontroller.navigationBar.backgroundColor = [UIColor redColor];
    self.window.rootViewController = navcontroller;
    self.window.backgroundColor = [UIColor brownColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(NSMutableDictionary *)decodeData:(NSManagedObject *)managedObject{
    NSData *data = [[managedObject dictionaryWithValuesForKeys:[NSArray arrayWithObject:@"ContactView"]] objectForKey:@"ContactView"];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSMutableDictionary *contactDict = [unarchiver decodeObjectForKey:@"ContactData"];
    [unarchiver finishDecoding];
    return contactDict;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    NSString *string= @"11/21/2013";
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"MM/DD/YYYY"];
//    NSDate *notificationDate = [formatter dateFromString:string];
    NSDate *notificationDate = [[NSDate date]dateByAddingTimeInterval:3];
    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *notif = [[UILocalNotification alloc]init];
    if(notif)
    {
        notif.fireDate = notificationDate;
        notif.timeZone = [NSTimeZone defaultTimeZone];
        notif.repeatInterval = 2;
        notif.alertBody = @"Frans is Here";
        notif.soundName = @"dog.wav";
        notif.alertAction = @"Hellooo";
        notif.applicationIconBadgeNumber = 1;
        [app scheduleLocalNotification:notif];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
