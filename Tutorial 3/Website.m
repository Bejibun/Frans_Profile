//
//  Website.m
//  Frans Profile
//
//  Created by Vensi Developer on 11/6/13.
//  Copyright (c) 2013 Vensi, Inc. All rights reserved.
//

#import "Website.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface Website ()

@end

@implementation Website
@synthesize webView;

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
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Flip"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(flipView:)];
    self.navigationItem.rightBarButtonItem = flipButton;
    [self.textView setScrollEnabled:YES];
    self.textView.backgroundColor = [UIColor colorWithRed:(205/255.0) green:(183/255.0) blue:(158/255.0) alpha:1.0];
    self.title = @"Website";
    self.textView.layer.cornerRadius = 10.0;
    self.textView.layer.masksToBounds = YES;
    [self.textView setAllowsEditingTextAttributes: YES];
    [self.textView setSelectable: YES];
    
    NSString *website = [NSString stringWithFormat:@"\nhttp://www.franskurniawan.com"];
    NSString *linkedin = [NSString stringWithFormat:@"\nhttp://www.linkedin.com/pub/frans-kurniawan/52/931/293/"];
    NSString *blogspot = [NSString stringWithFormat:@"\nhttp://fransclub.blogspot.com"];
    NSString *resume = [NSString stringWithFormat:@"\nhttp://www.mediafire.com/view/t9xg14qhg8g38fd/Resume%%20Software%%20Developer%%20Frans%%20Kurniawan.pdf"];
    NSString *coverletter = [NSString stringWithFormat:@"\nhttp://www.mediafire.com/view/obz77um9dlrw5dr/Cover%%20Chicago%%20Software%%20Developer%%20Frans%%20Kurniawan.docx"];
    NSString *cplusplus = [NSString stringWithFormat:@"\nhttp://www.mediafire.com/download/iit7pfpnihh8d12/C%%2B%%2B%%20Project.zip"];
    NSString *sql = [NSString stringWithFormat:@"\nhttp://www.mediafire.com/download/ldp0awd5w8kbvbv/SQL_Project%%20-%%20Frans%%20Kurniawan%%20(%%20Techligent%%20Company%%20).zip"];
    NSString *unity = [NSString stringWithFormat:@"\nhttp://www.mediafire.com/download/8x2t4h30fg2t1gq/Unity.zip"];
    NSString *python = [NSString stringWithFormat:@"\nhttp://www.mediafire.com/download/nen40qhh2d2b0m7/Python.zip"];
    NSString *networking = [NSString stringWithFormat:@"\nhttp://www.mediafire.com/download/6oj25ixe8q6ufm4/networking.zip"];
    NSString *matlab = [NSString stringWithFormat:@"\nhttp://www.mediafire.com/download/jk0q03ub3xu8b2t/matlab.zip"];
    NSString *assembly = [NSString stringWithFormat:@"\nhttp://www.mediafire.com/download/m9u1izd2pp43ez3/Assembly.zip"];
    
    self.textView.text = @"Name : Frans Raharja Kurniawan\n\n";
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"Website :%@",website];
    self.textView.text = [self.textView.text stringByAppendingString:@"\n\nfacebook email :\nfransraharja@yahoo.com"];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nLinkedIn :%@",linkedin];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nBlogspot :%@",blogspot];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nResume :%@", resume];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nCover Letter :%@",coverletter];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nC++ :%@", cplusplus];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nSQL :%@",sql];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nUnity :%@",unity];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nPython :%@",python];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nNetworking :%@",networking];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nMatlab :%@",matlab];
    self.textView.text  = [self.textView.text stringByAppendingFormat:@"\n\nAssembly :%@\n\n\n\n\n",assembly];
    [self.view sendSubviewToBack:webViews];
    [self.textView setFont:[UIFont fontWithName:@"Courier New" size:12]];
    [self.textView setFont:[UIFont boldSystemFontOfSize:14]];

    // Do any additional setup after loading the view from its nib.
}

-(IBAction)flipView:(id)sender
{
    [webViews setHidden:YES];
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{

    NSLog(@"URL %@",URL); // URL // pop webkit
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:URL];
    if(URL)
    {
        [webViews loadRequest:requestObj];
        [webViews setHidden:NO];
    }
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [webViews setHidden:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
