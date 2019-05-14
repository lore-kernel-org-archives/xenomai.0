Subject: Re: Large ToD drift with clocktest
References: <CAB+DZ3nGQgqAg_8Cufkp5q6xB56tL+MnQJoWz_T19-1dpsbMuw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <0a1e8d87-16ba-88dc-74b1-406aa9a9a5c0@web.de>
Date: Tue, 14 May 2019 09:14:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAB+DZ3nGQgqAg_8Cufkp5q6xB56tL+MnQJoWz_T19-1dpsbMuw@mail.gmail.com>
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
To: Bart Vissers <bvissers@e2mtechnologies.eu>, xenomai@xenomai.org

On 13.05.19 18:41, Bart Vissers via Xenomai wrote:
> Hi all,
>
> When running clocktest I get the following output:
>
> $ /usr/xenomai/bin/clocktest
> =3D=3D Testing built-in CLOCK_REALTIME (0)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>    0            1553975.5         4423.196          0            0.0
>    1            1553974.2         4423.178          0            0.0
>
> This drift sits constantly at ~4430 us/s.
>
> - This happens with Xenomai 3.0.8 x64 (head of the next branch).
> - I've tried 2 Linux kernels, 4.9.146 and 4.14.111, both with the same
> result.
> - The Xenomai latency is fine, < 20 us worst case.
> - autotune doesn't have an effect
> - The CPU is an Intel G3930TE (cpu family 6 model 158, has flags
> constant_tsc and nonstop_tsc)
> - I followed the recommended kernel settings [1], although maybe I misse=
d
> something. Config is attached.
> - tried other clocksources as well, hpet gave the same result and  acpi_=
pm
> was worse (also >4000 us/s but increasing)
> - checked BIOS settings, disabled Intel Speedstep, Legacy USB support.
> - An old RT configuration (Linux 3.2.21, Xenomai 2.6.3) does not have th=
is
> issue on the same hardware.
>
>   I did notice that the tsc clocksource refined calibration seems off
> (2711.995 MHz for a 2700 MHz CPU), see the dmesg output below.
>   The ratio 11.995 /2700 =3D 0.00444, which corresponds to the drift mea=
sured
> by the clocktest but this might be a coincidence.
> I couldn't find a way to disable or correct this.
>   $ dmesg
> [    0.000000] tsc: Detected 2700.000 MHz processor
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles=
:
> 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xfffffff=
f,
> max_idle_ns: 79635855245 ns
> [    0.000000] hpet clockevent registered
> [    0.094337] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.217908] clocksource: Switched to clocksource hpet
> [    0.238110] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff=
,
> max_idle_ns: 2085701024 ns
> [    1.537963] tsc: Refined TSC clocksource calibration: 2711.995 MHz
> [    1.538279] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
> 0x271781b5003, max_idle_ns: 440795202126 ns
> [    2.571532] clocksource: Switched to clocksource tsc
>
> There were some kernel bugs in this area, but they seem fixed already [2=
,
> 3].
>
> I did figure out that I can manipulate the drift with adjtimex [4]
> $ adjtimex --tick 10044
> $ /usr/xenomai/bin/clocktest
> =3D=3D Testing built-in CLOCK_REALTIME (0)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>    0           12427309.1           44.203          0            0.0
>    1           12427309.3           44.335          0            0.0
>
> However, this makes up the system clock drift. When ntp is enabled, I'm
> seeing an increasing offset wrt time servers and when it syncs the clock
> drift increases again.
> I also get the following error in syslog:
> ntpd[10721]: kernel reports TIME_ERROR: 0x41: Clock Unsynchronized
> ntpd[10721]: frequency error -3886 PPM exceeds tolerance 500 PPM
>
> So that doesn't seem to be a proper solution.
>
> What can I try next? Any suggestions for fixing this are greatly
> appreciated!

If you want timestamps to be in sync with the Linux clock, use
CLOCK_HOST_REALTIME. The Xenomai CLOCK_REALTIME and CLOCK_MONOTONIC are no=
t
designed to achieve that.

Jan

