//
// DSImageSet.h
// DSTutorialOverlay
//
// Created by Will Goss on 1/22/15.
// Copyright (c) 2015 Dynabyte Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSImageSet : NSObject

@property (strong, nonatomic) UIImage *image4s;
@property (strong, nonatomic) UIImage *image5;
@property (strong, nonatomic) UIImage *image6;
@property (strong, nonatomic) UIImage *image6plus;

- (id)initWithImage:(UIImage*)image;
- (id)initWithImage4s:(UIImage*)image4s andImage5:(UIImage*)image5 andImage6:(UIImage*)image6 andImage6Plus:(UIImage*)image6plus;

@end