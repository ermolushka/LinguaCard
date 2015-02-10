//
//  EditCardViewController.m
//  LinguaCard
//
//  Created by alexey on 10.02.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import "EditCardViewController.h"
#import "Card.h"

@interface EditCardViewController ()

@end

@implementation EditCardViewController

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
    if (self.name) {
        [self.editName setText:[self.name valueForKey:@"name"]];
        
    }
    if (self.otherSide) {
        [self.editOtherSide setText:[self.otherSide valueForKey:@"otherSide"]];
        
    }
    
    self.editName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.editName.delegate = self;
    
    self.editOtherSide.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // Do any additional setup after loading the view.
    [self.editName becomeFirstResponder];
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.editName.hidden = NO;
    self.editName.text = @"";
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return !([newString length] > 5);
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField == self.editName){
        [self.editOtherSide becomeFirstResponder];
    }
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
    
    if (self.name && self.otherSide) {
        // Update existing device
        [self.name setValue:self.editName.text forKey:@"name"];
        [self.otherSide setValue:self.editOtherSide.text forKey:@"otherSide"];
        
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
