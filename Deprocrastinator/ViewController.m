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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoItems = [[NSMutableArray alloc] init];
    self.colors = [[NSMutableArray alloc] init];
    self.isEditing = NO;

    // TODO: make me pretty
    self.inputTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.inputTextField.layer.borderWidth = 2.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toDoItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [self.colors objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    NSString *task = self.inputTextField.text;
    [self.toDoItems addObject:task];
    [self.colors addObject:[UIColor blackColor]];

    [self.tableView reloadData];
    self.inputTextField.text = @"";
    [self.inputTextField resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEditing) {
        [self.colors removeObjectAtIndex:indexPath.row];
        [self.toDoItems removeObjectAtIndex:indexPath.row];
    } else {
        self.colors[indexPath.row] = [UIColor greenColor];
        [self.tableView reloadData];
    }
    [self.tableView reloadData];
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    self.isEditing = !self.isEditing;
    if (self.isEditing) {
        sender.title = @"Done";
    } else {
        sender.title = @"Edit";
    }
}


@end
