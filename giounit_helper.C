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

struct giounit_helper {
  giounit_helper() : units_(), debug_(false) {
    if (const char *val = std::getenv("GIOUNIT_DEBUG")) debug_ = true;
    if (debug_) {
      std::cerr << "giounit: giounit_helper::giounit_helper()\n"
                << "giounit: GIOUNIT_PREFIX = " << GIOUNIT_PREFIX << std::endl
                << "giounit: GIOUNIT_BEGIN = " << GIOUNIT_BEGIN << std::endl
                << "giounit: GIOUNIT_END = " << GIOUNIT_END << std::endl;
    }
    for (unsigned int u = GIOUNIT_BEGIN; u < GIOUNIT_END; ++u) {
      std::ostringstream is;
      is << GIOUNIT_PREFIX << u;
      if (const char *val = std::getenv(is.str().c_str())) {
        if (debug_) std::cerr << "giounit: opening \'" << val << "\' as unit " << u << std::endl;
        giounit_open(u, std::strlen(val), val);
        units_.push_back(u);
      }
    }
  }
  ~giounit_helper() {
    if (debug_) std::cerr << "giounit: giounit_helper::~giounit_helper()\n";
    for (int i = 0; i < units_.size(); ++i) {
      if (debug_) std::cerr << "giounit: closing unit " << units_[i] << std::endl;
      giounit_close(units_[i]);
    }
  }
  std::vector<unsigned int> units_;
  bool debug_;
} helper;

#endif // defined(__GNUC__)
