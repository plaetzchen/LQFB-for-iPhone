//
//  InitiativeDetailViewController.h
//  LQFB
//
//

#import <UIKit/UIKit.h>


@interface InitiativeDetailViewController : UIViewController <UITextFieldDelegate>{
	
	NSString *descriptionContent;
	IBOutlet UITextView *descriptionView;

}

@property (nonatomic,retain) NSString *descriptionContent;
@property (nonatomic,retain) IBOutlet UITextView *descriptionView; 

@end
