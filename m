Message-ID: <4F2C5406.8020907@domain.hid>
Date: Fri, 03 Feb 2012 22:39:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAF_dkJCxiyMmQaK9w_udT-pR2vR8-rzEJDtzFD80bMh=U+entw@domain.hid>
	<4F2C5031.2080409@domain.hid>
	<CAF_dkJB+NeaX5QK=xHhNU7Oe0TYM8im_XFwzym22UxJBJ2KWrA@mail.gmail.com>
In-Reply-To: <CAF_dkJB+NeaX5QK=xHhNU7Oe0TYM8im_XFwzym22UxJBJ2KWrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Get current wallclock time from RT task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick Doyle <wpdster@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 02/03/2012 10:33 PM, Patrick Doyle wrote:
> On Fri, Feb 3, 2012 at 4:22 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 02/03/2012 09:07 PM, Patrick Doyle wrote:
>>> What is the easiest way to determine the current wallclock time from
>>> within an RT task?
>>>
>>> I see that I can call rt_timer_inquire() and get back an RT_TIMER_INFO
>>> structure containing an RTIME type field labeled "date" and a very
>>> promising comment "Current wallclock time".
>>>
>>> But how do I convert that to e.g. something I could pass to ctime() to
>>> get something reasonably close to the current wallclock time?
>>
>> You need to divide it by one billion. But for the result to be
>> reasonably accurate, you should either:
>> - compile xenomai as module
>> - or having synchronized xenomai clock with linux clock at some earlier
>> point in time by calling timer_settime(CLOCK_REALTIME) (from posix skin).
>>
>> If your architecture supports it you may also use
>> clock_gettime(CLOCK_HOST_REALTIME) then you will get a result with very
>> good accuracy possibly without even a syscall.
> 
> Hmmm...
> Is there any way to do this without using the posix skin?
> We are currently using the native skin quite happily, and I'm somewhat
> concerned that pulling in the posix skin (if it's even possible to mix
> and match skins) will lead to more problems than it will solve.

There is should be no problem mixing the skins.

> 
> How accurate is "unreasonably" accurate?  Accurate to within a second
> or so since we last booted should be plenty accurate for what I need
> this for.

The problem is that xenomai clock is synchronized with linux clock when
xenomai starts. When xenomai is build statically with the kernel, this
happens before linux clock is set with hwclock or ntp, so, xenomai clock
is completely off.

Anyway, you can create a binary using the posix skin which does just:

__real_clock_gettime(CLOCK_REALTIME, &ts);
clock_settime(CLOCK_REALTIME, &ts);

and launch it in an init script after Linux clock has been synchronized
with whatever clock you use.

> 
> --wpd
> 


-- 
                                                                Gilles.

