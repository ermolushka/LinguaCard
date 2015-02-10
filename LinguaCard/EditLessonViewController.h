//
//  EditLessonViewController.h
//  
//
//  Created by alexey on 10.02.15.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface EditLessonViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *editName;
@property (strong) NSManagedObject *lesson;


- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;


@end
