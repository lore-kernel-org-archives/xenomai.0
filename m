Message-ID: <49FF15ED.1010008@domain.hid>
Date: Mon, 04 May 2009 18:21:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200905041613.30996@domain.hid>
	<200905041614.26154@domain.hid>	<1241446936.26544.324.camel@domain.hid>	<1241447342.26544.329.camel@domain.hid>
	<200905041811.11867@domain.hid>
In-Reply-To: <200905041811.11867@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

Petr Cervenka wrote:
>> Read: it must interrupt Xenomai syscalls internally but the latter 
>> should always be silently restarted, by properly setting the
>> SA_RESTART bit in the sigaction flags for that signal.
>> 
>> Not allowing Linux to interrupt blocking Xenomai syscalls to
>> process pending signals would basically kill GDB support, and
>> beyond this create a very fragile situation wrt signal handling and
>> Xenomai, which is the last thing we would want to do.
>> 
>> Philippe.
>> 
> 
> I have found following problems / errors: 
> -------------------------------------------------------------- 1)
> rtdm_event_timedwait() in ioctl handler is not automatically
> internally restarted (driver: rtdm, app. tasks: native)

That is because rtdm_event_timedwait is not a syscall. It is a
kernel-space call. Your job is to get ioctl to return -EINTR when
rtdm_event_timedwait returns -EINTR, so that ioctl will be restarted in
user-space.

This is undocumented, because you should already know about that if you
have done a little driver work under linux.

> 
> 2) computer hangs, when I call in ioctl handler something like: do { 
> res = rtdm_event_timedwait(&event, timeout, NULL); } while (res ==
> -EINTR); this could have perhaps some relevance:
> https://mail.gna.org/public/xenomai-help/2008-11/msg00025.html

That is because you should return to user-space to get the signal handled.

> 
> 3) rt_event_wait() in application is restarted always with the same
> relative timeout. it could run forever.

Yes, we know that, and we know a fix. But another fix is to use the new
*_until calls.

> 
> problems with version 2.5-rc1: 
> ----------------------------------------------- 1) function
> rt_task_shadow always returns -EFAULT

Could you provide us with a small example which has this problem ?

> 
> 2) when resizing window with latency test running, it prints out "Not
> SIGSHADOW !". But it should be SIGSHADOW (in my opinion).

"Not SIGSHADOW!" is printed when the SIGWINCH signal handler identifies
a SIGWINCH not originating from Xenomai. And when you resize the window,
a SIGWINCH is sent to the application which originates from the Linux
kernel, not from Xenomai. So, the "Not SIGSHADOW!" is correct. However,
it is essentially a debug message

> 
> Petr
> 
> 
> _______________________________________________ Xenomai-help mailing
> list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help


-- 
                                                 Gilles.

