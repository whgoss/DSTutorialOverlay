//
// Created by Will Goss on 1/19/15.
// Copyright (c) 2015 Dynabyte Software. All rights reserved.
//

#import "DSTutorialPage.h"
#import "DSImageSet.h"
#include <sys/sysctl.h>

@implementation DSTutorialPage

- (id)initWithImageSet:(DSImageSet*)imageSet
{
    self = [super init];

    self.imageSet = imageSet;
    self.tapAnywhereAllowed = TRUE;

    return self;
}

#pragma mark - Image functions

- (UIImage*)getImage
{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone4,1"]) return self.imageSet.image4s;
    if ([platform isEqualToString:@"iPhone5,1"]) return self.imageSet.image5;
    if ([platform isEqualToString:@"iPhone5,2"]) return self.imageSet.image5;
    if ([platform isEqualToString:@"iPhone5,3"]) return self.imageSet.image5;
    if ([platform isEqualToString:@"iPhone5,4"]) return self.imageSet.image5;
    if ([platform isEqualToString:@"iPhone6,1"]) return self.imageSet.image5;
    if ([platform isEqualToString:@"iPhone6,2"]) return self.imageSet.image5;
    if ([platform isEqualToString:@"iPhone7,1"]) return self.imageSet.image6plus;
    if ([platform isEqualToString:@"iPhone7,2"]) return self.imageSet.image6;
    else return self.imageSet.image6;
}

#pragma mark - Platform string

- (NSString*)platform
{
    size_t size = 100;
    char *hw_machine = malloc(size);
    int name[] = {CTL_HW,HW_MACHINE};
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

@end