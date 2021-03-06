//
//  CardsTableViewController.h
//  LinguaCard
//
//  Created by alexey on 25.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELesson.h"
#import "SWTableViewCell.h"

@interface CardsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ELesson *lesson;
@property (nonatomic, strong) NSString *lessonName;
@property (nonatomic, strong) NSMutableArray *searchResults;

@end
