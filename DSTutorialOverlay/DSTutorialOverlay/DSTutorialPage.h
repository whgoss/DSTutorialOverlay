//
// Created by Will Goss on 1/19/15.
// Copyright (c) 2015 Dynabyte Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DSImageSet;

@interface DSTutorialPage : NSObject

@property (nonatomic) BOOL tapAnywhereAllowed;
@property (nonatomic) BOOL showsInstructions;
@property (nonatomic) UIButton *closeButton;
@property (strong, nonatomic) DSImageSet *imageSet;

- (id)initWithImageSet:(DSImageSet*)imageSet;
- (UIImage*)getImage;

@end