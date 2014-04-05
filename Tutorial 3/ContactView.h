//
//  ContactView.h
//  Tutorial 3
//
//  Created by Vensi Developer on 11/4/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface ContactView : UIViewController<MFMailComposeViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    MFMailComposeViewController *submitController;
}
@property (strong, nonatomic) IBOutlet UITextView *msgbox;

@property (strong, nonatomic) IBOutlet UIButton *submitbtn;

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;

@property (nonatomic,weak) NSMutableArray *list;

@property(nonatomic, retain) NSMutableDictionary *identifier;

@property (nonatomic) IBOutlet UITextField *nameField;

@property (nonatomic) IBOutlet UITextField *emailField;

@property (nonatomic) IBOutlet UITextField *contactField;

@property (nonatomic) IBOutlet UITextField *subject;

@property (nonatomic) IBOutlet UITextView *mssgField;

@property (nonatomic) UITextField *fieldtext;

@property AppDelegate *delegate;

- (BOOL)validateName:(NSString *) name;

- (BOOL)validateEmail:(NSString *) emailtext;

- (BOOL)validateContactNum:(NSString *) contactnum;

-(IBAction)submitbuttonclicked:(id)sender;

@end
