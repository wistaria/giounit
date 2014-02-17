/*****************************************************************************
*
* giounit: gfortran utility for file and logical unit assginment
*
* Copyright (C) 2013-2014 by Synge Todo <wistaria@comp-phys.org>
*
* Distributed under the Boost Software License, Version 1.0. (See accompanying
* file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
*
*****************************************************************************/

#ifndef GIOUNIT_H
#define GIOUNIT_H

#if defined(__GNUC__)

#ifndef GIOUNIT_PREFIX
#define GIOUNIT_PREFIX "FORT"
#endif

#ifndef GIOUNIT_BEGIN
#define GIOUNIT_BEGIN 10
#endif

#ifndef GIOUNIT_END
#define GIOUNIT_END 100
#endif

#include <cstdlib>
#include <cstring>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

extern "C" {

void giounit_open(int unit, int len, const char *path);
void giounit_open_unformatted(int unit, int len, const char *path);
void giounit_close(int unit);

}

struct giounit_opener {
  giounit_opener(unsigned int unit, bool formatted = true) : unit_(unit), opened_(false) {
    std::ostringstream is;
    is << GIOUNIT_PREFIX << unit_;
    if (const char *val = std::getenv(is.str().c_str())) {
      opened_ = true;
      if (formatted) {
        if (std::getenv("GIOUNIT_DEBUG"))
          std::cerr << "giounit: opening \'" << val << "\' in formatted mode as unit "
                    << unit << std::endl;
        giounit_open(unit, std::strlen(val), val);
      } else {
        if (std::getenv("GIOUNIT_DEBUG"))
          std::cerr << "giounit: opening \'" << val << "\' in unformatted mode as unit "
                    << unit << std::endl;
        giounit_open_unformatted(unit, std::strlen(val), val);
      }
    }
  }
  ~giounit_opener() {
    if (opened_) {
      if (std::getenv("GIOUNIT_DEBUG"))
        std::cerr << "giounit: closing unit " << unit_ << std::endl;
      giounit_close(unit_);
    }
  }
  unsigned int unit_;
  bool opened_;
};

struct giounit_scanner {
  giounit_scanner() : openers_() {
    if (std::getenv("GIOUNIT_DEBUG")) {
      std::cerr << "giounit: giounit_scanner::giounit_scanner()\n"
                << "giounit: GIOUNIT_PREFIX = " << GIOUNIT_PREFIX << std::endl
                << "giounit: GIOUNIT_BEGIN = " << GIOUNIT_BEGIN << std::endl
                << "giounit: GIOUNIT_END = " << GIOUNIT_END << std::endl;
    }
    for (unsigned int u = GIOUNIT_BEGIN; u < GIOUNIT_END; ++u)
      openers_.push_back(new giounit_opener(u));
  }
  ~giounit_scanner() {
    if (std::getenv("GIOUNIT_DEBUG"))
      std::cerr << "giounit: giounit_scanner::~giounit_scanner()\n";
    for (int i = 0; i < openers_.size(); ++i) delete openers_[i];
  }
  std::vector<giounit_opener*> openers_;
};

#else

struct giounit_opener {
  giounit_opener(unsigned int, bool = true) {}
};
  
struct giounit_scanner {};
  
#endif // defined(__GNUC__)

#define GIOUNIT_JOIN(X, Y) GIOUNIT_DO_JOIN(X, Y)
#define GIOUNIT_DO_JOIN(X, Y) X##Y

#define GIOUNIT_SCAN \
  namespace { giounit_scanner scanner; }
#define GIOUNIT_OPEN(unit) \
  namespace { giounit_opener GIOUNIT_JOIN(opener_, __LINE__) (unit, true); }
#define GIOUNIT_OPEN_UNFORMATTED(unit) \
  namespace { giounit_opener GIOUNIT_JOIN(opener_, __LINE__) (unit, false); }
  
#endif // GIOUNIT_H
