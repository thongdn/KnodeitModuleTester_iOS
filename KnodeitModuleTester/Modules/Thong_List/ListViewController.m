//
//  List.m
//  Demo
//
//  Created by Ngoc Thong on 1/15/15.
//
//

#import "ListViewController.h"
#import "ChangeProfileViewController.h"
#import "Data_Text.h"
#import "CustomTableViewCell.h"

Data_Text *data_text;
@interface ListViewController ()

@end

@implementation ListViewController
{
NSArray *data;
NSInteger index;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self load_data];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)load_data{
    data_text=[[Data_Text alloc]init];
    data=[[data_text readfile] componentsSeparatedByString:@"\n"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *simpleTableIdentifier = @"CustomTableCell";
    
    CustomTableViewCell *cell =(CustomTableViewCell*) [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSArray *profile=[[data objectAtIndex:indexPath.row]componentsSeparatedByString:@"\t"];
    cell.lb_name.text = profile[2];
    cell.lb_gender.text=profile[3];
    
    NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Documents/%@.jpeg",profile[0]]];
    cell.imageview.image=[UIImage imageWithContentsOfFile:imagePath];
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    index=indexPath.row;
    [self performSegueWithIdentifier:@"segue_list_profile" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //UINavigationController *NaC=(UINavigationController*)[segue destinationViewController];
    ChangeProfileViewController *cp=(ChangeProfileViewController*)[segue destinationViewController];
    cp.data=[data objectAtIndex:index];
}


- (IBAction)unwindToListViewController:(UIStoryboardSegue *)unwindSegue{
    [self load_data];
    [self.tableView reloadData];
}

- (IBAction)bt_logout_click:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end