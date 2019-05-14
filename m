Subject: Re: Large ToD drift with clocktest
References: <CAB+DZ3nGQgqAg_8Cufkp5q6xB56tL+MnQJoWz_T19-1dpsbMuw@mail.gmail.com>
 <0a1e8d87-16ba-88dc-74b1-406aa9a9a5c0@web.de>
 <CAB+DZ3m2Jv8CyBSoDXdzg8h2jVdfokUc2C46v48NZUcb73p6Vg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <1879bc47-218f-8bc0-76f0-657d913a7192@web.de>
Date: Tue, 14 May 2019 11:24:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAB+DZ3m2Jv8CyBSoDXdzg8h2jVdfokUc2C46v48NZUcb73p6Vg@mail.gmail.com>
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

On 14.05.19 11:15, Bart Vissers wrote:
> Thanks for looking into it!
> Actually, we are transitioning from Xenomai 2 to 3 and we're facing Ethe=
rcat
> Distributed Clocks (DC) synchronization issues. The old OS with Xenomai =
2 can
> run DC in both Master Shift and Bus Shift mode. With the 4.14 kernel and=
 Xenomai
> 3, Bus Shift doesn't work due to too much drift wrt to slave clocks.
>
> We don't really care about the system time, but I added ntp logs because=
 I
> thought it might help finding the cause.

Ok, if the hardware and the kernel configuration are basically the same fo=
r both
v2 and v3 setups, we may have a regression regarding the TSC-to-nanosecond=
s
calculations. Maybe check the parameters Xenomai is using internally, if t=
hey
are differing.

Jan

>
> Thanks again,
> Bart
>
> On Tue, 14 May 2019 at 09:14, Jan Kiszka <jan.kiszka@web.de
> <mailto:jan.kiszka@web.de>> wrote:
>
>     On 13.05.19 18:41, Bart Vissers via Xenomai wrote:
>      > Hi all,
>      >
>      > When running clocktest I get the following output:
>      >
>      > $ /usr/xenomai/bin/clocktest
>      > =3D=3D Testing built-in CLOCK_REALTIME (0)
>      > CPU=C2=A0 =C2=A0 =C2=A0 ToD offset [us] ToD drift [us/s]=C2=A0 =
=C2=A0 =C2=A0 warps max delta [us]
>      > --- -------------------- ---------------- ---------- ------------=
--
>      >=C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1553975.5=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04423.196=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.0
>      >=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1553974.2=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04423.178=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.0
>      >
>      > This drift sits constantly at ~4430 us/s.
>      >
>      > - This happens with Xenomai 3.0.8 x64 (head of the next branch).
>      > - I've tried 2 Linux kernels, 4.9.146 and 4.14.111, both with the=
 same
>      > result.
>      > - The Xenomai latency is fine, < 20 us worst case.
>      > - autotune doesn't have an effect
>      > - The CPU is an Intel G3930TE (cpu family 6 model 158, has flags
>      > constant_tsc and nonstop_tsc)
>      > - I followed the recommended kernel settings [1], although maybe =
I missed
>      > something. Config is attached.
>      > - tried other clocksources as well, hpet gave the same result and=
=C2=A0 acpi_pm
>      > was worse (also >4000 us/s but increasing)
>      > - checked BIOS settings, disabled Intel Speedstep, Legacy USB sup=
port.
>      > - An old RT configuration (Linux 3.2.21, Xenomai 2.6.3) does not =
have this
>      > issue on the same hardware.
>      >
>      >=C2=A0 =C2=A0I did notice that the tsc clocksource refined calibra=
tion seems off
>      > (2711.995 MHz for a 2700 MHz CPU), see the dmesg output below.
>      >=C2=A0 =C2=A0The ratio 11.995 /2700 =3D 0.00444, which corresponds=
 to the drift measured
>      > by the clocktest but this might be a coincidence.
>      > I couldn't find a way to disable or correct this.
>      >=C2=A0 =C2=A0$ dmesg
>      > [=C2=A0 =C2=A0 0.000000] tsc: Detected 2700.000 MHz processor
>      > [=C2=A0 =C2=A0 0.000000] clocksource: refined-jiffies: mask: 0xff=
ffffff max_cycles:
>      > 0xffffffff, max_idle_ns: 7645519600211568 ns
>      > [=C2=A0 =C2=A0 0.000000] clocksource: hpet: mask: 0xffffffff max_=
cycles: 0xffffffff,
>      > max_idle_ns: 79635855245 ns
>      > [=C2=A0 =C2=A0 0.000000] hpet clockevent registered
>      > [=C2=A0 =C2=A0 0.094337] clocksource: jiffies: mask: 0xffffffff m=
ax_cycles:
>      > 0xffffffff, max_idle_ns: 7645041785100000 ns
>      > [=C2=A0 =C2=A0 0.217908] clocksource: Switched to clocksource hpe=
t
>      > [=C2=A0 =C2=A0 0.238110] clocksource: acpi_pm: mask: 0xffffff max=
_cycles: 0xffffff,
>      > max_idle_ns: 2085701024 ns
>      > [=C2=A0 =C2=A0 1.537963] tsc: Refined TSC clocksource calibration=
: 2711.995 MHz
>      > [=C2=A0 =C2=A0 1.538279] clocksource: tsc: mask: 0xffffffffffffff=
ff max_cycles:
>      > 0x271781b5003, max_idle_ns: 440795202126 ns
>      > [=C2=A0 =C2=A0 2.571532] clocksource: Switched to clocksource tsc
>      >
>      > There were some kernel bugs in this area, but they seem fixed alr=
eady [2,
>      > 3].
>      >
>      > I did figure out that I can manipulate the drift with adjtimex [4=
]
>      > $ adjtimex --tick 10044
>      > $ /usr/xenomai/bin/clocktest
>      > =3D=3D Testing built-in CLOCK_REALTIME (0)
>      > CPU=C2=A0 =C2=A0 =C2=A0 ToD offset [us] ToD drift [us/s]=C2=A0 =
=C2=A0 =C2=A0 warps max delta [us]
>      > --- -------------------- ---------------- ---------- ------------=
--
>      >=C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A012427309.1=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A044.203=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.0
>      >=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A012427309.3=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A044.335=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.0
>      >
>      > However, this makes up the system clock drift. When ntp is enable=
d, I'm
>      > seeing an increasing offset wrt time servers and when it syncs th=
e clock
>      > drift increases again.
>      > I also get the following error in syslog:
>      > ntpd[10721]: kernel reports TIME_ERROR: 0x41: Clock Unsynchronize=
d
>      > ntpd[10721]: frequency error -3886 PPM exceeds tolerance 500 PPM
>      >
>      > So that doesn't seem to be a proper solution.
>      >
>      > What can I try next? Any suggestions for fixing this are greatly
>      > appreciated!
>
>     If you want timestamps to be in sync with the Linux clock, use
>     CLOCK_HOST_REALTIME. The Xenomai CLOCK_REALTIME and CLOCK_MONOTONIC =
are not
>     designed to achieve that.
>
>     Jan
>


