// <experimental/algorithm> -*- C++ -*-

// Copyright (C) 2014-2016 Free Software Foundation, Inc.
//
// This file is part of the GNU ISO C++ Library.  This library is free
// software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the
// Free Software Foundation; either version 3, or (at your option)
// any later version.

// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// Under Section 7 of GPL version 3, you are granted additional
// permissions described in the GCC Runtime Library Exception, version
// 3.1, as published by the Free Software Foundation.

// You should have received a copy of the GNU General Public License and
// a copy of the GCC Runtime Library Exception along with this program;
// see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
// <http://www.gnu.org/licenses/>.

/** @file experimental/algorithm
 *  This is a TS C++ Library header.
 */

#ifndef _GLIBCXX_EXPERIMENTAL_ALGORITHM
#define _GLIBCXX_EXPERIMENTAL_ALGORITHM 1

#pragma GCC system_header

#if __cplusplus <= 201103L
# include <bits/c++14_warning.h>
#else

#include <algorithm>
#include <random>

namespace std _GLIBCXX_VISIBILITY(default)
{
namespace experimental
{
inline namespace fundamentals_v1
{
_GLIBCXX_BEGIN_NAMESPACE_VERSION

  template<typename _ForwardIterator, typename _Searcher>
    inline _ForwardIterator
    search(_ForwardIterator __first, _ForwardIterator __last,
	   const _Searcher& __searcher)
    { return __searcher(__first, __last); }

#define __cpp_lib_experimental_sample 201402

  /// Reservoir sampling algorithm.
  template<typename _InputIterator, typename _RandomAccessIterator,
           typename _Size, typename _UniformRandomNumberGenerator>
    _RandomAccessIterator
    __sample(_InputIterator __first, _InputIterator __last, input_iterator_tag,
	     _RandomAccessIterator __out, random_access_iterator_tag,
	     _Size __n, _UniformRandomNumberGenerator&& __g)
    {
      using __distrib_type = std::uniform_int_distribution<_Size>;
      using __param_type = typename __distrib_type::param_type;
      __distrib_type __d{};
      _Size __sample_sz = 0;
      while (__first != __last && __sample_sz != __n)
	__out[__sample_sz++] = *__first++;
      for (auto __pop_sz = __sample_sz; __first != __last;
	  ++__first, ++__pop_sz)
	{
	  const auto __k = __d(__g, __param_type{0, __pop_sz});
	  if (__k < __n)
	    __out[__k] = *__first;
	}
      return __out + __sample_sz;
    }

  /// Selection sampling algorithm.
  template<typename _ForwardIterator, typename _OutputIterator, typename _Cat,
           typename _Size, typename _UniformRandomNumberGenerator>
    _OutputIterator
    __sample(_ForwardIterator __first, _ForwardIterator __last,
	     forward_iterator_tag,
	     _OutputIterator __out, _Cat,
	     _Size __n, _UniformRandomNumberGenerator&& __g)
    {
      using __distrib_type = std::uniform_int_distribution<_Size>;
      using __param_type = typename __distrib_type::param_type;
      __distrib_type __d{};
      _Size __unsampled_sz = std::distance(__first, __last);
      for (__n = std::min(__n, __unsampled_sz); __n != 0; ++__first)
	if (__d(__g, __param_type{0, --__unsampled_sz}) < __n)
	  {
	    *__out++ = *__first;
	    --__n;
	  }
      return __out;
    }

  /// Take a random sample from a population.
  template<typename _PopulationIterator, typename _SampleIterator,
           typename _Distance, typename _UniformRandomNumberGenerator>
    _SampleIterator
    sample(_PopulationIterator __first, _PopulationIterator __last,
	   _SampleIterator __out, _Distance __n,
	   _UniformRandomNumberGenerator&& __g)
    {
      using __pop_cat = typename
	std::iterator_traits<_PopulationIterator>::iterator_category;
      using __samp_cat = typename
	std::iterator_traits<_SampleIterator>::iterator_category;

      static_assert(
	  __or_<is_convertible<__pop_cat, forward_iterator_tag>,