//
//  WFAJSONData.h
//  WiFiAlliance
//
//  Created by Abhyuday Reddy on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WiFiJSONDataModel : NSObject{
    
    NSString *certificationId_;
    NSString *company_;
    NSString *product_;
    NSString *model_;
    NSString *category_;
    NSString *certificationUrl_;
}

@property (nonatomic, retain) NSString *certificationId;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *product;
@property (nonatomic, retain) NSString *model;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *certificationUrl;


@end
