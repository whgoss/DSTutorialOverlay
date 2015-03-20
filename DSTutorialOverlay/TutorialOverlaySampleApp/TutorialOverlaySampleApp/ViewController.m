//
//  ViewController.m
//  TutorialOverlaySampleApp
//
//  Created by Will Goss on 3/20/15.
//  Copyright (c) 2015 Dynabyte Software, LLC. All rights reserved.
//

#import "DSTutorialOverlayControl.h"
#import "DSTutorialPage.h"
#import "DSImageSet.h"
#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *pages;
@property (strong, nonatomic) DSTutorialOverlayControl *tutorialOverlay;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // create image sets
    DSImageSet *page1ImageSet = [[DSImageSet alloc] initWithImage:[UIImage imageNamed:@"Tutorial1.png"]];
    DSImageSet *page2ImageSet = [[DSImageSet alloc] initWithImage:[UIImage imageNamed:@"Tutorial2.png"]];
    DSImageSet *page3ImageSet = [[DSImageSet alloc] initWithImage:[UIImage imageNamed:@"Tutorial3.png"]];
    DSImageSet *page4ImageSet = [[DSImageSet alloc] initWithImage:[UIImage imageNamed:@"Tutorial4.png"]];
    
    // create pages
    DSTutorialPage *page1 = [[DSTutorialPage alloc] initWithImageSet:page1ImageSet];
    DSTutorialPage *page2 = [[DSTutorialPage alloc] initWithImageSet:page2ImageSet];
    DSTutorialPage *page3 = [[DSTutorialPage alloc] initWithImageSet:page3ImageSet];
    DSTutorialPage *page4 = [[DSTutorialPage alloc] initWithImageSet:page4ImageSet];
    page1.showsInstructions = TRUE;
    page1.tapAnywhereAllowed = TRUE;
    self.pages = [[NSArray alloc] initWithObjects:page1, page2, page3, page4, nil];
    
    // create overlay
    self.tutorialOverlay = [[DSTutorialOverlayControl alloc] initInView:self.view withSwipeToClose:TRUE];
    [self.tutorialOverlay setPages:self.pages];
    [self.tutorialOverlay showPageControl:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end