//
//  WFAJSONData.m
//  WiFiAlliance
//
//  Created by Abhyuday Reddy on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WiFiJSONDataModel.h"
#import "AFJSONRequestOperation.h"
@implementation WiFiJSONDataModel
@synthesize certificationId = certificationId_;
@synthesize product = product_;
@synthesize model = model_;
@synthesize company = company_;
@synthesize category = category_;
@synthesize certificationUrl = certificationUrl_;
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void) dealloc{
    [certificationId_ release];
    [product_ release];
    [model_ release];
    [company_ release];
    [category_ release];
    [certificationUrl_ release];
    [super dealloc];
}

@end