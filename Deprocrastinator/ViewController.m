//
//  ViewController.m
//  Deprocrastinator
//
//  Created by id on 3/21/16.
//  Copyright © 2016 id. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *toDoItems;
@property NSMutableArray *colors;
@property BOOL isEditing;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoItems = [[NSMutableArray alloc] init];
    self.colors = [[NSMutableArray alloc] init];
    self.isEditing = NO;
    self.tableView.editing = NO;

    // TODO: make me pretty
    self.inputTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.inputTextField.layer.borderWidth = 2.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toDoItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    UISwipeGestureRecognizer *swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeR setDirection:UISwipeGestureRecognizerDirectionRight];
    [cell addGestureRecognizer:swipeR];

    cell.textLabel.text = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [self.colors objectAtIndex:indexPath.row];
    return cell;
}

-(void) handleSwipe:(UISwipeGestureRecognizer *) sender {
    UITableViewCell *cell = (UITableViewCell *) sender.view;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    UIColor *currentColor = [self.colors objectAtIndex:indexPath.row];
    UIColor *newColor = nil;

    if (currentColor == [UIColor greenColor]){
        newColor = [UIColor yellowColor];
    } else if (currentColor == [UIColor yellowColor]){
        newColor = [UIColor redColor];
    } else if (currentColor == [UIColor redColor]){
        newColor = [UIColor blackColor];
    } else if (currentColor == [UIColor blackColor]){
        newColor = [UIColor greenColor];
    }

    self.colors[indexPath.row] = newColor;
    [self.tableView reloadData];
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    NSString *task = self.inputTextField.text;
    if (![task isEqualToString:@""]) {
        [self.toDoItems insertObject:task atIndex:0];
        [self.colors insertObject:[UIColor blackColor] atIndex:0];

        [self.tableView reloadData];
        self.inputTextField.text = @"";
        [self.inputTextField resignFirstResponder];
    }
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    self.isEditing = !self.isEditing;
    if (self.isEditing) {
        sender.title = @"Done";
    } else {
        sender.title = @"Edit";
    }
    self.tableView.editing = !self.tableView.editing;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
        return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Really want to delete?" message:@"are you sure?" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [tableView deselectRowAtIndexPath:indexPath animated:YES];
                                                       }];
        
        UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self.colors removeObjectAtIndex:indexPath.row];
                                                           [self.toDoItems removeObjectAtIndex:indexPath.row];
                                                           [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                       }];

        [alertController addAction:cancel];
        [alertController addAction:delete];

        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        NSLog(@"We can't delete this");
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    UIColor *tmpColor = self.colors[sourceIndexPath.row];
    NSString *tmpTodo = self.toDoItems[sourceIndexPath.row];

    self.colors[sourceIndexPath.row] = self.colors[destinationIndexPath.row];
    self.toDoItems[sourceIndexPath.row] = self.toDoItems[destinationIndexPath.row];

    self.colors[destinationIndexPath.row] = tmpColor;
    self.toDoItems[destinationIndexPath.row] = tmpTodo;

    [self.tableView reloadData];
}

@end
