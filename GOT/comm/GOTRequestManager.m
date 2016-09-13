//
//  GOTRequestManager.m
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import "GOTRequestManager.h"
#import "ArticleItem.h"
#import "GOTParser.h"
#import <UIKit/UIKit.h>

#define kBaseURL      @"http://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1"
#define kCategory     @"Characters"
#define kArticleXPath @"//*[@id=\"mw-content-text\"]/p[1]"

@implementation GOTRequestManager


+(GOTRequestManager*)sharedInstance
{
    static GOTRequestManager* rm = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rm = [[GOTRequestManager alloc]init];
    });
    
    return rm;
}


-(void)getArticlesWithCount:(NSString*)count
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[self getQueryURLWithCategory:kCategory itemsCount:count]]];
    [request setHTTPMethod:@"GET"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            if ([self.delegate respondsToSelector:@selector(didReceiveErrorOnDownloadingArticles:)]) {
                [_delegate didReceiveErrorOnDownloadingArticles:error];
            }
        }
        else {
            NSParameterAssert(data);
            NSError* e;
            NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            NSLog(@"=============//////////===========%@////////////=============",jsonDict);
            if ([self.delegate respondsToSelector:@selector(didReceiveGOTArticles:)]) {
                NSArray* itemsResult = [jsonDict objectForKey:@"items"];
                _basepathURL = [jsonDict objectForKey:@"basepath"];
               
                [_delegate didReceiveGOTArticles:itemsResult];
            }
        }

    }] resume];
}


-(void)getFullArticleForItem:(ArticleItem*)item response:(void(^)(id result, NSError* error))responseBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString* absoluteArticleURL = [item getFullArticleURL:item baseURL:_basepathURL];
    [request setURL:[NSURL URLWithString:absoluteArticleURL]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            [_delegate didReceiveErrorOnDownloadingArticles:error];
        }
        else {
            NSParameterAssert(data);

            NSString* fullArticle = [GOTParser getTextWithXPATH:kArticleXPath inDocument:data];
            
            NSLog(@"###### FULL ARTICLE : %@ ###### ",fullArticle);
            responseBlock(fullArticle,nil);
        }
        
    }] resume];
}


-(void)getThumbnailForItem:(ArticleItem*)item response:(void(^)(id result, NSError* error))responseBlock
{
    NSURL *url = [NSURL URLWithString:item.thumbnailURL];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage* image = [UIImage imageWithData:data];
            responseBlock(image,nil);
        }
                               
    }];
    [task resume];
}


-(NSString*)getQueryURLWithCategory:(NSString*)category itemsCount:(NSString*)count
{
    NSString* queryURL;
    
    queryURL = [NSString stringWithFormat:@"%@&Cateogry=%@&limit=%@",kBaseURL,category,count];
    
    return queryURL;
    
}



@end
