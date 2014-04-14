//
//  RNConstants.h
//  ruche
//
//  Created by Eddy RICHARD on 15/03/2014.
//  Copyright (c) 2014 Eddy RICHARD. All rights reserved.
//

//--- Taille écran
#define RN_SCREEN_WIDTH         [[UIScreen mainScreen] bounds].size.width
#define RN_SCREEN_HEIGHT        [[UIScreen mainScreen] bounds].size.height
#define RN_VERSION_IOS          [[[UIDevice currentDevice] systemVersion] floatValue]

//--- WS
#define RN_HOST                                 @"www.google.com"
#define RN_GOOGLE_AGENDA_EVENT_REALEASE_XML     @"http://www.google.com/calendar/feeds/ruchenumerique%40gmail.com/public/full?singleevents=true&futureevents=true&orderby=starttime&sortorder=ascending"
#define RN_GOOGLE_AGENDA_EVENT_REALEASE_JSON    @"http://www.google.com/calendar/feeds/ruchenumerique%40gmail.com/public/full?alt=json-in-script&singleevents=true&futureevents=true&orderby=starttime&sortorder=ascending"
#define RN_FEED_NEWS_REALEASE                   @"http://www.laruchenumerique.com/feed/"

//--- Table Events
#define RN_HEIGHT_CELL_EVENT 85

//--- Id Twitter
#define RN_SCREEN_NAME          @"edrichardfr"
#define RN_CONSUMER_KEY         @"Wb6KsgKpNIABpBFF59tspQ"
#define RN_CONSUMER_SECRET      @"Nk8C8rEjNIRJO8ME524vFFzCC77NQD175LCP2q0lw"

//--- Table Twitter
#define RN_HEIGHT_CELL_TWITTER 100

//--- Color
#define RN_COLOR_NEWS           colorWithRed:(119/255.f) green:(38/255.f) blue:(255/255.f) alpha:1
