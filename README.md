# DSTutorialOverlay
Dynabyte Software's Tutorial Overlay library allows you to easily create an overlay in your application that instructs users. It can exist as a child of any view. 

    // create images
    UIImage *tutorial1 = [UIImage imageNamed:@"tutorial-1.jpg"];
    UIImage *tutorial2 = [UIImage imageNamed:@"tutorial-2.jpg"];
    UIImage *tutorial3 = [UIImage imageNamed:@"tutorial-3.jpg"];
    
    // create image sets
    CFImageSet *page1ImageSet = [[CFImageSet alloc] initWithImage:tutorial1];
    CFImageSet *page2ImageSet = [[CFImageSet alloc] initWithImage:tutorial2];
    CFImageSet *page3ImageSet = [[CFImageSet alloc] initWithImage:tutorial3];
    
    // create static pages 1 - 3
    CFTutorialPage *page1 = [[CFTutorialPage alloc] initWithImageSet:page1ImageSet];
    page1.tapAnywhereAllowed = FALSE;
    
    CFTutorialPage *page2 = [[CFTutorialPage alloc] initWithImageSet:page2ImageSet];
    page2.tapAnywhereAllowed = FALSE;
    
    CFTutorialPage *page3 = [[CFTutorialPage alloc] initWithImageSet:page3ImageSet];
    page3.tapAnywhereAllowed = FALSE;
    
    // create animated page 4
    NSArray *imageSets = [[NSArray alloc] initWithObjects:[[CFImageSet alloc] initWithImage:[UIImage imageNamed:@"tutorial-4-os.jpg"]], [[CFImageSet alloc] initWithImage:[UIImage imageNamed:@"tutorial-4-od.jpg"]], nil];
    CFTutorialAnimatedPage *page4 = [[CFTutorialAnimatedPage alloc] initWithImageSets:imageSets];
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
    self.tutorialOverlay = [[CFTutorialOverlayControl alloc] initInView:self.view withPages:pages withSwipeToClose:FALSE];
    self.tutorialOverlay.delegate = self;
    
    [self.view addSubview:self.tutorialOverlay];
    [self.view bringSubviewToFront:self.tutorialOverlay];
