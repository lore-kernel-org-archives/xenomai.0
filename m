Message-ID: <48F499EF.9010205@domain.hid>
Date: Tue, 14 Oct 2008 15:09:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F3C3E4.4020801@domain.hid>
	<48F45847.3030704@domain.hid>	<48F461A6.6010600@domain.hid>
	<48F4634B.3030002@domain.hid>	<48F465DD.6020505@domain.hid>
	<48F46954.6050704@domain.hid> <48F473A2.1050104@domain.hid>
	<48F48E2E.2050004@domain.hid> <48F49540.3060507@domain.hid>
	<48F49637.2030000@domain.hid> <48F497B2.4080404@domain.hid>
	<48F4987F.1060901@domain.hid>
In-Reply-To: <48F4987F.1060901@domain.hid>
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
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> It will always remain orders of magnitude heavier than __thread
>>>>>>>> variables which are a) inlined and b) should only need two memory
>>>>>>>> accesses at worst. Moreover, it is clearly the future, while the
>>>>>>>> importance of pthread_getspecific will decrease over the time. The
>>>>>>>> __thread storage class is C99 standard (though its implementation
>>>>>>>> remains a separate topic).
>>>>>>> You are exagerating a bit: pthread_getspecific is pretty efficient
>>>>>>> already (from the few things that I have timed on ARM, it is the only
>>>>>>> one which takes under the microsecond). That you will gain something
>>>>>>> with __thread is not guaranteed by the C99 standard either: in fact the
>>>>>>> implementation could use exactly the same functions.
>>>>>> As long as we do not loose anything (performance or portability),
>>>>> You loose portability. But I agree that we do not care much.
>>>> The fallback remains - must remain in order to obtain true optimization
>>>> from the TLS-based version without locking out some corner-case usage.
>>>> Find a proposal below (on top of handle-based xeno_get_current).
>>>>
>>>> We have to set initial-exec as TLS model, otherwise we end up with a
>>>> dynamic lookup similar (maybe still faster, dunno) to the pthread
>>>> service. This model requires start-time linking, will not work with
>>>> dlopen (I strongly assume the linker will bail out). But I consider
>>>> runtime loading of Xenomai libs as a uncommon corner case, and the user
>>>> can still re-enable it via --without-__thread.
>>> glibc has a separate test to know whether the tsl_model attribute is
>>> supported:
>>>
>>> if test "$libc_cv_gcc___thread" = yes; then
>>>   dnl Check whether the compiler supports the tls_model attribute.
>>>   AC_CACHE_CHECK([for tls_model attribute], libc_cv_gcc_tls_model_attr, [dnl
>>>   cat > conftest.c <<\EOF
>>> extern __thread int a __attribute__((tls_model ("initial-exec")));
>>> EOF
>>>   if AC_TRY_COMMAND([${CC-cc} $CFLAGS $CPPFLAGS -S -Werror conftest.c
>>>> &AS_MESSA
>>> GE_LOG_FD]); then
>>>     libc_cv_gcc_tls_model_attr=yes
>>>   else
>>>     libc_cv_gcc_tls_model_attr=no
>>>   fi
>>>   rm -f conftest*])
>>>   if test "$libc_cv_gcc_tls_model_attr" = yes; then
>>>     AC_DEFINE(HAVE_TLS_MODEL_ATTRIBUTE)
>>>   fi
>>> fi
>>>
>> OK, but for us the question is if we want __thread without initial-exec
>> at all. If not (I think so), I could add -Werror to the __thread test
>> and that should combine both tests into a single one, sufficient for our
>> use case.
> 
> Yes, my point was that if an implementation supports __thread, it does
> not necessarily mean that it supports the tls_model attribute. We should
> fallback to pthread_key if either one is not supported. However, other
> parts of Xenomai skins use pthread_specific, so, if we implement
> something based on __thread, I think we should factor it and use it
> everywhere.

Ack. There are rt_printf (rtdk) and the task-self services of vxworks,
vrtx and native skins. So if I get an OK for the proposal, I'll convert
the rest, too.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

