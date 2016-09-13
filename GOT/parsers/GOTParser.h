//
//  GOTParser.h
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleItem.h"

@interface GOTParser : NSObject

+(ArticleItem*)parseArticleFromDict:(NSDictionary*)articleDict;
+(NSString*)getTextWithXPATH:(NSString*)xpath inDocument:(NSData*)html;

@end
