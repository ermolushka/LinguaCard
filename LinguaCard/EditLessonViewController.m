//
//  EditLessonViewController.m
//  
//
//  Created by alexey on 10.02.15.
//
//

#import "EditLessonViewController.h"
#import <CoreData/CoreData.h>
#import "ELesson.h"

@interface EditLessonViewController ()

@end

@implementation EditLessonViewController

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
    if (self.lesson) {
        [self.editName setText:[self.lesson valueForKey:@"name"]];
    }
    
    self.editName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.editName.delegate = self;
    
    // Do any additional setup after loading the view.
    [self.editName becomeFirstResponder];
}




-(BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.editName.hidden = NO;
    self.editName.text = @"";
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

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.lesson) {
        // Update existing device
        [self.lesson setValue:self.editName.text forKey:@"name"];
      
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
   
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
