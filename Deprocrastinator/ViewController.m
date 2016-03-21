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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoItems = [[NSMutableArray alloc] init];
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
    return cell;
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    NSString *task = self.inputTextField.text;
    [self.toDoItems addObject:task];
    [self.tableView reloadData];
    self.inputTextField.text = @"";
    [self.inputTextField resignFirstResponder];
}

@end
