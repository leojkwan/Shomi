//
//  TRVUserContactView.m
//  Indigenous
//


#import "TRVUserContactView.h"
#import <Masonry.h>

@implementation TRVUserContactView



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                  owner:self
                                options:nil];
    
    [self addSubview:self.userContactContentView];
    self.userContactContentView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.userContactContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    //Hey, were changes made"?
    
    //if changes made, then call on updateConstraints:
    
    //else dont do anything

//    [self setNeedsUpdateConstraints];
    
}

//- (void)updateConstraints {
//    
//    UIView *view = self.userContactContentView;
//    NSDictionary *views = NSDictionaryOfVariableBindings(view);
//    NSMutableArray *constraints = [[NSMutableArray alloc] init];
//    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[view]|" options:0 metrics:nil views:views]];
//    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|[view]|" options:0 metrics:nil views:views]];
//    [self addConstraints:constraints];
//    [super updateConstraints];
//}

-(void)setUserForThisContactView:(TRVUser *)userForThisContactView {
    
    _userForThisContactView = userForThisContactView;
    self.userEmailLabel.text = userForThisContactView.userBio.email;
    self.userLanguagesLabel.text = userForThisContactView.userBio.language;
}


@end
