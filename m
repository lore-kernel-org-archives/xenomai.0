From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>
References: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 10:22:56 +0200
Message-Id: <1184746976.6562.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Writing from user space direct to IO
	Ports	without mode switches
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Renner Johannes <rennj1@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-07-18 at 00:23 +0200, Renner Johannes wrote:
> Hello everyone,
> 
> The outb functions to control parallel ports in my user mode RT task
> causing inacceptable jitter and make the task unstable(-110) at
> higher(10khz) output frequencies. I believe this is due to mode
> switches form Primary to the Secondary mode.

You can check this by dumping /proc/xenomai/stat periodically when your
task runs. If the "MSW" value increases regularly, then there are indeed
unwanted mode switches.

If so, this looks like an issue with reinstating the iobitmap for the
incoming RT thread; seems strange since we fixed it a while ago, but we
may be impacted by vanilla kernel changes here, so checking this again
is needed. Please send a simple code exhibiting the problem; we need to
know how you get the IOPL, and if you can reproduce it with a simple
periodic thread. Kernel version, Xenomai version and kernel config used
would help too.

> I tried to access the ports via /dev/mem and mmap() (method from
> xenomai/examples/common/hw_direct_io.c) but thus mapping is
> successful, writing -whatever- to the mapped pointer does not set any
> IO's on my x86.

You can't r/w ioports using mmapped memory on x86; those are in a memory
space following a different access logic than plain MMIO. The example
you referred to was written for ppc, and uses an MMIO space.

> I have read that some Xenomai RT testing with the Parallel port at
> frequencies above 200khz showed excellent results. Which functions are
> used for such precise timings and are they only available in kernel
> space?

native skin: rt_timer_tsc(), posix skin: clock_gettime().
Both are usable in kernel and user-space contexts. To have direct access
to the x86 TSC from user-space, you need to make sure your kernel is
compiled for a CPU type providing TSC support (i.e. anything beyond 486
would do). User-space should be built with the --enable-x86-tsc option
too, but this is the default setting if you don't pass any opposite
option to the "configure" script.

> Thanks in advance
> 
> Johannes
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



