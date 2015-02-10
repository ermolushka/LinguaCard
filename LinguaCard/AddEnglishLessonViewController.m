//
//  AddEnglishLessonViewController.m
//  LinguaCard
//
//  Created by alexey on 25.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import "AddEnglishLessonViewController.h"
#import <CoreData/CoreData.h>
#import "ELesson.h"


@interface AddEnglishLessonViewController ()

@end

@implementation AddEnglishLessonViewController

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.lessonName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.lessonName.delegate = self;
    
    // Do any additional setup after loading the view.
    [self.lessonName becomeFirstResponder];
}


-(BOOL)textFieldShouldClear:(UITextField *)textField{

    self.lessonName.hidden = NO;
    self.lessonName.text = @"";
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)addLesson:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    ELesson *newNote = [NSEntityDescription insertNewObjectForEntityForName:@"ELesson" inManagedObjectContext:context];
   
    
    [newNote setValue:self.lessonName.text forKey:@"name"];

    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
