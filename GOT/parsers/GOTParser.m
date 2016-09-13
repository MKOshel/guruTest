//
//  GOTParser.m
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import "GOTParser.h"
#import "TFHpple.h"
#import "ArticleItem.h"

@implementation GOTParser

+(ArticleItem*)parseArticleFromDict:(NSDictionary*)articleDict
{
    ArticleItem* am = [[ArticleItem alloc]init];

    @try {
        am.title = [articleDict objectForKey:@"title"];
        am.itemDescription = [articleDict objectForKey:@"abstract"];
        am.thumbnailURL = [articleDict objectForKey:@"thumbnail"];
    } @catch (NSException *exception) {
        NSLog(@"Exception on parsing data =====================%@",exception.debugDescription);
    } @finally {
    }
    
    return am;
}


#pragma mark HTML HELPER METHOD


+(NSString*)getTextWithXPATH:(NSString*)xpath inDocument:(NSData*)html
{

    NSString* text;
    @try {
        
        TFHpple *parser = [TFHpple hppleWithHTMLData:html];
        NSArray *nodes = [parser searchWithXPathQuery:xpath];
        
        TFHppleElement* element = nodes[0];
        text = element.content;
    } @catch (NSException *exception) {
        NSLog(@"Exception on parsing data =====================%@",exception.debugDescription);
    } @finally {
    }
    
    
    return text;
}

@end
