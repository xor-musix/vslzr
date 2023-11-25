#pragma once


#if defined ( _WIN32 )
  #define __func__ __FUNCTION__
#else
  #define __func__ __func__
#endif

