//
//  Website.h
//  Frans Profile
//
//  Created by Vensi Developer on 11/6/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"

@interface Website : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webViews;
}

@property (strong,nonatomic) UIButton *flipButton;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIWebView *webView;



@property AppDelegate *delegate;


@end
