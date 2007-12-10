#include <google/template.h>
#include <string>

#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

#include "ppport.h"

using namespace std;
using namespace google;

MODULE = Template::CTemplate		PACKAGE = Template::CTemplate		

PROTOTYPES: ENABLE

INCLUDE: XS/Template.xs
INCLUDE: XS/TemplateDictionary.xs

BOOT:
  {
    HV *mHvStash = gv_stashpv( "Template::CTemplate", TRUE );

    newCONSTSUB( mHvStash, "DO_NOT_STRIP",      newSViv(DO_NOT_STRIP)       );
    newCONSTSUB( mHvStash, "STRIP_BLANK_LINES", newSViv(STRIP_BLANK_LINES)  );
    newCONSTSUB( mHvStash, "STRIP_WHITESPACE",  newSViv(STRIP_WHITESPACE)   );

  }

