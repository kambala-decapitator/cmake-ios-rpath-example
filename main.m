#import <UIKit/UIKit.h>
#import <lib.h>
#import <extlib.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow* window;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
	self.window = createWindow();
	NSLog(@"%d, %@", isStoreAvailable(), NSBundle.mainBundle.bundlePath);
	return YES;
}

@end

int main(int argc, char* argv[]) {
	@autoreleasepool {
		return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	}
}
