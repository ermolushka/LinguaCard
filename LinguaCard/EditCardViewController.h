//
//  EditCardViewController.h
//  LinguaCard
//
//  Created by alexey on 10.02.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface EditCardViewController : UIViewController <UITextFieldDelegate>

@property (strong) NSManagedObject *name;
@property (strong) NSManagedObject *otherSide;

@property (weak, nonatomic) IBOutlet UITextField *editName;
@property (weak, nonatomic) IBOutlet UITextField *editOtherSide;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
