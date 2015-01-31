//
//  Card.h
//  LinguaCard
//
//  Created by alexey on 31.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ELesson;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * otherSide;
@property (nonatomic, retain) ELesson *lesson;

@end
