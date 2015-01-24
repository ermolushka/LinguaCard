//
//  Card.h
//  LinguaCard
//
//  Created by alexey on 25.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *lesson;

@end
