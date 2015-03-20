//
// Created by Will Goss on 1/19/15.
// Copyright (c) 2015 Dynabyte Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DSTutorialOverlayDelegate <NSObject>

- (void)tutorialOverlayClosed;
- (void)tutorialOverlayBackward:(NSInteger)currentPage;
- (void)tutorialOverlayForward:(NSInteger)currentPage;

@end

@interface DSTutorialOverlayControl : UIView <UIScrollViewDelegate>

@property (weak) id <DSTutorialOverlayDelegate> delegate;
@property (strong, nonatomic) UIScrollView *pageScrollView;
@property (strong, nonatomic) UIView *parentView;
@property (strong, nonatomic) UIView *tapView;
@property (strong, nonatomic) UIView *tutorialView;

- (id)initInView:(UIView*)view withSwipeToClose:(BOOL)allowSwipeToClose;
- (id)initInView:(UIView*)view withPages:(NSArray*)pages withSwipeToClose:(BOOL)allowSwipeToClose;
- (void)setPages:(NSArray*)pages;
- (void)showPageControl:(BOOL)show;

@end