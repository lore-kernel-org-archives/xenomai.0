Message-ID: <4F3CD3A6.1090502@domain.hid>
Date: Thu, 16 Feb 2012 11:00:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAJp2OCM=MPSPHR1=ypDLTsRTSFAO0vmATqarw6H3ZyXoNKQ3MA@mail.gmail.com>
In-Reply-To: <CAJp2OCM=MPSPHR1=ypDLTsRTSFAO0vmATqarw6H3ZyXoNKQ3MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High latencies on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alex Nikitenko <alexzoidbergnikitenko@domain.hid>
Cc: xenomai@xenomai.org

On 02/16/2012 10:38 AM, Alex Nikitenko wrote:
> Hi all,
> 
> I continue my struggling with xenomai on Tiny6410 board. Kernel version -
> 2.6.36. Xenomai version is 2.6.0. The problem is actually in very high
> latencies (see log at the end).
> In kernel config I disabled all the stuff I'm not planing to use at the
> moment (touchscreen, video, audio, usb, networking).  I also disabled
> CONFIG_SYS_SUPPORTS_APM_EMULATION.
> 
> Xenomai related configs attached. Just in case I made some mistakes in
> configuring it.
> 
> Please, help me with the ideas what it could be.

Possible reasons:
- look for issues in the timer programming: the timer and clock
frequency may not be what you think they are, or may be too low, the
I-pipe for ARM is mostly tested with clock and timer using the same
frequency, so, there may be an undiscovered issue if timer and clock do
not use the same frequency.
- make sure that __ipipe_tsc_update() is called often enough (at least
once before the hardware counter wraps), if for instance you are using a
16 bits counter at 1 MHz, the wrap time is around 65 ms so, calling
__ipipe_tsc_update() in linux irq handler may not be enough, especially
if dynamic ticks are enabled, you need to call it in __ipipe_mach_acktimer.
- make sure that the idle loop does not enter in a deep sleep state.

Regards.

-- 
					    Gilles.

