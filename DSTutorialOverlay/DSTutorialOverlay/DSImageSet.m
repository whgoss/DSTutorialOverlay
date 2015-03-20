//
//  DSImageSet.h
//  DSTutorialOverlay
//
// Created by Will Goss on 1/22/15.
// Copyright (c) 2015 Dynabyte Software. All rights reserved.
//

#import "DSImageSet.h"

@implementation DSImageSet

- (id)initWithImage:(UIImage*)image
{
    self = [super init];
    self.image4s = image;
    self.image5 = image;
    self.image6 = image;
    self.image6plus = image;
    return self;
}

- (id)initWithImage4s:(UIImage*)image4s andImage5:(UIImage*)image5 andImage6:(UIImage*)image6 andImage6Plus:(UIImage*)image6plus
{
    self = [super init];
    self.image4s = image4s;
    self.image5 = image5;
    self.image6 = image6;
    self.image6plus = image6plus;
    return self;
}

@end