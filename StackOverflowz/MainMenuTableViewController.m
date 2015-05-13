//
//  MainMenuTableViewController.m
//  StackOverflowz
//
//  Created by Brandon Roberts on 5/11/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "MainMenuTableViewController.h"

@interface MainMenuTableViewController ()

@end

@implementation MainMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if ([self.delegate respondsToSelector:@selector(userDidSelectOption:)]) {
    [self.delegate userDidSelectOption:indexPath.row];
  }
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
