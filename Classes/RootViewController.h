//
//  RootViewController.h
//  LQFB
//
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UITableViewDataSource> {
	
	NSMutableData *responseData;
	NSDictionary *areaNames;
	NSMutableArray *names;
	
	
}

@property (nonatomic,retain) NSDictionary *areaNames;
@property (nonatomic,retain) NSMutableArray *names;

-(void)loadTheData;

@end
