//
//  LQFBAppDelegate.h
//  LQFB
//
//

#import <UIKit/UIKit.h>

@interface LQFBAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

