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
    // Do any additional setup after loading the view.
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

- (IBAction)addCard:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    Card *newCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    
    
    /*
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateStyle:@"EEEE"];
     NSString *weekday = [formatter stringFromDate:chosen];
     NSString *msg = [[NSString alloc] initWithFormat:@"This is %@", weekday]; */
    
    newCard.name = self.cardName.text;
    newCard.lesson = _lesson;
   // [newCard setValue:self.cardName.text forKey:@"name"];
    
    
    
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
