# DSTutorialOverlay
Dynabyte Software's Tutorial Overlay library allows you to easily create an overlay in your application that instructs users.

To work with a DSTutorialOverlay, all you need to do is create it as a subview of whatever view controller you want it to exist on top of. You then assign it an array of DSPages, each one containing a DSImageSet. 

A DSImageSet specifies which images to use for a given page. You can provide a single image, or an image for each phone size—DSTutorialOverlay will specify the appropriate image for you.

On each DSPage, you can specify whether the user can tap anywhere to advance/close the tutorial among other options. There's even support for animated pages (it works, but needs improvements). 

If you want to respond to delegate functions, which send messages for moving forward and backward within the tutorial as well as closing it, make sure you designate your view controller a CFTutorialOverlayDelegate.

Sample Code:

    // create images
    UIImage *tutorial1 = [UIImage imageNamed:@"tutorial-1.jpg"];
    UIImage *tutorial2 = [UIImage imageNamed:@"tutorial-2.jpg"];
    UIImage *tutorial3 = [UIImage imageNamed:@"tutorial-3.jpg"];
    NSArray *animatedImageSets = [[NSArray alloc] initWithObjects:[[DSImageSet alloc] initWithImage:[UIImage imageNamed:@"tutorial-4-os.jpg"]], [[DSImageSet alloc] initWithImage:[UIImage imageNamed:@"tutorial-4-od.jpg"]], nil];
    
    // create image sets
    DSImageSet *page1ImageSet = [[DSImageSet alloc] initWithImage:tutorial1];
    DSImageSet *page2ImageSet = [[DSImageSet alloc] initWithImage:tutorial2];
    DSImageSet *page3ImageSet = [[DSImageSet alloc] initWithImage:tutorial3];
    
    // create static pages 1 - 3
    DSTutorialPage *page1 = [[DSTutorialPage alloc] initWithImageSet:page1ImageSet];
    page1.tapAnywhereAllowed = FALSE;
    
    CFTutorialPage *page2 = [[DSTutorialPage alloc] initWithImageSet:page2ImageSet];
    page2.tapAnywhereAllowed = FALSE;
    
    DSTutorialPage *page3 = [[DSTutorialPage alloc] initWithImageSet:page3ImageSet];
    page3.tapAnywhereAllowed = FALSE;
    
    // create animated page 4
    DSTutorialAnimatedPage *page4 = [[DSTutorialAnimatedPage alloc] initWithImageSets:animatedImageSets];
    page4.interval = 0.6f;
    page4.tapAnywhereAllowed = FALSE;
    
    // create close button (optional)
    CGFloat height = 41;
    page4.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - height, self.view.bounds.size.width, height)];
    [page4.closeButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [page4.closeButton setImage:[UIImage imageNamed:@"button-got-it.jpg"] forState:UIControlStateNormal];
    [page4.closeButton setImage:[UIImage imageNamed:@"button-got-it.jpg"] forState:UIControlStateHighlighted];
    page4.closeButton.titleLabel.text = @"";
    page4.closeButton.backgroundColor = [UIColor clearColor];
    
    // add pages to NSArray
    NSArray *pages = [[NSArray alloc] initWithObjects:page1, page2, page3, page4, nil];
    
    // instantiate tutorial overlay with array of pages
    self.tutorialOverlay = [[DSTutorialOverlayControl alloc] initInView:self.view withPages:pages withSwipeToClose:FALSE];
    self.tutorialOverlay.delegate = self;
    
    [self.view addSubview:self.tutorialOverlay];
    [self.view bringSubviewToFront:self.tutorialOverlay];
