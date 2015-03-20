//
// Created by Will Goss on 1/19/15.
// Copyright (c) 2015 Dynabyte Software. All rights reserved.
//

#import "DSTutorialOverlayControl.h"
#import "DSTutorialPage.h"
#import "DSTutorialAnimatedPage.h"

@interface DSTutorialOverlayControl ()

@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL showPageControl;
@property (nonatomic) BOOL allowSwipeToClose;
@property (strong, nonatomic) UIView *blankView;
@property (strong, nonatomic) NSMutableArray *pageList;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation DSTutorialOverlayControl

- (id)initInView:(UIView*)view
{
    self = [super init];
    self.parentView = view;
    self.allowSwipeToClose = TRUE;
    [self create];
    return self;
}

- (id)initInView:(UIView*)view withSwipeToClose:(BOOL)allowSwipeToClose
{
    self = [super init];
    self.parentView = view;
    self.allowSwipeToClose = allowSwipeToClose;
    [self create];
    return self;
}

- (id)initInView:(UIView*)view withPages:(NSArray*)pages withSwipeToClose:(BOOL)allowSwipeToClose
{
    self = [self init];
    self.parentView = view;
    self.allowSwipeToClose = allowSwipeToClose;
    [self setPages:pages];
    [self create];
    return self;
}

- (void)create
{
    // cannot create if not inside of a parent view
    if (self.parentView == nil) return;
    
    // cannot create without pages
    if ((self.pageList == nil) || (self.pageList.count <= 0)) return;

    // create base tutorial view
    self.tutorialView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.parentView.bounds.size.width, self.parentView.bounds.size.height)];

    // create scroll view
    self.pageScrollView = [[UIScrollView alloc] initWithFrame:self.tutorialView.frame];
    self.pageScrollView.delegate = self;
    self.pageScrollView.pagingEnabled = TRUE;
    self.pageScrollView.bounces = FALSE;
    
    NSLog(@"Page count");

    // add page images to scroll view
    for (int i = 0; i <= self.pageList.count; i++)
    {
        // build frame
        CGRect frame;
        frame.origin.x = self.pageScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.pageScrollView.frame.size;
        
        NSLog(@"Page created");

        if (i < self.pageList.count)
        {
            DSTutorialPage *page = [self.pageList objectAtIndex:i];

            // create base page view
            UIView *pageView = [[UIView alloc] initWithFrame:frame];
            
            // create image view with page's image
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
            imageView.image = page.getImage;
            [pageView addSubview:imageView];
            
            // add "tap to continue" if page calls for it
            if (page.showsInstructions)
            {
                UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 32, frame.size.width, 32.0f)];
                tapView.backgroundColor = [UIColor clearColor];
                
                UIView *tapBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tapView.frame.size.width, tapView.frame.size.height)];
                tapBackgroundView.backgroundColor = [UIColor darkGrayColor];
                tapBackgroundView.alpha = 0.5f;
                UILabel *tapLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tapView.frame.size.width, tapView.frame.size.height)];
                tapLabel.text = @"Swipe or tap anywhere to continue";
                tapLabel.textColor = [UIColor whiteColor];
                tapLabel.font = [UIFont systemFontOfSize:14.0f];
                tapLabel.textAlignment = NSTextAlignmentCenter;
                [tapView addSubview:tapBackgroundView];
                [tapView addSubview:tapLabel];
                [tapView sendSubviewToBack:tapBackgroundView];
                [pageView addSubview:tapView];
                [pageView bringSubviewToFront:tapView];
            }
            
            // add tap gesture recognizer if allowed
            if (page.tapAnywhereAllowed)
            {
                // add tap gesture recognizer
                UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlayTapped)];
                tapGestureRecognizer.numberOfTapsRequired = 1;
                [pageView addGestureRecognizer:tapGestureRecognizer];
            }
            
            // add target for close button
            if (page.closeButton != nil)
            {
                [page.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
                [pageView addSubview:page.closeButton];
                [pageView bringSubviewToFront:page.closeButton];
            }

            // add image view to scroll view
            [self.pageScrollView addSubview:pageView];
        }
    }
    
    // scroll view content size
    if (self.allowSwipeToClose)
    {
        
        self.pageScrollView.contentSize = CGSizeMake(self.tutorialView.frame.size.width * ([self.pageList count] + 1), self.tutorialView.frame.size.height);
    }
    else
    {
        self.pageScrollView.contentSize = CGSizeMake(self.tutorialView.frame.size.width * ([self.pageList count]), self.tutorialView.frame.size.height);
    }
    
    [self.tutorialView addSubview:self.pageScrollView];
    
    // hide scroll view's scroll bar
    self.pageScrollView.showsHorizontalScrollIndicator = FALSE;
    self.pageScrollView.showsVerticalScrollIndicator = FALSE;

    // set content, image, and title.
    [self setPage:0 animated:FALSE];

    // add subviews to base tutorial view
    [self.tutorialView addSubview:self.pageScrollView];
    [self.tutorialView sendSubviewToBack:self.pageScrollView];
    
    // add tutorial overlay to parent view
    [self.parentView addSubview:self.tutorialView];
    [self.parentView bringSubviewToFront:self.tutorialView];
    
    // fade in the overlay
    self.tutorialView.alpha = 0.0f;
    [UIView animateWithDuration:0.5f animations:^(void)
     {
         self.tutorialView.alpha = 1.0f;
     }];
}

