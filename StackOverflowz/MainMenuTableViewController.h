//
//  MainMenuTableViewController.h
//  StackOverflowz
//
//  Created by Brandon Roberts on 5/11/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainMenuSelectionDelegate <NSObject>

-(void)userDidSelectOption:(NSUInteger)selection;

@end

@interface MainMenuTableViewController : UITableViewController

@property (weak, nonatomic) id<MainMenuSelectionDelegate> delegate;

@end
