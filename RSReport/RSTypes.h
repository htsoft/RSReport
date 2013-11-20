//
//  RSTypes.h
//  RSReport
//
//  Created by Roberto Scarciello on 15/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#ifndef RSReport_RSTypes_h
#define RSReport_RSTypes_h

typedef enum {
    RSTopBorder = 1,
    RSLeftBorder = 2,
    RSRightBorder = 4,
    RSBottomBorder = 8
} RSBorderTypes;

typedef NSInteger RSBorder;

#endif

#ifndef RSReport_RSAlignments_h
#define RSReport_RSAlignments_h

typedef enum {
    RSItemAlignLeft = 0,
    RSItemAlignCenter = 1,
    RSItemAlignRight = 2
} RSItemAlignmentTypes;

typedef NSInteger RSItemAlignment;

typedef enum {
    RSReportPDFType = 0,
    RSReportCSVType = 1
} RSReportTypes;

typedef NSInteger RSReportType;

typedef enum {
    RSNewLineCR = 0,
    RSNewLineLF = 1,
    RSNewLineCRLF = 2,
    RSNewLineLFCR = 3
} RSNewLineSeparatorTypes;

typedef NSInteger RSNewLineSeparator;

#endif