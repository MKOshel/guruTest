//
//  ContainerView.m
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import "ContainerView.h"
#define navBArheight 64
@implementation ContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame andNavigationBar:(UINavigationBar*)navBar
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _articlesTableView= [[UITableView alloc] initWithFrame:CGRectZero];
        _articlesTableView.translatesAutoresizingMaskIntoConstraints = NO;

        [self addSubview:_articlesTableView];
        
        NSLayoutConstraint *top    = [NSLayoutConstraint
                                      constraintWithItem:_articlesTableView
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                      attribute:NSLayoutAttributeTop
                                      multiplier:1.0f
                                      constant:64];
        
        NSLayoutConstraint *leading = [NSLayoutConstraint
                                            constraintWithItem:_articlesTableView
                                            attribute:NSLayoutAttributeLeading
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                            attribute:NSLayoutAttributeLeading
                                            multiplier:1.0f
                                            constant:0.f];
        
        NSLayoutConstraint *trailing = [NSLayoutConstraint
                                           constraintWithItem:_articlesTableView
                                           attribute:NSLayoutAttributeTrailing
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self
                                           attribute:NSLayoutAttributeTrailing
                                           multiplier:1.0f
                                           constant:0.f];
        
        NSLayoutConstraint *bottom = [NSLayoutConstraint
                                            constraintWithItem:_articlesTableView
                                            attribute:NSLayoutAttributeBottom
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                            attribute:NSLayoutAttributeBottom
                                            multiplier:1.0f
                                            constant:0.f];
        
        [self addConstraints:@[top,bottom,leading,trailing]];
    }
    
    return self;
}

@end
