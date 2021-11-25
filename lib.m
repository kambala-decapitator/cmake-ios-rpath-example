#import "lib.h"
#import <UIKit/UIKit.h>

UIWindow* createWindow() {
	__auto_type window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
	window.rootViewController = [UIViewController new];
	[window makeKeyAndVisible];
	window.rootViewController.view.backgroundColor = UIColor.redColor;
	return window;
}
