//
//  MMProductDetail.m
//  WFProductsCategories
//
//  Created by Abhyuday Reddy on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WiFiProductDetailViewController.h"
#import "WiFiUtilities.h"
#import "Twitter/Twitter.h"
#import "WiFiSubInformationViewController.h"
#import "CoreData+MagicalRecord.h"
#import "WiFiFavoriteProductsModel.h"
#import "WiFiCertificationDetailsViewController.h"

@implementation WiFiProductDetailViewController

@synthesize productsFavoriteButton;
@synthesize certificateIDLabel;
@synthesize companyLabel;
@synthesize productLabel;
@synthesize modelLabel;
@synthesize categoryLabel;
@synthesize certificationDateLabel;
@synthesize final;
@synthesize shareActionSheet;
@synthesize isFavorite;
@synthesize managedObjectContext;
@synthesize certificateButton;
@synthesize infoButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithFinalData:(WiFiJSONDataModel *)data{
    self.final = [data retain];
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = final.product;
    
    certificateIDLabel.text = [NSString stringWithFormat:@"Certification ID : %@",final.certificationId];
    companyLabel.text = final.company;
    productLabel.text = final.product;
    modelLabel.text = final.model;
    categoryLabel.text = final.category;
    
    UIBarButtonItem *shareProductButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                                         target:self 
                                                                                         action:@selector(showActionSheet:)]autorelease];
    self.navigationItem.rightBarButtonItem = shareProductButton;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setCertificationDateLabel:nil];
    [self setProductsFavoriteButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showActionSheet:(id)sender{
    shareActionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Share Product"] 
                                                   delegate:self 
                                          cancelButtonTitle:@"Cancel" 
                                     destructiveButtonTitle:nil 
                                          otherButtonTitles:@"Facebook",@"Twitter",@"Email", nil];
    
    [shareActionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)informationButtonClicked:(id)sender {
    
    WiFiSubInformationViewController *subInfoViewController = [[WiFiSubInformationViewController alloc] 
                                                               initWithSubInfoType:@"Wi-Fi Certified"];
    
    self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Back" 
                                                                             style:UIBarButtonItemStyleBordered 
                                                                            target:nil 
                                                                            action:nil] autorelease];
    
    [self.navigationController pushViewController:subInfoViewController animated:YES];
    [subInfoViewController release];
}

- (IBAction)favoriteButtonClicked:(id)sender {
    if (isFavorite) {
       
        [productsFavoriteButton setImage:[UIImage imageNamed:@"favorite-icon.png"]
                               forState:UIControlStateNormal];
        [self removeFavorite];
        isFavorite=NO;
    }
    else {
        
        [productsFavoriteButton setImage:[UIImage imageNamed:@"favorite-icon-active.png"]
                               forState:UIControlStateNormal];
        [self saveFavorite];
        
        isFavorite=YES;
    }
}

- (IBAction)certificationDetailButtonClicked:(id)sender {
    
    WiFiCertificationDetailsViewController *viewController = [[[WiFiCertificationDetailsViewController alloc] initWithNibName:@"WiFiCertificationDetailsViewController" bundle:nil] autorelease];
    //NSLog(@"THE URL IS : %@", final.certificationUrl);
    [viewController setCertificationUrl:final.certificationUrl];
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Back" 
                                                                             style:UIBarButtonItemStyleBordered 
                                                                            target:nil 
                                                                            action:nil] autorelease];
}

- (void)saveFavorite {
    // Get the local context 
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Create a new Person in the current thread context
    WiFiFavoriteProductsModel *favoriteProduct = [WiFiFavoriteProductsModel MR_createInContext:localContext];
    
    favoriteProduct.certificationUrl = final.certificationUrl;
    favoriteProduct.certificationId = final.certificationId;
    favoriteProduct.company = final.company;
    favoriteProduct.model = final.model;
    favoriteProduct.category = final.category;
    favoriteProduct.product = final.product;
    
    // Save the modification in the local context   
    [localContext MR_save];
}

