Message-ID: <4D49D608.5020006@domain.hid>
Date: Wed, 02 Feb 2011 23:09:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=pm4BfNAwCzw-6HLOiKfJQmgMQdPmVXTcCBSBs@domain.hid>	<4D49CF24.9080700@domain.hid>
	<AANLkTinaTVSJW1jQzn7+jbsQgNE+HAEOXLEK3LC0MoWR@mail.gmail.com>
In-Reply-To: <AANLkTinaTVSJW1jQzn7+jbsQgNE+HAEOXLEK3LC0MoWR@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] I-pipe clock source change and MMC issues (AT91)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai@xenomai.org

at91_enthus wrote:
> 
> 
> On Wed, Feb 2, 2011 at 3:39 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> 
>     at91_enthus wrote:
>     > Hi.
>     >
>     > In order to get better accuracy with Xenomai, I modified the I-pipe
>     > timebase (MCK divider) in arch/arm.mach-at91/at91_ipipe_time.c.
>     > Unfortunately, I cannot mount the rootfs on the MMC, since the MMC
>     > controller is no longer functioning. I tried to change TCx in kernel
>     > configuration to no avail.
>     > When I switch back to a timebase of 1 MHz, the MMC works fine.
> 
>     The thing is that we are a bit tight on AT91. A 16 bits counter is used
>     for both the timer and the tsc emulation, and this tsc must be refreshed
>     at least once before it wraps. The problem is that since it is a 16 bits
>     counter, it wraps really fast, on my AT91SAM9263 it wraps in 20 ms, and
>     since the Linux default period is 10ms we are actually quite close to
>     the limit.
> 
>     Anyway, trying to get a better accuracy than 1us is kind of useless on
>     AT91, since even reading this counter takes more than 1us. So, you are
>     not in fact improving anything. The 1MHz is even a bit overkill.

On the other hand, the AT91SAM9G20 may be running at a better frequency.
But with latencies in the order of tens of microseconds, having a better
accuracy than 1us still does not make really much sense. Why do you need
this accuracy?

-- 
                                                                Gilles.

