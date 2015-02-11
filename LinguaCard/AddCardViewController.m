//
//  AddCardViewController.m
//  LinguaCard
//
//  Created by alexey on 25.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import "AddCardViewController.h"
#import "Card.h"


@interface AddCardViewController ()

@end

@implementation AddCardViewController

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
    
    self.cardName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.otherSide.clearButtonMode = UITextFieldViewModeWhileEditing;
    _cardName.delegate = self;
    _otherSide.delegate = self;
    
    [self.cardName becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return !([newString length] > 5);
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField == _cardName){
        [_otherSide becomeFirstResponder];
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addCard:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    Card *newCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    
    
    newCard.name = self.cardName.text;
    newCard.otherSide = self.otherSide.text;
    newCard.lesson = _lesson;
   
    
    
    
    
    
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
