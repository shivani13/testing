//
//  WiFiSubInformationViewController.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/24/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiSubInformationViewController.h"
#import "Constants.h"

@interface WiFiSubInformationViewController ()

@end

@implementation WiFiSubInformationViewController
@synthesize subInfoLabel;
@synthesize subInfoWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSubInfoType:(NSString *)info {
    
    subInfoLabelText=info;
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    subInfoLabel.text = subInfoLabelText;
    self.title = @"Information";
    if ([subInfoLabelText isEqualToString:@"About Us"]) {
        
        [subInfoWebView loadHTMLString:kAboutUs_WebView baseURL:nil];
    }
    else if([subInfoLabelText isEqualToString:@"Terms Of Use"]) {
        
        [subInfoWebView loadHTMLString:kTermsOfUse_WebView baseURL:nil];
    }
    else {
        
        [subInfoWebView loadHTMLString:kInformation_Certificate baseURL:nil];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSubInfoLabel:nil];
    [self setSubInfoWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [subInfoLabel release];
    [subInfoWebView release];
    [super dealloc];
}
@end
