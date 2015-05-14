//
//  BurgerContainerViewController.m
//  StackOverflowz
//
//  Created by Brandon Roberts on 5/11/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "BurgerContainerViewController.h"
#import "MainMenuTableViewController.h"
#import "MyQuestionsViewController.h"

@interface BurgerContainerViewController () <MainMenuSelectionDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *slideTopViewGesture;
@property (strong, nonatomic) UITapGestureRecognizer *tapToCloseGesture;
@property (strong, nonatomic) UIBarButtonItem *burgerBarButton;

@property (strong, nonatomic) UIViewController *topVC;
@property (strong, nonatomic) UINavigationController *searchQuestionsNavVC;
@property (strong, nonatomic) MyQuestionsViewController *myQuestionsVC;

@end

NSTimeInterval openSlidePanelAnimationDuration = 0.3;
NSTimeInterval closeSlidePanelAnimationDuration = 0.2;

@implementation BurgerContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  MainMenuTableViewController *mainMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuVC"];
  [self addChildViewController:mainMenuVC];
  mainMenuVC.view.frame = self.view.frame;
  [self.view addSubview:mainMenuVC.view];
  [mainMenuVC didMoveToParentViewController:self];
  mainMenuVC.delegate = self;
  
  self.topVC = self.searchQuestionsNavVC;
}

-(void)openPanel {
  [UIView animateWithDuration:openSlidePanelAnimationDuration animations:^{
    CGRect topVCFrame = self.topVC.view.frame;
    CGRect burgerContainerFrame = self.view.frame;
    
    topVCFrame = CGRectMake(burgerContainerFrame.size.width * 0.75, 0, topVCFrame.size.width, topVCFrame.size.height);
    self.topVC.view.frame = topVCFrame;
    
  } completion:^(BOOL finished) {
    self.burgerBarButton.enabled = NO;
    [self.topVC.view addGestureRecognizer:self.tapToCloseGesture];
  }];
}

-(void)closePanel {
  [self.topVC.view removeGestureRecognizer:self.tapToCloseGesture];
  
  [UIView animateWithDuration:closeSlidePanelAnimationDuration animations:^{
    self.topVC.view.center = self.view.center;
  } completion:^(BOOL finished) {
    self.burgerBarButton.enabled = YES;
  }];
}

-(void)slidePanel:(UIPanGestureRecognizer *)panGesture {
  
  CGPoint translatedPoint = [panGesture translationInView:self.view];
  CGPoint velocity = [panGesture translationInView:self.view];
//  NSLog(@"Velocity: %f", velocity.x);

  
  if (panGesture.state == UIGestureRecognizerStateChanged) {
    
    if (velocity.x > 0 || self.topVC.view.frame.origin.x > 0) {
      self.topVC.view.center = CGPointMake(self.topVC.view.center.x + translatedPoint.x, self.topVC.view.center.y);
      [panGesture setTranslation:CGPointZero inView:self.view];
    }
    
  }
  
  if (panGesture.state == UIGestureRecognizerStateEnded) {
    
    if (self.topVC.view.frame.origin.x > self.view.frame.size.width / 4) {
      [self openPanel];
    } else {
      [self closePanel];
    }
  }
}

#pragma mark - MainMenuSelectionDelegate Methods

-(void)userDidSelectOption:(NSUInteger)selection {
  switch (selection) {
    case 0:
      self.topVC = self.searchQuestionsNavVC;
      break;
      
    case 1:
      self.topVC = self.myQuestionsVC;
      
    default:
      break;
  }
  
}


#pragma mark - Lazy Properties

-(UINavigationController *)searchQuestionsNavVC {
  if (_searchQuestionsNavVC) {
    return _searchQuestionsNavVC;
  }
  
  _searchQuestionsNavVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchQuestionsNavVC"];
  
  UIViewController *firstVC = _searchQuestionsNavVC.viewControllers[0];
  firstVC.navigationItem.leftBarButtonItem = self.burgerBarButton;
  return _searchQuestionsNavVC;
}

-(MyQuestionsViewController *)myQuestionsVC {
  if (_myQuestionsVC) {
    return _myQuestionsVC;
  }
  
  _myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionsVC"];
  return _myQuestionsVC;
}

-(UIBarButtonItem *)burgerBarButton {
  if (_burgerBarButton) {
    return _burgerBarButton;
  }
  
  _burgerBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:0 target:self action:@selector(openPanel)];
  return _burgerBarButton;
}

-(UIPanGestureRecognizer *)slideTopViewGesture {
  if (_slideTopViewGesture) {
    return _slideTopViewGesture;
  }
  
  _slideTopViewGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slidePanel:)];
  return _slideTopViewGesture;
}

-(UITapGestureRecognizer *)tapToCloseGesture {
  if (_tapToCloseGesture) {
    return _tapToCloseGesture;
  }
  
  _tapToCloseGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePanel)];
  return _tapToCloseGesture;
}

-(void)setTopVC:(UIViewController *)topVC {
  
  if (!_topVC) {
    _topVC = topVC;
    [_topVC.view addGestureRecognizer:self.slideTopViewGesture];
    [self addChildViewController:_topVC];
    [self.view addSubview:_topVC.view];
    [_topVC didMoveToParentViewController:self];
  }
  
  if (topVC != _topVC) {
    
    [UIView animateWithDuration:openSlidePanelAnimationDuration animations:^{

      CGRect burgerFrame = self.view.frame;
      // Animates it off screen to change the controller
      _topVC.view.frame = CGRectMake(burgerFrame.size.width, 0, burgerFrame.size.width, burgerFrame.size.height);
    
    } completion:^(BOOL finished) {
      
      
      
//      topVC.view.frame = _topVC.view.frame;
      [_topVC.view removeGestureRecognizer:self.slideTopViewGesture];
      [_topVC.view removeFromSuperview];
      [_topVC removeFromParentViewController];
      [_topVC willMoveToParentViewController:nil];
      
      _topVC = topVC;
      [_topVC.view addGestureRecognizer:self.slideTopViewGesture];
      [self addChildViewController:_topVC];
      [self.view addSubview:_topVC.view];
      [_topVC didMoveToParentViewController:self];
      
      [self closePanel];
    }];
  } else {
    [self closePanel];
  }
}

@end
