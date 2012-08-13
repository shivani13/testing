//
//  ArticleDetailViewController.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/9/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiArticleDetailViewController.h"
#import "WiFiUtilities.h"
#import "Twitter/Twitter.h"
#import "CoreData+MagicalRecord.h"
#import "WiFiFavoriteArticlesModel.h"
#import <CoreData/CoreData.h>

@interface WiFiArticleDetailViewController ()

@end

@implementation WiFiArticleDetailViewController
@synthesize articleDetailsWebView;
@synthesize articleContent;
@synthesize articleImageUrl;
@synthesize articleTitle;
@synthesize articleUrl;
@synthesize articleTitleLabel;
@synthesize shareActionSheet;
@synthesize isFavorite;
@synthesize favoriteArticleButton;
@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithArticleContent:(NSString *)content articleTitle:(NSString *)title articleUrl:(NSString *)url articleImageUrl:(NSString *)imageUrl {
    
    self = [super init];
    if (self) {
        
        articleContent=[content retain];
        articleTitle=[title retain];
        articleUrl=[url retain];
        articleImageUrl=[imageUrl retain];
    }
    return self;
    
}


- (IBAction)favoriteButtonClicked:(id)sender {
    
    if (isFavorite) {
        
        [favoriteArticleButton setImage:[UIImage imageNamed:@"favorite-icon.png"]
                     forState:UIControlStateNormal];
        [self removeFavorite];
        isFavorite=NO;
    }
    else {
        
        [favoriteArticleButton setImage:[UIImage imageNamed:@"favorite-icon-active.png"]
                               forState:UIControlStateNormal];
        [self saveFavorite];
        
        isFavorite=YES;
    }
}

- (void)saveFavorite {
    // Get the local context 
   
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Create a new Person in the current thread context
    WiFiFavoriteArticlesModel *favoriteArticle = [WiFiFavoriteArticlesModel MR_createInContext:localContext];
         favoriteArticle.articleUrl = articleUrl;
         favoriteArticle.articleTitle = articleTitle;
         favoriteArticle.articleContent = articleContent;
         favoriteArticle.articleImageUrl =articleImageUrl;
    // Save the modification in the local context   
    [localContext MR_save];
    
}

- (void) removeFavorite {
    // Get the local context
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_contextForCurrentThread];
    
    // Retrieve the first person who have the given firstname
    WiFiFavoriteArticlesModel *articleFound = [WiFiFavoriteArticlesModel MR_findFirstByAttribute:@"articleUrl" 
                                                                                       withValue:articleUrl 
                                                                                       inContext:localContext];
    
    if (articleFound) {
        
        // Delete the person found
        [articleFound MR_deleteInContext:localContext];
        
        // Save the modification in the local context
        [localContext MR_save];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [articleDetailsWebView loadHTMLString:articleContent baseURL:nil];
    // Do any additional setup after loading the view from its nib.
    self.articleTitleLabel.text = articleTitle;
    self.title = @"Article";
    UIBarButtonItem *shareArticleButton = [[[UIBarButtonItem alloc] 
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                 target:self 
                                                                 action:@selector(showActionSheet:)]autorelease];
    
    self.navigationItem.rightBarButtonItem = shareArticleButton;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    isFavorite = [self isFavoriteArticle];
    if (isFavorite) {
        
        [favoriteArticleButton setImage:[UIImage imageNamed:@"favorite-icon-active.png"]
                               forState:UIControlStateNormal];
    }
    else {
        
        [favoriteArticleButton setImage:[UIImage imageNamed:@"favorite-icon.png"]
                               forState:UIControlStateNormal];
    }
}

-(BOOL)isFavoriteArticle {
    // Get the local context
    
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    // Retrieve the first person who have the given firstname
    WiFiFavoriteArticlesModel *articleFound = [WiFiFavoriteArticlesModel MR_findFirstByAttribute:@"articleUrl" 
                                                                                       withValue:articleUrl 
                                                                                       inContext:localContext];
    if (articleFound) {
        
        return YES;
    }
    
    else {
        
        return NO;
    }
}

-(IBAction)showActionSheet:(id)sender {
    
    shareActionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Share %@",articleTitle] 
                                                   delegate:self 
                                          cancelButtonTitle:@"Cancel" 
                                     destructiveButtonTitle:nil 
                                          otherButtonTitles:@"Facebook",@"Twitter",@"Email", nil];
    [shareActionSheet showFromBarButtonItem:sender animated:YES];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        [[WiFiUtilities sharedInstance] shareOnFacebook:articleTitle url:articleUrl];
    }
    else if (buttonIndex == 1) {
        
        if ([TWTweetComposeViewController canSendTweet]) {
            
            TWTweetComposeViewController *tweetSheet = 
            [[[TWTweetComposeViewController alloc] init]autorelease];
            [tweetSheet setInitialText:
             [NSString stringWithFormat:@"Link : %@ %@",articleUrl,articleTitle]];
            [self presentModalViewController:tweetSheet animated:YES];
        }
        else {
            
            UIAlertView *twitterAlert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:@"Twitter Account Not Configured!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [twitterAlert show];
            [twitterAlert release];
        }
    }
    else if (buttonIndex == 2) {
      
        [self shareOnMail:articleTitle url:articleUrl];
    }
    else {
        NSLog(@"Cancel");
    }
    [shareActionSheet release];
}

- (void) shareOnMail:(NSString *)title url:(NSString *)url {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    if([MFMailComposeViewController canSendMail]) {
        
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


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error { 
    // Notifies users about errors associated with the interface
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {
            UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Mail Discarded" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [emailAlert show];
            [emailAlert release];
            
            break;
        }
            
        case MFMailComposeResultSaved:
        {
            UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Mail Saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [emailAlert show];
            [emailAlert release];
            
            break;
        }
        case MFMailComposeResultSent:
        {
            UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Mail Sent Sucessfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [emailAlert show];
            [emailAlert release];
            
            break;
        }
        case MFMailComposeResultFailed:
            break;
            
        default:
        {
            UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-(" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [emailAlert show];
            [emailAlert release];
        }
            
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setArticleDetailsWebView:nil];
    [self setArticleTitleLabel:nil];
    [self setFavoriteArticleButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [articleDetailsWebView release];
    [articleTitleLabel release];
    [favoriteArticleButton release];
    [super dealloc];
}
@end
