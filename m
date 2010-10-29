Message-ID: <4CCB4573.30607@domain.hid>
Date: Sat, 30 Oct 2010 00:06:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinQotwe=EwATsmdKnanN-ZwT8c+CobzBRDqptEj@domain.hid>
In-Reply-To: <AANLkTinQotwe=EwATsmdKnanN-ZwT8c+CobzBRDqptEj@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High resolution timers disabled on AT91SAM9G20
 board	after patching
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai@xenomai.org

at91_enthus wrote:
> Hi!
> 
> I installed the latest xenomai patch on a AT91SAM9G20 board and
> everything looked good at a first glance: no compilation problems, low
> latencies.
> 
> However, when I typed cat /proc/timer_list , the resolutions in  cpu0
> and cpu1 items showed 100000 (ns).
> (I compiled the Xenomai patched kernel with High Resolution Timers enabled.)
> 
> I don't have this problem when I boot a real time kernel (RT_PREEMPT).

You mean another real-time kernel? If RT_PREEMPT uses the sys timer
running at 32kHz, and it tells you that it has a 1ns resolution, then it
is lying, because 32kHz, means a 30us resolution.

Xenomai uses one TC as a timer at whatever frequency your chip proposes
over 1 MHz, this means a resolution below 1us, the downside is that this
also means a very short wrap time. And since the TC is also used as a
clock, this means that we must enter the timer interrupt handler before
the counter wraps. And this is something that Linux without Xenomai
running can not guarantee.

Do you have this issue when running a Xenomai application?

Also note that if you use Xenomai timing services, you will not have
this issue, of course.

>
> One more thing. I also have a Beagleboard that runs a Xenomai patched
> kernel and in this case the resolution for HRT shows 1 ns, as it should.
>

If you read a bit more about the I-pipe patch for ARM, you will learn
that the timer implementation is specific to each SOC. So, comparing the
OMAP3530 to the AT91SAM9G20 is as much relevant as comparing the timer
of an X86 to the timer of a PowerPC.

-- 
                                                                Gilles.

