//
//  TRVTour.h
//  Indigenous


#import <UIKit/UIKit.h>
#import "TRVItinerary.h"
#import "TRVUser.h"
#import "TRVItinerary.h"
#import "TRVTourCategory.h"

@interface TRVTour : NSObject <NSCoding>

//The user that created/owns this Tour object.
@property (nonatomic, strong) TRVUser *guideForThisTour;
@property (nonatomic) BOOL *isPurchased;
@property (nonatomic, strong) TRVItinerary *itineraryForThisTour;
@property (nonatomic, strong) TRVTourCategory *categoryForThisTour;
@property (nonatomic, strong) NSDate *tourDeparture;        //The date of the start of a tour program.
@property (nonatomic) CGFloat tourAverageRating;
@property (nonatomic) NSNumber *costOfTour;
@property (nonatomic, strong) NSString *tourDescription;
//itemizing and calculating all the costs the tour
-(instancetype)initWithGuideUser:(TRVUser *)guideUser itineraryForThisTour:(TRVItinerary *)itinerary categoryForThisTour:(TRVTourCategory *)category;

@end
