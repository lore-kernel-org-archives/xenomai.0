Message-ID: <48BE6419.2020706@domain.hid>
Date: Wed, 03 Sep 2008 12:16:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD38364@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD38364@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] native rt_timer questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Fillod Stephane wrote:
> Hi!
> 
> Why rt_timer functions, esp. rt_timer_tsc(), are not inlined in
> user-space 
> (with CONFIG_XENO_HW_DIRECT_TSC) ? Is it because some policy insists 
> that every library function must have an overridable symbol?
> Even a branch is worrisome when doing repetitive micro-measurements.
> What about a patch along the following? or an extern inline?
> 
> --- include/native/timer.h     15 May 2008 07:40:30 -0000
> +++ include/native/timer.h     3 Sep 2008 09:10:31 -0000
> @@ -46,7 +52,7 @@
>  extern "C" {
>  #endif
> -#if (defined(__KERNEL__)  || defined(__XENO_SIM__)) &&
> !defined(DOXYGEN_CPP)
> +#if (defined(__KERNEL__)  || defined(__XENO_SIM__) ||
> defined(__NATIVE_INLINE)) && !defined(DOXYGEN_CPP)
>  static inline SRTIME rt_timer_ns2tsc(SRTIME ns)
>  {
>         return xnarch_ns_to_tsc(ns);

I am afraid we do not want this on every architecture. On ARM where the
tsc is an emulation and contains a fair number of instructions using a
fair number of registers (still faster than a syscall, of course), I
think we do want an out of line function.

> 
> BTW, I had the bad surprise of rt_timer_read() doing a syscall, which
> is costly when doing fine measurement. Should it be documented?

I suggested once to use the tsc as well for the implementation of
clock_gettime(CLOCK_REALTIME) (the posix equivalent of rt_timer_read()),
but was told at the time that we may want, one day, to provide syscalls
to compensate for clock drifts, so reading the system clock should
remain a syscall.

-- 
                                                 Gilles.

