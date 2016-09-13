//
//  GOTArticleDetailVC.m
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import "GOTArticleDetailVC.h"
#import "DetailContainerView.h"
@interface GOTArticleDetailVC ()
{
    DetailContainerView* contentView;
}
@end

@implementation GOTArticleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)loadView
{
    self.automaticallyAdjustsScrollViewInsets=NO;

    contentView = [[DetailContainerView alloc]initWithFrame:CGRectZero];
    _imageView = contentView.avatarImageView;
    [_imageView setImage:_avatarImage];
   
    contentView.articleLabel.text = _articleItem.fullArticle;
    self.view = contentView;
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
