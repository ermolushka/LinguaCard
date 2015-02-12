//
//  EnglishLessonsTableViewController.m
//  LinguaCard
//
//  Created by alexey on 25.01.15.
//  Copyright (c) 2015 alexey. All rights reserved.
//

#import "EnglishLessonsTableViewController.h"
#import "CardsTableViewController.h"
#import <CoreData/CoreData.h>
#import "ELesson.h"
#import "EditLessonViewController.h"


@interface EnglishLessonsTableViewController ()

@property (strong) NSMutableArray *lessons;

@end

@implementation EnglishLessonsTableViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Коллекции";
    
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setTintColor:[UIColor whiteColor]];
    
    UIColor *red = [UIColor whiteColor];
    NSMutableDictionary *navBarTextAttributes = [NSMutableDictionary dictionaryWithCapacity:1];
    
    [navBarTextAttributes setObject:red forKey:NSForegroundColorAttributeName ];
    
    self.navigationController.navigationBar.titleTextAttributes = navBarTextAttributes;
   
    
    
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ELesson"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    self.lessons = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.lessons count];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_searchResults count];
        
    } else {
        return [_lessons count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        ELesson *lesson = [_searchResults objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@", [lesson valueForKey:@"name"]]];
        
        if ([lesson.cards count] == 1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[lesson.cards count], @"карточка"];
        } else{
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[lesson.cards count], @"карточек"];
        }
    } else {
        ELesson *lesson = [self.lessons objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@", [lesson valueForKey:@"name"]]];
        
        if ([lesson.cards count] == 1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[lesson.cards count], @"карточка"];
        } else{
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[lesson.cards count], @"карточек"];
        }
    }
    
   
    /*
    ELesson *lesson = [self.lessons objectAtIndex:indexPath.row];
    
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [lesson valueForKey:@"name"]]];
    
    if ([lesson.cards count] == 1) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[lesson.cards count], @"карточка"];
    } else{
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[lesson.cards count], @"карточек"];
    }
     */
    return cell;
}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.lessons objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.lessons removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *edit = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"редактировать" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [self performSegueWithIdentifier:@"editLesson" sender:indexPath];
    }];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"удалить"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [context deleteObject:[self.lessons objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.lessons removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    return @[deleteAction, edit];
}




- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    _searchResults = [_lessons filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}




/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"showCard"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CardsTableViewController *destViewController = segue.destinationViewController;
        destViewController.lesson = [self.lessons objectAtIndex:indexPath.row];
        destViewController.lessonName = [[self.lessons objectAtIndex:indexPath.row]valueForKey:@"name"];
    } else if ([[segue identifier] isEqualToString:@"editLesson"]) {
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        NSManagedObject *selectedLesson = [self.lessons objectAtIndex:indexPath.row];
        EditLessonViewController *destViewController = segue.destinationViewController;
        destViewController.lesson = selectedLesson;
    }
}

@end
