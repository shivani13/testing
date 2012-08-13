//
//  WiFiInformationViewController.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/24/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MFMailComposeViewController.h"

@interface WiFiInformationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>{
    
    NSArray *tableFields;
    
}

@property (retain, nonatomic) IBOutlet UITableView *informationTableView;

- (void)sendFeedback;
@end
