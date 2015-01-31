//
//  CardsScrollViewController.m
//  LinguaCard
//
//  Created by alexey on 29.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import "CardsScrollViewController.h"
#import "AddCardViewController.h"
#import <CoreData/CoreData.h>
#import "Card.h"

@interface CardsScrollViewController ()
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSMutableArray *cards;

@end


@implementation CardsScrollViewController
@synthesize carousel;
@synthesize items;


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}



- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    
    /*
     self.items = [NSMutableArray array];
     for (int i = 0; i < 1000; i++)
     {
     [items addObject:@(i)];
     }
    
    */
    
    //items = [self.cards valueForKey:@"name"];
   
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    carousel.delegate = nil;
    carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
    
 
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Card"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"lesson == %@", self.lesson];
    [fetchRequest setPredicate:predicate];
    self.cards = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    self.items = [NSMutableArray array];
    
    for (NSString *name in [self.cards valueForKey:@"name"]) {
        [items addObject:name];
    }
    [self.carousel reloadData];
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
   
    return [self.items count];
    
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    //Card *card = items[index];
    //[cell.textLabel setText:[NSString stringWithFormat:@"%@", [card valueForKey:@"name"]]];
    //label.text = [card valueForKey:@"name"];
    label.text = items[index];
    
    return view;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addCard"]) {
        AddCardViewController *destViewController = segue.destinationViewController;
        destViewController.lesson = _lesson;
    }
}



@end