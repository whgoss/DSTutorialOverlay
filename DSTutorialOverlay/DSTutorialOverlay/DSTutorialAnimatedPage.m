//
//  CFTutorialAnimatedPage.m
//  DSTutorialOverlay
//
//  Created by Will Goss on 2/5/15.
//  Copyright (c) 2015 Dynabyte Software. All rights reserved.
//

#import "DSImageSet.h"
#import "DSTutorialAnimatedPage.h"
#import <sys/sysctl.h>

@interface DSTutorialAnimatedPage ()

@property (strong, nonatomic) DSImageSet *currentImageSet;
@property (strong, nonatomic) NSArray *imageSets;

@end

@implementation DSTutorialAnimatedPage

- (id)initWithImageSets:(NSArray*)imageSets
{
    self = [super init];
    
    self.imageSets = imageSets;
    self.interval = 1.0f;
    self.repeats = TRUE;
    self.tapAnywhereAllowed = TRUE;
    self.currentImageSet = [self.imageSets firstObject];
    
    return self;
}

#pragma mark - Image functions

- (UIImage*)getImage
{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone4,1"]) return self.currentImageSet.image4s;
    if ([platform isEqualToString:@"iPhone5,1"]) return self.currentImageSet.image5;
    if ([platform isEqualToString:@"iPhone5,2"]) return self.currentImageSet.image5;
    if ([platform isEqualToString:@"iPhone5,3"]) return self.currentImageSet.image5;
    if ([platform isEqualToString:@"iPhone5,4"]) return self.currentImageSet.image5;
    if ([platform isEqualToString:@"iPhone6,1"]) return self.currentImageSet.image5;
    if ([platform isEqualToString:@"iPhone6,2"]) return self.currentImageSet.image5;
    if ([platform isEqualToString:@"iPhone7,1"]) return self.currentImageSet.image6plus;
    if ([platform isEqualToString:@"iPhone7,2"]) return self.currentImageSet.image6;
    else return self.currentImageSet.image6;
}

- (void)advance
{
    NSUInteger count = self.imageSets.count;
    NSUInteger currentIndex = [self.imageSets indexOfObject:self.currentImageSet];
    NSUInteger nextIndex = currentIndex + 1;
    if (nextIndex >= count)
    {
        nextIndex = 0;
    }
    
    self.currentImageSet = (DSImageSet*)[self.imageSets objectAtIndex:nextIndex];
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