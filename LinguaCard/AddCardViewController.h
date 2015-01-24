//
//  AddCardViewController.h
//  LinguaCard
//
//  Created by alexey on 25.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELesson.h"

@interface AddCardViewController : UIViewController
@property (strong) ELesson *lesson;
@property (weak, nonatomic) IBOutlet UITextField *cardName;
- (IBAction)addCard:(id)sender;

@end