#pragma mark - Exit functions

- (void)close
{
    [UIView animateWithDuration:0.5f animations:^(void)
    {
        self.tutorialView.alpha = 0.0f;

    } completion:^(BOOL finished)
    {
        // remove from parent
        [self.parentView sendSubviewToBack:self];

        // inform delegate
        if ([self.delegate respondsToSelector:@selector(tutorialOverlayClosed)])
        {
            [self.delegate tutorialOverlayClosed];
        }
    }];
};

#pragma mark - Page functions

- (void)animationTimerElapsed:(NSTimer*)timer
{
    DSTutorialAnimatedPage *page = nil;
    DSTutorialPage *basePage = (DSTutorialPage*)[self.pageList objectAtIndex:self.index];
    if ([basePage isKindOfClass:[DSTutorialAnimatedPage class]])
    {
        page = (DSTutorialAnimatedPage*)basePage;
    }
    else
    {
        return;
    }
    
    [page advance];
    UIImage *image = page.getImage;
    UIView *pageView = nil;
    NSUInteger currentIndex = [self.pageList indexOfObject:page];
    
    // find the appropriate page view
    int i = 0;
    for (UIView *view in self.pageScrollView.subviews)
    {
        if (i == currentIndex)
        {
            pageView = view;
        }
        i++;
    }
    
    // if the page view is nil, something weird happened, so invalidate the timer and bail
    if (pageView == nil)
    {
        [timer invalidate];
        return;
    }
    
    // find the appropriate image view and replace its current image with the new one
    for (UIView *view1 in pageView.subviews)
    {
        if ([view1 isKindOfClass:[UIImageView class]])
        {
            UIImageView *imageView = (UIImageView*)view1;
            imageView.image = image;
        }
    }
}

- (void)setPages:(NSArray*)pages
{
    self.pageList = [[NSMutableArray alloc] initWithArray:pages];
    
    [self create];
}

- (void)setPage:(NSInteger)index animated:(BOOL)animated
{
    if ((index < 0) || (index > self.pageList.count)) return;

    // are we at the end?
    if (index == self.pageList.count)
    {
        [self close];
        return;
    }
    
    // is there a timer to invalidate?
    if ((index != self.index) && (self.timer != nil))
    {
        [self.timer invalidate];
        self.timer = nil;
    }

    // set index
    self.index = index;
    
    // is the page animated?
    DSTutorialPage *page = (DSTutorialPage*)[self.pageList objectAtIndex:index];
    if ([page isKindOfClass:[DSTutorialAnimatedPage class]])
    {
        DSTutorialAnimatedPage *animatedPage = (DSTutorialAnimatedPage*)page;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:animatedPage.interval target:self selector:@selector(animationTimerElapsed:) userInfo:animatedPage repeats:animatedPage.repeats];
    }

    // calculate the rect of the desired page
    CGRect pageRect = CGRectMake(self.pageScrollView.frame.size.width * index,
            0,
            self.pageScrollView.bounds.size.width,
            self.pageScrollView.bounds.size.height);

    // scroll to target position
    [self.pageScrollView scrollRectToVisible:pageRect animated:animated];
};

- (void)showPageControl:(BOOL)show
{
    self.showPageControl = show;
    
    
}

#pragma mark - Scroll view delegate functions

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender
{
    // compute which page we are on
    CGFloat pageWidth = self.pageScrollView.frame.size.width;
    NSInteger offsetLooping = 1;
    int index = floor((self.pageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + offsetLooping;
    
    // is there a timer to invalidate?
    if ((index != self.index) && (self.timer != nil))
    {
        [self.timer invalidate];
        self.timer = nil;
    }

    // are we at the end?
    if ((index == self.pageList.count) && (self.allowSwipeToClose))
    {
        [self close];
        return;
    }
    
    // is the page animated
    DSTutorialPage *page = (DSTutorialPage*)[self.pageList objectAtIndex:index];
    if ([page isKindOfClass:[DSTutorialAnimatedPage class]])
    {
        DSTutorialAnimatedPage *animatedPage = (DSTutorialAnimatedPage*)page;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:animatedPage.interval target:self selector:@selector(animationTimerElapsed:) userInfo:animatedPage repeats:animatedPage.repeats];
    }

    // inform the delegate of whether we moved forward or backward
    if (index < self.index)
    {
        if ([self.delegate respondsToSelector:@selector(tutorialOverlayBackward:)])
        {
            [self.delegate tutorialOverlayBackward:index];
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(tutorialOverlayForward:)])
        {
            [self.delegate tutorialOverlayForward:index];
        }
    }

    // set index
    self.index = index % [self.pageList count];
}

#pragma mark - Tap functions

- (void)overlayTapped
{
    DSTutorialPage *currentPage = [self.pageList objectAtIndex:self.index];
    if (currentPage.tapAnywhereAllowed) [self setPage:++self.index animated:TRUE];
}

@end