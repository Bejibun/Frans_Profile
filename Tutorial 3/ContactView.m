//
//  ContactView.m
//  Tutorial 3
//
//  Created by Vensi Developer on 11/4/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import "ContactView.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#define kOFFSET_FOR_KEYBOARD 80.0

@interface ContactView ()

@end

@implementation ContactView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Contact Me!";
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 1050)];
    self.submitbtn.layer.cornerRadius = 10.0;
    self.submitbtn.backgroundColor = [UIColor whiteColor];
    self.submitbtn.layer.masksToBounds = YES;
    self.msgbox.layer.cornerRadius = 10.0;
    self.msgbox.layer.masksToBounds = YES;
    self.nameField.delegate = self;
    self.emailField.delegate = self;
    self.contactField.delegate = self;
    self.subject.delegate = self;
    self.mssgField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

-(void)keyboardWillShow
{
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    [self setViewMovedUp:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)sender
{
    [self setViewMovedUp:YES];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
        [self.scrollView setScrollEnabled:YES];
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        [self.scrollView setScrollEnabled:YES];
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}

- (BOOL)validateName:(NSString *) name
{
    NSString *nameRegex = @"[A-Za-z]{1,14}";
    NSPredicate *checkName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [checkName evaluateWithObject:name];
}

- (BOOL)validateEmail:(NSString *) emailtext
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailtext];
}

- (BOOL)validateContactNum:(NSString *) contactnum
{
    NSString *contactRegex = @"([0-9]{3})[-. ]?([0-9]{3})[-. ]?([0-9]{4})";
    NSPredicate *checkContact = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", contactRegex];
    return [checkContact evaluateWithObject:contactnum];
}

-(IBAction)submitbuttonclicked:(id)sender
{
    submitController = [[MFMailComposeViewController alloc]init];
    [submitController setMailComposeDelegate:self];
    NSString *email = @"fransraharja@yahoo.com";

    NSArray *emailArray = [[NSArray alloc] initWithObjects:email, nil];
    NSString *sub = [[NSString alloc]init];
    sub = self.subject.text;
    
    NSMutableString *message = [[NSMutableString alloc] init];
    [message appendString:@"<br>Name:"];
    [message appendString:self.nameField.text];
    [message appendString:@"<br><br>Email Address:"];
    [message appendString:self.emailField.text];
    [message appendString:@"<br><br>Phone Number:"];
    [message appendString:self.contactField.text];
    [message appendString:@"<br><br>Message:<br>"];
    [message appendString:self.mssgField.text];
    [message appendString:@"<br><br>Have a Great Day!"];
    
    [submitController setMessageBody:message isHTML:YES];
    [submitController setToRecipients:emailArray];
    [submitController setSubject:sub];
    
    if(([self validateEmail:self.emailField.text]) && ([self validateContactNum:self.contactField.text]) && ([self validateName:self.nameField.text]))
    {
        UIAlertView *sentAlertView = [[UIAlertView alloc] initWithTitle:@"Directing to email" message:@"Recipient : fransraharja@yahoo.com" delegate:nil cancelButtonTitle:@"Gotcha" otherButtonTitles:nil];
        [sentAlertView show];
        [self presentViewController:submitController animated:YES completion:nil];
    }
    else if([self validateName:self.nameField.text] == false)
    {
        UIAlertView *namealert = [[UIAlertView alloc] initWithTitle:@"Invalid Name!" message:@"Name Up to 14 characters and no #" delegate:nil cancelButtonTitle:@"Fix It" otherButtonTitles:nil];
        [namealert show];
    }
    else if([self validateEmail:self.emailField.text] == false)
    {
        UIAlertView *emailalert = [[UIAlertView alloc] initWithTitle:@"Invalid Email!" message:@"Please Use the Valid Email Address" delegate:nil cancelButtonTitle:@"Fix It" otherButtonTitles:nil];
        [emailalert show];

    }
    else if([self validateContactNum:self.contactField.text] == false)
    {
        UIAlertView *contactalert = [[UIAlertView alloc] initWithTitle:@"Invalid Contact Number!" message:@"Please Type in xxx-xxx-xxxx" delegate:nil cancelButtonTitle:@"Fix It" otherButtonTitles:nil];
        [contactalert show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if(result == MFMailComposeResultSent){
        if(controller == submitController){
            UIAlertView *sent = [[UIAlertView alloc] initWithTitle:@"Message Sent" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [sent show];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
