//
//  GOTArticlesVC.m
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import "GOTArticlesVC.h"
#import "ContainerView.h"
#import "ArticleCell.h"
#import "GOTArticleDetailVC.h"
#import "GOTRequestManager.h"
#import "GOTParser.h"
#import "ArticleItem.h"
#import <PQFCustomLoaders/PQFCustomLoaders.h>


#define articlesCount @"75"

@interface GOTArticlesVC () <UITableViewDelegate,UITableViewDataSource>
{
    ContainerView* containerView;
    UIRefreshControl* refreshControl;
    GOTRequestManager* requestManager;
    NSMutableArray* articlesArray;
    NSMutableArray* favoritesArticles;
    PQFCirclesInTriangle* activityIndicator;
    int index;
    int height;
    BOOL isSelected;
    NSString* fullArticle;
    CGFloat cellHeight;
    
    GOTArticleDetailVC* detailsVC;
}

@end

@implementation GOTArticlesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


-(void)initArrays
{
    articlesArray = [NSMutableArray new];
    favoritesArticles = [NSMutableArray new];
}


-(void)loadView
{
    self.automaticallyAdjustsScrollViewInsets=NO;

    self.view = containerView = [[ContainerView alloc]initWithFrame:CGRectZero andNavigationBar:self.navigationController.navigationBar];
    UITableView* tableView = containerView.articlesTableView;
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.7;
    tableView.delegate = self;
    [tableView addGestureRecognizer:lpgr];
   
    [tableView registerClass:[ArticleCell class] forCellReuseIdentifier:@"cell"];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [containerView.articlesTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshArticles:) forControlEvents:UIControlEventValueChanged];
    
    [self initArrays];

    activityIndicator = [PQFCirclesInTriangle createModalLoader];
    
    [self setupLoader];
    [activityIndicator showLoader];
    requestManager = [GOTRequestManager sharedInstance];
    requestManager.delegate = self;
    [requestManager getArticlesWithCount:articlesCount];
    
    index = -1;
    height = 74;
    isSelected = NO;
    
    detailsVC = [[GOTArticleDetailVC alloc]init];

}


-(void)setupLoader
{
    activityIndicator.cornerRadius = 2.0;
    activityIndicator.loaderColor = [UIColor blackColor];
    activityIndicator.loaderAlpha = 1.0;
}

#pragma mark Get Data

-(void)didReceiveGOTArticles:(NSArray *)articles
{
    for (NSDictionary* articleDict in articles) {
        ArticleItem *ai = [GOTParser parseArticleFromDict:articleDict];
        [articlesArray addObject:ai];
    }
    
    containerView.articlesTableView.delegate = self;
    containerView.articlesTableView.dataSource = self ;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self endRefreshing];

    });

}

-(void)didReceiveErrorOnDownloadingArticles:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [activityIndicator removeLoader];
    });
}

#pragma mark Refresh Action


-(void)refreshArticles:(UIRefreshControl*)sender
{
    [articlesArray removeAllObjects];
    [requestManager getArticlesWithCount:articlesCount];
}


-(void)endRefreshing
{
    [containerView.articlesTableView reloadData];
    [refreshControl endRefreshing];
    [activityIndicator removeLoader];
}


#pragma mark table view methods


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return articlesArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleCell* articleCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if (articleCell == nil) {
        articleCell = [[ArticleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        articleCell.btnDetails.tag = indexPath.row;
        [articleCell.btnDetails addTarget:self action:@selector(addToFavorites:) forControlEvents:UIControlEventTouchUpInside];
        //articleCell.btnDetails.hidden = YES;
        [articleCell bringSubviewToFront:articleCell.btnDetails];
        articleCell.contentView.userInteractionEnabled = false; // <<-- the solution

    }
    ArticleItem* articleItem;
    if (articlesArray.count > 0) {
        articleCell.customImageView.image = nil;
        articleItem = articlesArray[indexPath.row];
        if (articleItem.fullArticle) {
            articleCell.customLabel.text = articleItem.fullArticle;
        }
        else{
            articleCell.customLabel.text = articleItem.itemDescription;

        }
        articleCell.titleLabel.text = articleItem.title;
        [requestManager getThumbnailForItem:articleItem response:^(id result, NSError *error) {
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    articleCell.customImageView.image = result;
                    [activityIndicator removeLoader];

                });
            }
        }];
    }

    return articleCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (index == indexPath.row && isSelected) {
        if (fullArticle != nil) {
          
            return [self getCellSizeFromText:fullArticle];
            //this is a bad solution but I didn't had the time to implement with pure autolayout
        }
    }
    if (index == -1 && !isSelected) {
        return height;
    }
    return height;
}


