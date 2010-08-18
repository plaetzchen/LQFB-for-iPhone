//
//  InitiativeViewController.h
//  LQFB
//
//

#import <UIKit/UIKit.h>


@interface InitiativeViewController : UITableViewController <UITableViewDataSource> {
	
	NSMutableData *responseData;
	NSArray *names;
	NSArray *descriptions;
	NSString *areaID;
	NSMutableArray *issueIDs;
	NSMutableDictionary *initiatives;
	int rowCounter;

}

@property (nonatomic,retain) NSArray *names;
@property (nonatomic,retain) NSArray *descriptions;
@property (nonatomic,retain) NSString *areaID;
@property (nonatomic,retain) NSMutableArray *issueIDs;
@property (nonatomic,retain) NSMutableDictionary *initiatives;


-(void) loadTheData;

@end
