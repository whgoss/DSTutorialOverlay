//
//  DSTutorialAnimatedPage.h
//  DSTutorialOverlay
//
//  Created by Will Goss on 2/5/15.
//  Copyright (c) 2015 Dynabyte Software. All rights reserved.
//

#import "DSTutorialPage.h"
#import <UIKit/UIKit.h>

@interface DSTutorialAnimatedPage : DSTutorialPage

@property (nonatomic) CGFloat interval;
@property (nonatomic) BOOL repeats;

- (void)advance;
- (id)initWithImageSets:(NSArray*)imageSets;
- (UIImage*)getImage;

@end
