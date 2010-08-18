//
//  InitiativeViewController.m
//  LQFB
//
//

#import "InitiativeViewController.h"
#import "JSON/JSON.h"
#import "InitiativeDetailViewController.h"

@implementation InitiativeViewController

@synthesize names,areaID,descriptions,issueIDs,initiatives;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	rowCounter = 0;
	[self loadTheData];
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadTheData {
	NSLog(@"The area ID: %@",self.areaID);
	NSLog(@"Loading data");
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[@"http://lqfb.piratenpartei.de/pp/api/initiative.html?key=MYSUPERSECRETAPICODE&api_engine=json&area_id=" stringByAppendingString:areaID]]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"Finished Loading");
	[connection release];
	
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
	NSArray *temp = [[NSArray alloc] init];
	self.issueIDs = [[NSMutableArray alloc] init];
	
	self.initiatives = [responseString JSONValue];
	NSSortDescriptor *idSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"issue_id" ascending:YES selector:@selector(compare:)] autorelease];
    [self.initiatives sortUsingDescriptors:[NSArray arrayWithObjects:idSortDescriptor, nil]];
	self.descriptions = [self.initiatives valueForKey:@"current_draft_content"];
	self.names = [self.initiatives valueForKey:@"name"];
	temp = [self.initiatives valueForKey:@"issue_id"];
	
	
	for (int inx = 0; inx < [temp count]-1; inx++){
		
		if (![[NSString stringWithFormat:@"%@",[temp objectAtIndex:inx]] isEqualToString:[NSString stringWithFormat:@"%@",[temp objectAtIndex:inx+1]]]){
			[self.issueIDs addObject:[temp objectAtIndex:inx]];
		}
		
	}
	
	NSLog(@"%@",self.issueIDs);
		
	[self.tableView reloadData];
	
}

- (void)viewWillAppear:(BOOL)animated {
	rowCounter = 0;
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.issueIDs count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(issue_id == %@)", [self.issueIDs objectAtIndex:section]];
    NSArray *sortedIssues = [self.initiatives filteredArrayUsingPredicate:predicate];
    return [sortedIssues count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return [@"Thema #" stringByAppendingFormat:@"%@",[self.issueIDs objectAtIndex:section]];
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	

    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];

	cell.textLabel.text = [self.names objectAtIndex:rowCounter];
	rowCounter = rowCounter+1;
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	 InitiativeDetailViewController *detailViewController = [[InitiativeDetailViewController alloc] initWithNibName:@"InitiativeDetailViewController" bundle:nil];
     // ...
	detailViewController.descriptionContent = [self.descriptions objectAtIndex:indexPath.row];
	detailViewController.title = @"Details";
	[self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[names release];
	[areaID release];
	[descriptions release];
	[issueIDs release];
	[initiatives release];
    [super dealloc];
}


@end

