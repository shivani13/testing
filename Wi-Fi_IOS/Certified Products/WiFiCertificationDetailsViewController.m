//
//  MMCertificationDetails.m
//  Wi-Fi_IOS
//
//  Created by Abhyuday Reddy on 28/05/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiCertificationDetailsViewController.h"
#import "AFJSONRequestOperation.h"
#import "NSString+HTML.h"

@interface WiFiCertificationDetailsViewController ()

@end

@implementation WiFiCertificationDetailsViewController
@synthesize certificationUrl;
@synthesize certificationTable;
@synthesize certificateModelLabel;
@synthesize certificateIdLabel;


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
    self.title = @"Certification Detail";

    certificateData_ = [[NSMutableArray alloc] init];
    mainDict_ = [[NSMutableDictionary alloc] init];
    [self certificationDetailMethod];
    //NSLog(@"cert url is : %@ ", certificationUrl);
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setCertificateModelLabel:nil];
    [self setCertificateIdLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) certificationDetailMethod{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:certificationUrl]];
    // __block NSArray *finalInnerData_ = nil;
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
        certificateIdLabel.text = [NSString stringWithFormat:@"Certificate ID : %@", 
                                   [[JSON objectForKey:@"certificate"] 
                                    objectForKey:@"cid"]];
        certificateModelLabel.text = [[[[[JSON objectForKey:@"certificate"] 
                                         objectForKey:@"product"] 
                                        objectForKey:@"alternate_identifiers"] objectAtIndex:0] 
                                      objectForKey:@"value"];
        
        [certificateData_ addObjectsFromArray:[[[JSON objectForKey:@"certificate"] 
                                                objectForKey:@"certification_set"] 
                                               objectForKey:@"certification"]];

        
        //Certification details header data code
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *individualDict in certificateData_) {
            if ([individualDict objectForKey:@"feature"]) {
                NSArray *tempArray = [individualDict objectForKey:@"feature"];
                [mutableArray addObjectsFromArray:tempArray];
            }
        }
        
        if ([mutableArray count] > 0)
            [certificateData_ addObjectsFromArray:mutableArray];
        
        [mutableArray release];
        
        
        for (NSDictionary *tempDict in certificateData_) {
        
            NSArray *allKeys = [mainDict_ allKeys];
            BOOL isExist = NO;
            
            NSString *category = [tempDict objectForKey:@"category"];
            
            for (int i = 0; i < [allKeys count]; i++) {
                if ([category isEqualToString:[allKeys objectAtIndex:i]]) {
                    isExist = YES;
                    break;
                }
            }
            
            if (isExist) {
                NSMutableArray *valuesArray = [[NSMutableArray alloc] initWithArray:[mainDict_ objectForKey:category]];
                [valuesArray addObject:[tempDict objectForKey:@"label"]];
                
                [mainDict_ setObject:valuesArray forKey:category];
                [valuesArray release];
            }
            else {
                NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
                [valuesArray addObject:[tempDict objectForKey:@"label"]];
                
                [mainDict_ setValue:valuesArray forKey:category];
                [valuesArray release];
            }
                
            
            
            
        }
        
      
        [certificationTable reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:requestOperation];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [mainDict_ count];
    
}// Default is 1 if not implemented

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *allKeys = [mainDict_ allKeys];
    
    return [[allKeys objectAtIndex:section] stringByDecodingHTMLEntities];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *allKeys = [mainDict_ allKeys];
    NSArray *returnArray = [mainDict_ objectForKey:[allKeys objectAtIndex:section]];
    
    return [returnArray count];
    
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *uniqueIdentifier = @"UITableViewCell";
    UITableViewCell *cell = nil;
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];

    if(!cell)
    {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifier] autorelease];
        
        [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:15]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
  
    NSArray *allKeys = [mainDict_ allKeys];
    NSArray *valueArray = [mainDict_ objectForKey:[allKeys objectAtIndex:indexPath.section]];
    cell.textLabel.text = [[valueArray objectAtIndex:indexPath.row] stringByDecodingHTMLEntities];
    
    return cell;
     
}


- (void) dealloc{
    
    [certificateData_ release];
    [mainDict_ release];
    [certificationTable release];
    [certificateModelLabel release];
    [certificateIdLabel release];
    [super dealloc];
}


@end
