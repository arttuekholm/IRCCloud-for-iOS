#import <objc/runtime.h>
#import "ICGlobal.h"
#import "ICApplication.h"
#import "ICNetworksViewController.h"
#import "ICChatViewController.h"
#import "ICChatRequest.h"
#import "NSString+Base64.h"

@implementation ICApplication
@synthesize window,cookie,userIsOnAlpha,connection;
-(ICApplication *)init{
	if((self=[super init]))userIsOnAlpha=NO;
	return self;
}
-(void)applicationDidFinishLaunching:(UIApplication *)application{
	window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
	NSDictionary *prefs=[NSDictionary dictionaryWithContentsOfFile:prefpath];
	self.cookie=[[prefs objectForKey:@"Session"]base64DecodedString];
	sidebar=[[ICNetworksViewController alloc]init];
	sidebar.hasCookie=!![prefs objectForKey:@"Session"];
	sidebarNavController=[[[UINavigationController alloc]initWithRootViewController:sidebar]autorelease];
	if(isPad){
		viewController=[[objc_getClass("UISplitViewController") alloc]init];
		viewController.delegate=self;
		main=[[ICChatViewController alloc]init];
		mainNavController=[[[UINavigationController alloc]initWithRootViewController:main]autorelease];
		viewController.viewControllers=[NSArray arrayWithObjects:sidebarNavController,mainNavController,nil];
		[window addSubview:viewController.view];
	}else [window addSubview:sidebarNavController.view];
	[window makeKeyAndVisible];
}
-(void)splitViewController:(UISplitViewController *)split willHideViewController:(UIViewController *)ctrl withBarButtonItem:(UIBarButtonItem *)item forPopoverController:(UIPopoverController *)popover{
	sidebar.title=item.title=__(@"CONNECTIONS");
	main.navigationItem.leftBarButtonItem=item;
}
-(void)splitViewController:(UISplitViewController *)split willShowViewController:(UIViewController *)ctrl invalidatingBarButtonItem:(UIBarButtonItem *)item{
	sidebar.title=__(@"IRCCLOUD");
	main.navigationItem.leftBarButtonItem=nil;
}
-(void)connect{
	NSLog(@"connection time!");
	/*ICChatRequestParser *parser=[[ICChatRequestParser alloc]init];
	self.connection=[ICChatRequest requestWithDelegate:parser selector:@selector(receivedResponse:)];*/
}
-(void)dealloc{
	[window release];
	[sidebar release];
	[main release];
	[sidebarNavController release];
	[mainNavController release];
	[super dealloc];
}
@end