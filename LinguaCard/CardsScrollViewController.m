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

@property (nonatomic, strong) NSMutableArray *otherSides;

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
    
    self.otherSides = [NSMutableArray array];
    
    for (NSString *sides in [self.cards valueForKey:@"otherSide"]){
        [_otherSides addObject:sides];
        
    }
    
    [self.carousel reloadData];
    
    NSLog(@"%@", _otherSides);
    
   
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
    UIButton *button = (UIButton *)view;
    if (button == nil)
    {
        //no button available to recycle, so create new one
        UIImage *image = [UIImage imageNamed:@"page.png"];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    [button setTitle:[NSString stringWithFormat:@"%@", self.items[index]] forState:UIControlStateNormal];
    
    return button;
}

- (void)buttonTapped:(UIButton *)sender
{
    //get item index for button
    NSInteger index = [carousel indexOfItemViewOrSubview:sender];
    
    self.otherSide.text = self.otherSides[index];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addCard"]) {
        AddCardViewController *destViewController = segue.destinationViewController;
        destViewController.lesson = _lesson;
    }
}



@end