-(CGFloat)getCellSizeFromText:(NSString*)text
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12.0f]};

    CGRect rect = [text boundingRectWithSize:CGSizeMake(250, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    
    return rect.size.height + 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ArticleCell* articleCell = [tableView cellForRowAtIndexPath:indexPath];
    ;
    ArticleItem* item = articlesArray[indexPath.row];
    detailsVC = [[GOTArticleDetailVC alloc]init];

    [requestManager getFullArticleForItem:item response:^(id result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{

            item.fullArticle = result;
            [activityIndicator removeLoader];
           
            [detailsVC setAvatarImage:articleCell.customImageView.image];
            [detailsVC setArticleItem:item];
            [self.navigationController pushViewController:detailsVC animated:YES];

        });
    }];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}



- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint p = [gestureRecognizer locationInView:containerView.articlesTableView];
        
        NSIndexPath *indexPath = [containerView.articlesTableView indexPathForRowAtPoint:p];
        if (indexPath == nil) {
            NSLog(@"long press on table view but not on a row");
        } else {
            UITableViewCell *cell = [containerView.articlesTableView cellForRowAtIndexPath:indexPath];
            if (cell.isHighlighted) {
                UITableView* tableView = containerView.articlesTableView;
                ArticleCell* articleCell = [tableView cellForRowAtIndexPath:indexPath];
                ;
                ArticleItem* item = articlesArray[indexPath.row];
                detailsVC = [[GOTArticleDetailVC alloc]init];
                

                if (index == indexPath.row) {
                    index = -1;
                    isSelected = NO;
                    [tableView beginUpdates];
                    [tableView endUpdates];
                    return;
                }
                
                if ([item.fullArticle length] != 0) {
                    articleCell.customLabel.text = item.fullArticle;
                    index = (int)indexPath.row;
                    [ tableView beginUpdates];
                    [tableView endUpdates];
                    if (item.isFav) {
                        [articleCell.btnDetails setImage:[UIImage imageNamed:@"Hearts Filled-50"] forState:UIControlStateNormal];
                    }
                    else {
                        [articleCell.btnDetails setImage:[UIImage imageNamed:@"Hearts-50"] forState:UIControlStateNormal];
                    }
                }
                
                
                [requestManager getFullArticleForItem:item response:^(id result, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        articleCell.customLabel.text = result;
                        articleCell.btnDetails.hidden = NO;
                        fullArticle = result;
                        item.fullArticle = result;
                        [activityIndicator removeLoader];
                        isSelected = YES;
                        index = (int)indexPath.row;
                        
                        if (item.isFav) {
                            [articleCell.btnDetails setImage:[UIImage imageNamed:@"Hearts-Filled-50"] forState:UIControlStateNormal];
                        }
                        else {
                            [articleCell.btnDetails setImage:[UIImage imageNamed:@"Hearts-50"] forState:UIControlStateNormal];
                        }
                        
                        [tableView beginUpdates];
                        [tableView endUpdates];
                        
                        
                    });
                }];
                NSLog(@"long press on table view at section 1 row %ld", indexPath.row);
            }
        }
    }
}


-(void)addToFavorites:(UIButton*)sender
{
    UITableView* tableView = containerView.articlesTableView;
    ArticleCell* articleCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:sender.tag]];
    ;
    ArticleItem* item = articlesArray[sender.tag];
    
    [articleCell.btnDetails setImage:[UIImage imageNamed:@"Hearts-Filled-50"] forState:UIControlStateNormal];
    item.isFav = YES;
    
    [favoritesArticles addObject:item];
    
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Popular GOT articles";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
