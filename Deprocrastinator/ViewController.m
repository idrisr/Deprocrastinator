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
@property NSMutableArray *toDoItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSLog(@"%@", task);
    [self.toDoItems addObject:task];
    [self.tableView reloadData];
}

@end
