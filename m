Subject: Re: Large ToD drift with clocktest
References: <CAB+DZ3nGQgqAg_8Cufkp5q6xB56tL+MnQJoWz_T19-1dpsbMuw@mail.gmail.com>
 <0a1e8d87-16ba-88dc-74b1-406aa9a9a5c0@web.de>
 <CAB+DZ3m2Jv8CyBSoDXdzg8h2jVdfokUc2C46v48NZUcb73p6Vg@mail.gmail.com>
 <1879bc47-218f-8bc0-76f0-657d913a7192@web.de>
 <CAB+DZ3nswGdWZxnQw5ZCL9D80DstYDZ+FxcChfNBpCmevqB-_g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <a84d57bd-2f04-2bdc-63e1-8cdd65ebcac2@web.de>
Date: Thu, 16 May 2019 15:01:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAB+DZ3nswGdWZxnQw5ZCL9D80DstYDZ+FxcChfNBpCmevqB-_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bart Vissers <bvissers@e2mtechnologies.eu>
Cc: xenomai@xenomai.org

On 15.05.19 23:08, Bart Vissers wrote:
> Thanks for the suggestion!
>
> I found that Xenomai 2 uses:
> clockfreq: 2712005000
> cpufreq: 2712005000
> timerfreq: 1499886
>
> And Xenomai 3's default parameters on the same PC:
> clockfreq: 2700000000
> timerfreq: 338999986
>
> When I manually override these parameters with the values of v2, the clo=
ck drift
> is back to normal (< 10 us/s) on v3.
>
> I'm not sure where to go from here. I briefly looked at the cobalt and i=
pipe
> source, but have no experience with kernel development. I'm happy to try=
 patches
> or other suggestions though.
>

What exactly did you tune? The module parameters called like that?

I suspect that clockfreq already makes the difference for you. Please chec=
k.

The kernel part of Xenomai picks up the frequency during init, either from=
 Linux
or the module parameter. If taken from Linux, we are using cpu_khz as inpu=
t [1].
Hmm, I think this should rather be tsc_khz because the latter may undergo =
an
refinement during boot that cpu_khz misses IIRC. You could check that by
replacing that input in [1].

Jan

[1]
https://gitlab.denx.de/Xenomai/ipipe-x86/blob/ipipe-x86-4.14.y/arch/x86/in=
clude/asm/ipipe_base.h#L68

>
> On Tue, 14 May 2019 at 11:24, Jan Kiszka <jan.kiszka@web.de
> <mailto:jan.kiszka@web.de>> wrote:
>
>     On 14.05.19 11:15, Bart Vissers wrote:
>      > Thanks for looking into it!
>      > Actually, we are transitioning from Xenomai 2 to 3 and we're faci=
ng Ethercat
>      > Distributed Clocks (DC) synchronization issues. The old OS with X=
enomai 2 can
>      > run DC in both Master Shift and Bus Shift mode. With the 4.14 ker=
nel and
>     Xenomai
>      > 3, Bus Shift doesn't work due to too much drift wrt to slave cloc=
ks.
>      >
>      > We don't really care about the system time, but I added ntp logs =
because I
>      > thought it might help finding the cause.
>
>     Ok, if the hardware and the kernel configuration are basically the s=
ame for both
>     v2 and v3 setups, we may have a regression regarding the TSC-to-nano=
seconds
>     calculations. Maybe check the parameters Xenomai is using internally=
, if they
>     are differing.
>
>     Jan
>
>      >
>      > Thanks again,
>      > Bart
>      >
>      > On Tue, 14 May 2019 at 09:14, Jan Kiszka <jan.kiszka@web.de
>     <mailto:jan.kiszka@web.de>
>      > <mailto:jan.kiszka@web.de <mailto:jan.kiszka@web.de>>> wrote:
>      >
>      >=C2=A0 =C2=A0 =C2=A0On 13.05.19 18:41, Bart Vissers via Xenomai wr=
ote:
>      >=C2=A0 =C2=A0 =C2=A0 > Hi all,
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > When running clocktest I get the following =
output:
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > $ /usr/xenomai/bin/clocktest
>      >=C2=A0 =C2=A0 =C2=A0 > =3D=3D Testing built-in CLOCK_REALTIME (0)
>      >=C2=A0 =C2=A0 =C2=A0 > CPU=C2=A0 =C2=A0 =C2=A0 ToD offset [us] ToD=
 drift [us/s]=C2=A0 =C2=A0 =C2=A0 warps max delta [us]
>      >=C2=A0 =C2=A0 =C2=A0 > --- -------------------- ---------------- -=
--------- --------------
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1553975.5=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04423.196=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.0
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1553974.2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04423.178=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.0
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > This drift sits constantly at ~4430 us/s.
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > - This happens with Xenomai 3.0.8 x64 (head=
 of the next branch).
