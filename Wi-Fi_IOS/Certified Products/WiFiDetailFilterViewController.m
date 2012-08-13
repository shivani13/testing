//
//  MMDetailFilter.m
//  Wi-Fi_IOS
//
//  Created by Abhyuday Reddy on 30/05/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiDetailFilterViewController.h"
#import "AFJSONRequestOperation.h"
#import "WiFiFilterDataModel.h"
#import "WiFiProductViewController.h"

@interface WiFiDetailFilterViewController ()

@end

@implementation WiFiDetailFilterViewController
@synthesize detailFilterTableView;
@synthesize detailFilterUrl;
@synthesize titleValue;
@synthesize select;
@synthesize unselect;
@synthesize valueID;
@synthesize delegate = delegate_;

bool isUnselect = FALSE;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action: @selector(doneFilter)] autorelease];
        self.navigationItem.rightBarButtonItem  = doneButton;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    detailFilterArray_ = [[NSMutableArray alloc] init];
    idFilterArray_ = [[NSMutableArray alloc] init ];
    statusArray_ = [[NSMutableArray alloc] init ];
    tempUrl_ = [[NSString alloc]init ];
    
    [self setUrlData];
    
    if([titleValue isEqualToString:@"org"])
        self.title = @"Company List";
    else if([titleValue isEqualToString:@"cert"])
        self.title = @"Certificate List";
    else    
        self.title = @"FILTER";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *) retrieveData {
    valueID = @"=";
    int i=0;
    
    NSArray *selectedFilterData = [WiFiFilterDataModel MR_findAll];
    
    for( WiFiFilterDataModel *temp in selectedFilterData) {
        
        i++;
        valueID = [valueID stringByAppendingString:temp.idValue];
        if(i != [selectedFilterData count])
            valueID = [valueID stringByAppendingString:@","];
    }
    
    return valueID;
}

-(void) setUrlData {
    
    NSString *temp = [self retrieveData];
   
    if([titleValue isEqualToString:@"org"]) {
    
        tempUrl_ = @"http://mobile.wi-fi.org/v1/products/filter/org";
        
        if(![valueID isEqualToString:nil])
        tempUrl_ = [tempUrl_ stringByAppendingString:temp];
        tempUrl_ = [tempUrl_ stringByAppendingString:@"/modify/org"];
       
        [self setDetailFilterUrl:tempUrl_];
    }
    else if([titleValue isEqualToString:@"cert"]) {
        
        tempUrl_ = @"http://mobile.wi-fi.org/v1/products/filter/cert";
        
        if(![valueID isEqualToString:nil])
        tempUrl_ = [tempUrl_ stringByAppendingString:temp];
        tempUrl_ = [tempUrl_ stringByAppendingString:@"/modify/cert"];
        
        [self setDetailFilterUrl:tempUrl_];
    }
    
    [self setDetailFilterData];
}

- (void) setDetailFilterData {
    
    NSString *url = [NSString stringWithFormat:detailFilterUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // __block NSArray *finalInnerData_ = nil;
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
        NSMutableArray *jsonArray = [[JSON objectForKey:@"criteria"] objectForKey:@"value"];
        
        for (NSDictionary *object in jsonArray) {
            [detailFilterArray_ addObject:[object objectForKey:@"label"]];
            [idFilterArray_ addObject:[object objectForKey:@"value"]];
            [statusArray_ addObject:[object objectForKey:@"checked"]];
        }
       
        [detailFilterTableView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:requestOperation];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [detailFilterArray_ count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *uniqueIdentifier = @"UITableViewCell";
    UITableViewCell *cell = nil;
    
    
    cell = [detailFilterTableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    
    if(!cell)
    {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifier] autorelease];
        [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:15]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if ([[statusArray_ objectAtIndex:indexPath.row] isEqualToString:@"true"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if([[statusArray_ objectAtIndex:indexPath.row] isEqualToString:@"false"]){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = [detailFilterArray_ objectAtIndex:indexPath.row];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    valueID =@"";
    if(cell.accessoryType == UITableViewCellAccessoryNone){
        
        isUnselect = FALSE;
        
        [statusArray_ replaceObjectAtIndex:indexPath.row withObject:@"true"];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
        
        WiFiFilterDataModel *dataFilter = [WiFiFilterDataModel MR_createInContext:localContext];
        // Create a new Person in the current thread context
        
        dataFilter.idValue = [idFilterArray_ objectAtIndex:indexPath.row];
        valueID = dataFilter.idValue;
       
        // Save the modification in the local context   
        [localContext MR_save];
        [self setUrlData];
        

    }
    else{
        
        cell.accessoryType = UITableViewCellEditingStyleNone;
        [statusArray_ replaceObjectAtIndex:indexPath.row withObject:@"false"];
        // Get the local context

    }

    
}


- (IBAction)selectMethod:(id)sender{
    
    for (int i=0; i<[detailFilterArray_ count]; i++) {
        [statusArray_ replaceObjectAtIndex:i withObject:@"true"];
                UITableViewCell *cell = [detailFilterTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:i inSection:0]];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
}

- (IBAction)unselectMethod:(id)sender{
   
    for (int i=0; i<[detailFilterArray_ count]; i++) {
        
        isUnselect = TRUE;
        [statusArray_ replaceObjectAtIndex:i withObject:@"false"];
        UITableViewCell *cell = [detailFilterTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:i inSection:0]];
        
        if(cell.accessoryType = UITableViewCellAccessoryCheckmark){
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        }
    }

}

-(void) doneFilter{
    
    NSString *arrayData = [self retrieveData];
    NSLog(@"%@", arrayData);
    
    if(isUnselect == FALSE){
    [delegate_ updateURLInFilterView:valueID];
    [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" 
                                                        message:@"No rows selected!" 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
}




@end
