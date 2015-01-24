//
//  AddEnglishLessonViewController.h
//  LinguaCard
//
//  Created by alexey on 25.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEnglishLessonViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *lessonName;
- (IBAction)addLesson:(id)sender;

@end
