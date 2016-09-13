//
//  GOTTests.m
//  GOTTests
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GOTRequestManager.h"

@interface GOTTests : XCTestCase
{
    ArticleItem* item;
}
@end

@implementation GOTTests

- (void)setUp {
    [super setUp];
    item = [[ArticleItem alloc]init];
    item.title = @"Jon Snow";
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
   
    
    [[GOTRequestManager sharedInstance]getFullArticleForItem:item response:^(id result, NSError *error) {
        XCTAssert(result);
    }];

    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
