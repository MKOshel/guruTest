//
//  ContainerView.h
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerView : UIView
@property (nonatomic,strong) UITableView* articlesTableView;
@property (nonatomic,strong) UINavigationBar* navBar;

-(id)initWithFrame:(CGRect)frame andNavigationBar:(UINavigationBar*)navBar;

@end
