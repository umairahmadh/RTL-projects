// Profiling bitset implementation -*- C++ -*-

// Copyright (C) 2009-2016 Free Software Foundation, Inc.
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

/** @file profile/bitset
 *  This file is a GNU profile extension to the Standard C++ Library.
 */

#ifndef _GLIBCXX_PROFILE_BITSET
#define _GLIBCXX_PROFILE_BITSET

#include <bitset>

namespace std _GLIBCXX_VISIBILITY(default)
{
namespace __profile
{
  /// Class std::bitset wrapper with performance instrumentation, none at the
  /// moment.
  template<size_t _Nb>
    class bitset
    : public _GLIBCXX_STD_C::bitset<_Nb>
    {
      typedef _GLIBCXX_STD_C::bitset<_Nb> _Base;

    public:
      // 23.3.5.1 constructors:
#if __cplusplus < 201103L
      bitset()
      : _Base() { }
#else
      constexpr bitset() = default;
#endif

#if __cplusplus >= 201103L
      constexpr bitset(unsigned long long __val) noexcept
#else
      bitset(unsigned long __val)
#endif
      : _Base(__val) { }

      template<typename _CharT, typename _Traits, typename _Alloc>
	explicit
	bitset(const std::basic_string<_CharT, _Traits, _Alloc>& __str,
	       typename std::basic_string<_CharT, _Traits, _Alloc>::size_type
	       __pos = 0,
	       typename std::basic_string<_CharT, _Traits, _Alloc>::size_type
	       __n = (std::basic_string<_CharT, _Traits, _Alloc>::npos))
	: _Base(__str, __pos, __n) { }

      // _GLIBCXX_RESOLVE_LIB_DEFECTS
      // 396. what are characters zero and one.
      template<class _CharT, class _Traits, class _Alloc>
	bitset(const std::basic_string<_CharT, _Traits, _Alloc>& __str,
	       typename std::basic_string<_CharT, _Traits, _Alloc>::size_type
	       __pos,
	       typename std::basic_string<_CharT, _Traits, _Alloc>::size_type
	       __n,
	       _CharT __zero, _CharT __one = _CharT('1'))
	: _Base(__str, __pos, __n, __zero, __one) { }

      bitset(const _Base& __x) : _Base(__x) { }

#if __cplusplus >= 201103L
      template<typename _CharT>
	explicit
	bitset(const _CharT* __str,
	       typename std::basic_string<_CharT>::size_type __n
	       = std::basic_string<_CharT>::npos,
	       _CharT __zero = _CharT('0'), _CharT __one = _CharT('1'))
	: _Base(__str, __n, __zero, __one) { }
#endif

      // 23.3.5.2 bitset operations:
      bitset<_Nb>&
      operator&=(const bitset<_Nb>& __rhs) _GLIBCXX_NOEXCEPT
      {
	_M_base() &= __rhs;
	return *this;
      }

      bitset<_Nb>&
      operator|=(const bitset<_Nb>& __rhs) _GLIBCXX_NOEXCEPT
      {
	_M_base() |= __rhs;
	return *this;
      }

      bitset<_Nb>&
      operator^=(const bitset<_Nb>& __rhs) _GLIBCXX_NOEXCEPT
      {
	_M_base() ^= __rhs;
	return *this;
      }

      bitset<_Nb>&
      operator<<=(size_t __pos) _GLIBCXX_NOEXCEPT
      {
	_M_base() <<= __pos;
	return *this;
      }

      bitset<_Nb>&
      operator>>=(size_t __pos) _GLIBCXX_NOEXCEPT
      {
	_M_base() >>= __pos;
	return *this;
      }

      bitset<_Nb>&
      set() _GLIBCXX_NOEXCEPT
      {
	_Base::set();
	return *this;
      }

      // _GLIBCXX_RESOLVE_LIB_DEFECTS
      // 186. bitset::set() second parameter should be bool
      bitset<_Nb>&
      set(size_t __pos, bool __val = true)
      {
	_Base::set(__pos, __val);
	return *this;
      }

      bitset<_Nb>&
      reset() _GLIBCXX_NOEXCEPT
      {
	_Base::reset();
	return *this;
      }

      bitset<_Nb>&
      reset(size_t __pos)
      {
	_Base::reset(__pos);
	return *this;
      }

      bitset<_Nb>
      operator~() const _GLIBCXX_NOEXCEPT
      { return bitset(~_M_base()); }

      bitset<_Nb>&
      flip() _GLIBCXX_NOEXCEPT
      {
	_Base::flip();
	return *this;
      }

      bitset<_Nb>&
      flip(size_t __pos)
      {
	_Base::flip(__pos);
	return *this;
      }

      bool
      operator==(const bitset<_Nb>& __rhs) const _GLIBCXX_NOEXCEPT
      { return _M_base() == __rhs; }

      bool
      operator!=(const bitset<_Nb>& __rhs) const _GLIBCXX_NOEXCEPT
      { return _M_base() != __rhs; }

      bitset<_Nb>
      operator<<(size_t __pos) const _GLIBCXX_NOEXCEPT
      { return bitset<_Nb>(_M_base() << __pos); }

      bitset<_Nb>
      operator>>(size_t __pos) const _GLIBCXX_NOEXCEPT
      { return bitset<_Nb>(_M_base() >> __pos); }

      _Base&
      _M_base() _GLIBCXX_NOEXCEPT
      { return *this; }

      const _Base&
      _M_base() const _GLIBCXX_N