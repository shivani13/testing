//
//  WiFiInformationViewController.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/24/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiInformationViewController.h"
#import "WiFiSubInformationViewController.h"

@interface WiFiInformationViewController ()
@end

@implementation WiFiInformationViewController

@synthesize informationTableView;

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
    
    tableFields = [[NSArray arrayWithObjects:@"About Us",@"Terms Of Use",@"Email Feedback", nil] retain];
    
    self.title=@"Information";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setInformationTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableFields.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = nil;
    
    if(cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    cell.textLabel.text = [tableFields objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        WiFiSubInformationViewController *subInfoViewController = [[WiFiSubInformationViewController alloc] initWithSubInfoType:@"About Us"];
        self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        [self.navigationController pushViewController:subInfoViewController animated:YES];
        [subInfoViewController release];
    }
    
    else if (indexPath.row == 1) {
        
        WiFiSubInformationViewController *subInfoViewController = [[WiFiSubInformationViewController alloc] initWithSubInfoType:@"Terms Of Use"];
        self.navigationItem.backBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        [self.navigationController pushViewController:subInfoViewController animated:YES];
        [subInfoViewController release];
    }
    
    else {
        
        [self sendFeedback];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) sendFeedback {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    if([MFMailComposeViewController canSendMail])
    {
        picker.mailComposeDelegate=self;
        //picker.delegate = self;
        [picker setSubject:[NSString stringWithString : @"Wi-Fi Alliance IOS App Feedback"]];
        
        // Fill out the email body text
        NSString *emailBody =@"Enter Your Feedback Here!";
        NSArray *toEmail = [[[NSArray alloc] initWithObjects:@"feedback@wifialliance.com", nil]autorelease];
        [picker setToRecipients:toEmail];
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

- (void)dealloc {
    
    [informationTableView release];
    [super dealloc];
}
@end
