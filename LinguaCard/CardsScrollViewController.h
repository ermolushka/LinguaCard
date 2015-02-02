//
//  CardsScrollViewController.h
//  LinguaCard
//
//  Created by alexey on 29.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "ELesson.h"

@interface CardsScrollViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) ELesson *lesson;
@property (weak, nonatomic) IBOutlet UILabel *otherSide;

@end
