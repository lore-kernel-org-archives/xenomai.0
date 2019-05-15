MIME-Version: 1.0
References: <CAB+DZ3nGQgqAg_8Cufkp5q6xB56tL+MnQJoWz_T19-1dpsbMuw@mail.gmail.com>
 <0a1e8d87-16ba-88dc-74b1-406aa9a9a5c0@web.de>
 <CAB+DZ3m2Jv8CyBSoDXdzg8h2jVdfokUc2C46v48NZUcb73p6Vg@mail.gmail.com>
 <1879bc47-218f-8bc0-76f0-657d913a7192@web.de>
In-Reply-To: <1879bc47-218f-8bc0-76f0-657d913a7192@web.de>
From: Bart Vissers <bvissers@e2mtechnologies.eu>
Date: Wed, 15 May 2019 23:08:49 +0200
Message-ID: <CAB+DZ3nswGdWZxnQw5ZCL9D80DstYDZ+FxcChfNBpCmevqB-_g@mail.gmail.com>
Subject: Re: Large ToD drift with clocktest
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

Thanks for the suggestion!

I found that Xenomai 2 uses:
clockfreq: 2712005000
cpufreq: 2712005000
timerfreq: 1499886

And Xenomai 3's default parameters on the same PC:
clockfreq: 2700000000
timerfreq: 338999986

When I manually override these parameters with the values of v2, the clock
drift is back to normal (< 10 us/s) on v3.

I'm not sure where to go from here. I briefly looked at the cobalt and
ipipe source, but have no experience with kernel development. I'm happy to
try patches or other suggestions though.


On Tue, 14 May 2019 at 11:24, Jan Kiszka <jan.kiszka@web.de> wrote:

> On 14.05.19 11:15, Bart Vissers wrote:
> > Thanks for looking into it!
> > Actually, we are transitioning from Xenomai 2 to 3 and we're facing
> Ethercat
> > Distributed Clocks (DC) synchronization issues. The old OS with Xenomai
> 2 can
> > run DC in both Master Shift and Bus Shift mode. With the 4.14 kernel and
> Xenomai
> > 3, Bus Shift doesn't work due to too much drift wrt to slave clocks.
> >
> > We don't really care about the system time, but I added ntp logs because
> I
> > thought it might help finding the cause.
>
> Ok, if the hardware and the kernel configuration are basically the same
> for both
> v2 and v3 setups, we may have a regression regarding the TSC-to-nanoseconds
> calculations. Maybe check the parameters Xenomai is using internally, if
> they
> are differing.
>
> Jan
>
> >
> > Thanks again,
> > Bart
> >
> > On Tue, 14 May 2019 at 09:14, Jan Kiszka <jan.kiszka@web.de
> > <mailto:jan.kiszka@web.de>> wrote:
> >
> >     On 13.05.19 18:41, Bart Vissers via Xenomai wrote:
> >      > Hi all,
> >      >
> >      > When running clocktest I get the following output:
> >      >
> >      > $ /usr/xenomai/bin/clocktest
> >      > == Testing built-in CLOCK_REALTIME (0)
> >      > CPU      ToD offset [us] ToD drift [us/s]      warps max delta
> [us]
> >      > --- -------------------- ---------------- ----------
> --------------
> >      >    0            1553975.5         4423.196          0
> 0.0
> >      >    1            1553974.2         4423.178          0
> 0.0
> >      >
> >      > This drift sits constantly at ~4430 us/s.
> >      >
> >      > - This happens with Xenomai 3.0.8 x64 (head of the next branch).
> >      > - I've tried 2 Linux kernels, 4.9.146 and 4.14.111, both with the
> same
> >      > result.
> >      > - The Xenomai latency is fine, < 20 us worst case.
> >      > - autotune doesn't have an effect
> >      > - The CPU is an Intel G3930TE (cpu family 6 model 158, has flags
> >      > constant_tsc and nonstop_tsc)
> >      > - I followed the recommended kernel settings [1], although maybe
> I missed
> >      > something. Config is attached.
> >      > - tried other clocksources as well, hpet gave the same result
> and  acpi_pm
> >      > was worse (also >4000 us/s but increasing)
> >      > - checked BIOS settings, disabled Intel Speedstep, Legacy USB
> support.
> >      > - An old RT configuration (Linux 3.2.21, Xenomai 2.6.3) does not
> have this
> >      > issue on the same hardware.
> >      >
> >      >   I did notice that the tsc clocksource refined calibration seems
> off
> >      > (2711.995 MHz for a 2700 MHz CPU), see the dmesg output below.
> >      >   The ratio 11.995 /2700 = 0.00444, which corresponds to the
> drift measured
> >      > by the clocktest but this might be a coincidence.
> >      > I couldn't find a way to disable or correct this.
> >      >   $ dmesg
> >      > [    0.000000] tsc: Detected 2700.000 MHz processor
> >      > [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
> max_cycles:
> >      > 0xffffffff, max_idle_ns: 7645519600211568 ns
> >      > [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
> 0xffffffff,
> >      > max_idle_ns: 79635855245 ns
> >      > [    0.000000] hpet clockevent registered
> >      > [    0.094337] clocksource: jiffies: mask: 0xffffffff max_cycles:
> >      > 0xffffffff, max_idle_ns: 7645041785100000 ns
> >      > [    0.217908] clocksource: Switched to clocksource hpet
> >      > [    0.238110] clocksource: acpi_pm: mask: 0xffffff max_cycles:
> 0xffffff,
> >      > max_idle_ns: 2085701024 ns
> >      > [    1.537963] tsc: Refined TSC clocksource calibration: 2711.995
> MHz
> >      > [    1.538279] clocksource: tsc: mask: 0xffffffffffffffff
> max_cycles:
> >      > 0x271781b5003, max_idle_ns: 440795202126 ns
> >      > [    2.571532] clocksource: Switched to clocksource tsc
> >      >
> >      > There were some kernel bugs in this area, but they seem fixed
> already [2,
> >      > 3].
> >      >
> >      > I did figure out that I can manipulate the drift with adjtimex [4]
> >      > $ adjtimex --tick 10044
> >      > $ /usr/xenomai/bin/clocktest
> >      > == Testing built-in CLOCK_REALTIME (0)
> >      > CPU      ToD offset [us] ToD drift [us/s]      warps max delta
> [us]
> >      > --- -------------------- ---------------- ----------
> --------------
> >      >    0           12427309.1           44.203          0
> 0.0
> >      >    1           12427309.3           44.335          0
> 0.0
> >      >
> >      > However, this makes up the system clock drift. When ntp is
> enabled, I'm
> >      > seeing an increasing offset wrt time servers and when it syncs
> the clock
> >      > drift increases again.
> >      > I also get the following error in syslog:
> >      > ntpd[10721]: kernel reports TIME_ERROR: 0x41: Clock Unsynchronized
> >      > ntpd[10721]: frequency error -3886 PPM exceeds tolerance 500 PPM
> >      >
> >      > So that doesn't seem to be a proper solution.
> >      >
> >      > What can I try next? Any suggestions for fixing this are greatly
> >      > appreciated!
> >
> >     If you want timestamps to be in sync with the Linux clock, use
> >     CLOCK_HOST_REALTIME. The Xenomai CLOCK_REALTIME and CLOCK_MONOTONIC
> are not
> >     designed to achieve that.
> >
> >     Jan
> >
>
>
