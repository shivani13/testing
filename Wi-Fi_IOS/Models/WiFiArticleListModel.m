 //
//  ArticleListModel.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/16/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiArticleListModel.h"

@implementation WiFiArticleListModel

@synthesize delegate=delegate_;

@synthesize articleListUrl;
@synthesize isUrl;
@synthesize isTitle;
@synthesize isSummary;
@synthesize isEntry;
@synthesize isContent;
@synthesize articleTitles;
@synthesize articleLinks;
@synthesize articleSummaries;
@synthesize presentSummary;
@synthesize articleContent;
@synthesize presentContent;
@synthesize articleImageUrl;

- (id) initWithArticleListUrl:(NSString *)url{
    
    articleListUrl=url;
    return self;
}

- (void) startUrlConnection {
    
    response = [[NSMutableData alloc] init ];
    presentSummary=[[NSMutableString alloc] init];
    presentContent=[[NSMutableString alloc]init];
    articleTitles =[[NSMutableArray alloc]init ];
    articleLinks =[[NSMutableArray alloc]init ];
    articleSummaries =[[NSMutableArray alloc]init ];
    articleImageUrl =[[NSMutableArray alloc]init ];
    articleContent=[[NSMutableArray alloc]init];
    
    NSURL *url=[[NSURL alloc]initWithString:articleListUrl];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection){
        
    }
    else {
        
        NSLog(@"Connection Not Successfull");
    }
    
    [url release];
    [request release];
    [connection release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [response appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [self startParsing];
       
    if (self.delegate != nil) {
        
        [self.delegate reloadTableView];
    }
}

- (void)startParsing {
    
    NSXMLParser *parser=[[NSXMLParser alloc]initWithData:response];
    parser.delegate = self;
    [parser parse];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
                                        namespaceURI:(NSString *)namespaceURI 
                                        qualifiedName:(NSString *)qName 
                                            attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"title"]) {
        
        isTitle=YES;
        isUrl=YES;
    }
    if (isUrl) {
        
        if ([elementName isEqualToString:@"link"]) {
            
            [articleLinks addObject:[attributeDict objectForKey:@"href"]];
            isUrl=NO;
        }
    }
    
    if ([elementName isEqualToString:@"summary"]) {
        
        isSummary=YES;
    }
    
    if ([elementName isEqualToString:@"content"]) {
        
        isContent=YES;
    }
    
    if ([elementName isEqualToString:@"media:thumbnail"]) {
        
        [articleImageUrl addObject:[attributeDict objectForKey:@"url"]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
                                      namespaceURI:(NSString *)namespaceURI 
                                     qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"summary"]) {
        
        [articleSummaries addObject: [NSString stringWithFormat:presentSummary]];
        [presentSummary setString:@""];
        isSummary=NO;
    }
    
    if ([elementName isEqualToString:@"content"]) {
        [articleContent addObject: [NSString stringWithFormat:presentContent]];        
        [presentContent setString:@""];
        isContent=NO;
    }
    
}

-  (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (isTitle) {
        
        [articleTitles addObject:string];
        isTitle=NO;
    }
    
    if (isSummary) {
        
        [presentSummary appendString:string];
        
    }
    
    if (isContent) {
        [presentContent appendString:string];
        
    }
}

- (void) dealloc {
    
    [response release];
    [presentSummary release];
    [presentContent release]; 
    [articleTitles release];
    [articleLinks release];
    [articleSummaries release];
    [articleImageUrl release];
    [articleContent release];
    [super dealloc];
}

@end
