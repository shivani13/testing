//
//  WiFiSubInformationViewController.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/24/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WiFiSubInformationViewController : UIViewController{
    NSString *subInfoLabelText;
}


- (id)initWithSubInfoType:(NSString *)info;
@property (retain, nonatomic) IBOutlet UILabel *subInfoLabel;
@property (retain, nonatomic) IBOutlet UIWebView *subInfoWebView;
@end