- (void) removeFavorite{
    // Get the local context
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    WiFiFavoriteProductsModel *productFound = [WiFiFavoriteProductsModel MR_findFirstByAttribute:@"certificationId" 
                                                                                       withValue:final.certificationId 
                                                                                       inContext:localContext];
    
    if (productFound)
    {
        // Delete the person found
        [productFound MR_deleteInContext:localContext];
        
        // Save the modification in the local context
        [localContext MR_save];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    isFavorite = [self isFavoriteArticle];
    if (isFavorite) {
        
        [productsFavoriteButton setImage:[UIImage imageNamed:@"favorite-icon-active.png"]
                               forState:UIControlStateNormal];
    }
    else {
        
        [productsFavoriteButton setImage:[UIImage imageNamed:@"favorite-icon.png"]
                               forState:UIControlStateNormal];
    }
}

-(BOOL)isFavoriteArticle{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_contextForCurrentThread];
    
    // Retrieve the first person who have the given firstname
    WiFiFavoriteProductsModel *productFound = [WiFiFavoriteProductsModel MR_findFirstByAttribute:@"certificationId" 
                                                                                       withValue:final.certificationId 
                                                                                       inContext:localContext];
    if (productFound) {
        return YES;
    }else {
        return NO;
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *shareLink = [NSString stringWithFormat:@"http://certifications.wi-fi.org/pdf_certificate.php?cid=WFA%@",final.certificationId];
    if (buttonIndex == 0) {
    
        [[WiFiUtilities sharedInstance] shareOnFacebook:final.product url:shareLink];
    }
    else if (buttonIndex == 1) {
        
        if ([TWTweetComposeViewController canSendTweet])
        {
        
            TWTweetComposeViewController *tweetSheet = 
            [[[TWTweetComposeViewController alloc] init]autorelease];
            [tweetSheet setInitialText: [NSString stringWithFormat:@"Link : %@ %@",shareLink,final.product]];
            [self presentModalViewController:tweetSheet animated:YES];
        }
        else {
            
            UIAlertView *twitterAlert = [[UIAlertView alloc] initWithTitle:@"Twitter" 
                                                                   message:@"Twitter Account Not Configured!!!" 
                                                                  delegate:self 
                                                         cancelButtonTitle:@"OK" 
                                                         otherButtonTitles: nil];
            [twitterAlert show];
            [twitterAlert release];
        }
        
    }
    else if (buttonIndex == 2){
        
        [self shareOnMail:final.product url:shareLink];
    }
    else {
        NSLog(@"Cancel");
    }
    
    [shareActionSheet release];
}

- (void) shareOnMail:(NSString *)title url:(NSString *)url{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    if([MFMailComposeViewController canSendMail])
    {
        picker.mailComposeDelegate=self;
       
        [picker setSubject:[NSString stringWithFormat:@"%@ : Wi-Fi Alliance Link",title]];
        
        // Fill out the email body text
        NSString *emailBody =url;
        
        [picker setMessageBody:emailBody isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
        
        picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
        
        [self presentModalViewController:picker animated:YES];
    }
    [picker release];
    
    
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{ 
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {
            UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:@"Email" 
                                                                 message:@"Mail Discarded" 
                                                                delegate:self 
                                                       cancelButtonTitle:@"OK" 
                                                       otherButtonTitles: nil];
            [emailAlert show];
            [emailAlert release];
            
            break;
        }
            
        case MFMailComposeResultSaved:
        {
            UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:@"Email" 
                                                                 message:@"Mail Saved" 
                                                                delegate:self 
                                                       cancelButtonTitle:@"OK" 
                                                       otherButtonTitles: nil];
            [emailAlert show];
            [emailAlert release];
            
            break;
        }
        case MFMailComposeResultSent:
        {
            UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:@"Email" 
                                                                 message:@"Mail Sent Sucessfully" 
                                                                delegate:self 
                                                       cancelButtonTitle:@"OK" 
                                                       otherButtonTitles: nil];
            [emailAlert show];
            [emailAlert release];
            
            break;
        }
        case MFMailComposeResultFailed:
            break;
            
        default:
        {
            UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:@"Email" 
                                                                 message:@"Sending Failed - Unknown Error :-(" 
                                                                delegate:self 
                                                       cancelButtonTitle:@"OK" 
                                                       otherButtonTitles: nil];
            [emailAlert show];
            [emailAlert release];
        }
            
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}



- (void)dealloc {
    [certificationDateLabel release];
    [productsFavoriteButton release];
    [final release];
    [super dealloc];
}
@end
