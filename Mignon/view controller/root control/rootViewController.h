//
//  rootViewController.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/10.
//
//

#import <UIKit/UIKit.h>
#import "FlowCoverView.h"

@interface rootViewController : UIViewController <FlowCoverViewDelegate>
{
    IBOutlet FlowCoverView *coverFlow;
}


@end