>      >=C2=A0 =C2=A0 =C2=A0 > - I've tried 2 Linux kernels, 4.9.146 and 4=
.14.111, both with the same
>      >=C2=A0 =C2=A0 =C2=A0 > result.
>      >=C2=A0 =C2=A0 =C2=A0 > - The Xenomai latency is fine, < 20 us wors=
t case.
>      >=C2=A0 =C2=A0 =C2=A0 > - autotune doesn't have an effect
>      >=C2=A0 =C2=A0 =C2=A0 > - The CPU is an Intel G3930TE (cpu family 6=
 model 158, has flags
>      >=C2=A0 =C2=A0 =C2=A0 > constant_tsc and nonstop_tsc)
>      >=C2=A0 =C2=A0 =C2=A0 > - I followed the recommended kernel setting=
s [1], although maybe I
>     missed
>      >=C2=A0 =C2=A0 =C2=A0 > something. Config is attached.
>      >=C2=A0 =C2=A0 =C2=A0 > - tried other clocksources as well, hpet ga=
ve the same result and
>     acpi_pm
>      >=C2=A0 =C2=A0 =C2=A0 > was worse (also >4000 us/s but increasing)
>      >=C2=A0 =C2=A0 =C2=A0 > - checked BIOS settings, disabled Intel Spe=
edstep, Legacy USB support.
>      >=C2=A0 =C2=A0 =C2=A0 > - An old RT configuration (Linux 3.2.21, Xe=
nomai 2.6.3) does not
>     have this
>      >=C2=A0 =C2=A0 =C2=A0 > issue on the same hardware.
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0I did notice that the tsc clock=
source refined calibration seems off
>      >=C2=A0 =C2=A0 =C2=A0 > (2711.995 MHz for a 2700 MHz CPU), see the =
dmesg output below.
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0The ratio 11.995 /2700 =3D 0.00=
444, which corresponds to the drift
>     measured
>      >=C2=A0 =C2=A0 =C2=A0 > by the clocktest but this might be a coinci=
dence.
>      >=C2=A0 =C2=A0 =C2=A0 > I couldn't find a way to disable or correct=
 this.
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0$ dmesg
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 0.000000] tsc: Detected 2700=
.000 MHz processor
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 0.000000] clocksource: refin=
ed-jiffies: mask: 0xffffffff
>     max_cycles:
>      >=C2=A0 =C2=A0 =C2=A0 > 0xffffffff, max_idle_ns: 7645519600211568 n=
s
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 0.000000] clocksource: hpet:=
 mask: 0xffffffff max_cycles:
>     0xffffffff,
>      >=C2=A0 =C2=A0 =C2=A0 > max_idle_ns: 79635855245 ns
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 0.000000] hpet clockevent re=
gistered
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 0.094337] clocksource: jiffi=
es: mask: 0xffffffff max_cycles:
>      >=C2=A0 =C2=A0 =C2=A0 > 0xffffffff, max_idle_ns: 7645041785100000 n=
s
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 0.217908] clocksource: Switc=
hed to clocksource hpet
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 0.238110] clocksource: acpi_=
pm: mask: 0xffffff max_cycles:
>     0xffffff,
>      >=C2=A0 =C2=A0 =C2=A0 > max_idle_ns: 2085701024 ns
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 1.537963] tsc: Refined TSC c=
locksource calibration: 2711.995 MHz
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 1.538279] clocksource: tsc: =
mask: 0xffffffffffffffff max_cycles:
>      >=C2=A0 =C2=A0 =C2=A0 > 0x271781b5003, max_idle_ns: 440795202126 ns
>      >=C2=A0 =C2=A0 =C2=A0 > [=C2=A0 =C2=A0 2.571532] clocksource: Switc=
hed to clocksource tsc
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > There were some kernel bugs in this area, b=
ut they seem fixed
>     already [2,
>      >=C2=A0 =C2=A0 =C2=A0 > 3].
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > I did figure out that I can manipulate the =
drift with adjtimex [4]
>      >=C2=A0 =C2=A0 =C2=A0 > $ adjtimex --tick 10044
>      >=C2=A0 =C2=A0 =C2=A0 > $ /usr/xenomai/bin/clocktest
>      >=C2=A0 =C2=A0 =C2=A0 > =3D=3D Testing built-in CLOCK_REALTIME (0)
>      >=C2=A0 =C2=A0 =C2=A0 > CPU=C2=A0 =C2=A0 =C2=A0 ToD offset [us] ToD=
 drift [us/s]=C2=A0 =C2=A0 =C2=A0 warps max delta [us]
>      >=C2=A0 =C2=A0 =C2=A0 > --- -------------------- ---------------- -=
--------- --------------
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A012427309.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A044.203=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0.0
>      >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A012427309.3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A044.335=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0.0
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > However, this makes up the system clock dri=
ft. When ntp is
>     enabled, I'm
>      >=C2=A0 =C2=A0 =C2=A0 > seeing an increasing offset wrt time server=
s and when it syncs the
>     clock
>      >=C2=A0 =C2=A0 =C2=A0 > drift increases again.
>      >=C2=A0 =C2=A0 =C2=A0 > I also get the following error in syslog:
>      >=C2=A0 =C2=A0 =C2=A0 > ntpd[10721]: kernel reports TIME_ERROR: 0x4=
1: Clock Unsynchronized
>      >=C2=A0 =C2=A0 =C2=A0 > ntpd[10721]: frequency error -3886 PPM exce=
eds tolerance 500 PPM
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > So that doesn't seem to be a proper solutio=
n.
>      >=C2=A0 =C2=A0 =C2=A0 >
>      >=C2=A0 =C2=A0 =C2=A0 > What can I try next? Any suggestions for fi=
xing this are greatly
>      >=C2=A0 =C2=A0 =C2=A0 > appreciated!
>      >
>      >=C2=A0 =C2=A0 =C2=A0If you want timestamps to be in sync with the =
Linux clock, use
>      >=C2=A0 =C2=A0 =C2=A0CLOCK_HOST_REALTIME. The Xenomai CLOCK_REALTIM=
E and CLOCK_MONOTONIC
>     are not
>      >=C2=A0 =C2=A0 =C2=A0designed to achieve that.
>      >
>      >=C2=A0 =C2=A0 =C2=A0Jan
>      >
>


