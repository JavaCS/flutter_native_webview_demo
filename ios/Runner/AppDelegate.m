#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

#import "WebViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

  FlutterMethodChannel* webviewChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"samples.flutter.io/webview"
                                          binaryMessenger:controller];

  [webviewChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    if ([@"openUrl" isEqualToString:call.method]) {
        [self openWebView:call.arguments];
        result(nil);
    } else {
      result(FlutterMethodNotImplemented);
    }
  }];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)openWebView:(NSString *)url {
    WebViewController *vc = [[WebViewController alloc] init];
    vc.url = url;

    UIViewController *viewController = self.window.rootViewController;
    // 1. modal view controller
//    [viewController presentViewController:vc animated:YES completion:nil];

    // 2. using UINavigationController
    if ([viewController isKindOfClass:[FlutterViewController class]]) {
        self.window.rootViewController = nil;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
        self.window.rootViewController = navi;
        [navi pushViewController:vc animated:YES];
    } else {
        UINavigationController *navi = (UINavigationController *)viewController;
        [navi pushViewController:vc animated:YES];
    }
}

@end
