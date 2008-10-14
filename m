Message-ID: <48F473F0.8040204@domain.hid>
Date: Tue, 14 Oct 2008 12:26:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F3C3E4.4020801@domain.hid>
	<48F45847.3030704@domain.hid>	<48F461A6.6010600@domain.hid>
	<48F4634B.3030002@domain.hid>	<48F465DD.6020505@domain.hid>
	<48F46D3E.2040507@domain.hid>
In-Reply-To: <48F46D3E.2040507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __thread instead of pthread_get/setspecific
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi,
>>>>>>
>>>>>> looking into the "xeno_in_primary_mode" thing I wondered how to make the
>>>>>> thread state quickly retrievable. Going via pthread_getspecific as we do
>>>>>> for xeno_get_current appears logical - but not optimal. Though
>>>>>> getspecific is optimized for speed, it remains a function call, a few
>>>>>> sanity checks, and only finally a TLS variable access. That could be
>>>>>> achieved in a much lighter way by using a __thread variable.
>>>>>>
>>>>>> But can we assume that all target we support also support the __thread
>>>>>> storage class? TLS is surely mandatory now: I assume pthread_getspecific
>>>>>> would become non-RT safe without it, right? Is there anything we
>>>>>> can/must check for during configure to verify __thread support?
>>>>> I really think that this optimization is not worth the trouble. Anyway,
>>>> As long as we cannot specify the amount of "trouble", it's hard to
>>>> decide. Me current feeling is that it should rather simplify the
>>>> implementation + save us quite a few ops in the fast path (even more
>>>> with upcoming thread-mode check).
>>> The trouble is to make some reliable detections in the configure script,
>>> so that the user will know early that Xenomai can not work with its
>>> current toolchain. And to make this detection work with uclibc as well
>>> as with glibc, gcc 4 versus gcc 3, etc...
>> Will work out a test program for configure.
> 
> glibc does that:
> 
> AC_ARG_WITH([__thread],
>             AC_HELP_STRING([--without-__thread],
>                            [do not use TLS features even when supporting them]),
>             [use__thread=$withval],
>             [use__thread=yes])
> 
> dnl Check whether the compiler supports the __thread keyword.
> if test "x$use__thread" != xno; then
>   AC_CACHE_CHECK([for __thread], libc_cv_gcc___thread,
>   [cat > conftest.c <<\EOF
> __thread int a = 42;
> EOF
>   if AC_TRY_COMMAND([${CC-cc} $CFLAGS $CPPFLAGS -c conftest.c >&AS_MESSAGE_LOG_F
> D]); then
>     libc_cv_gcc___thread=yes
>   else
>     libc_cv_gcc___thread=no
>   fi
>   rm -f conftest*])
>   if test "$libc_cv_gcc___thread" = yes; then
>     AC_DEFINE(HAVE___THREAD)
>   fi
> else
>   libc_cv_gcc___thread=no
> fi
> 

Cool, thanks. Will play with this for xeno_get_current soon. Then we can
review and test if it works and makes sense based on some real code.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

