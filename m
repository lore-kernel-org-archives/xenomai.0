Message-ID: <2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>
Date: Wed, 2 Apr 2008 18:05:03 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F3AD14.4090306@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
	<47F34C0D.6090809@domain.hid> <47F37579.7080601@domain.hid>
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

On Wed, Apr 2, 2008 at 5:58 PM, Sebastian Smolorz
<smolorz@domain.hid> wrote:
>
> Jan Kiszka wrote:
>  > Sebastian Smolorz wrote:
>  >> Jan Kiszka wrote:
>  >>> Cornelius K=F6pp wrote:
>  >>>> Hello,
>  >>>> I run the latency test from testsuite on several hard and software
>  >>>> configurations. Running on Xenomai 2.4.2, Linux 2.6.24 the results
>  >>>> shows a "strange" behavior: In Kernel mode (-t1) the latencys
>  >>>> constantly linear decrease. See attached plot
>  >>>> 'drifting_latencys_in_kernelmode.png' of latency test running 48h o=
n
>  >>>> Pentium3 700. This effect could be reproduced, even on other hardwa=
re
>  >>>> (Pentium-M 1400).
>  >>> As our P3 boards did not support APIC-based timing (IIRC), your kern=
el
>  >>> has correctly disabled the related kernel support. But the Pentium M
>  >>> should be fine. So could you check if we are seeing some TSC clocks
>  >>> vs. PIT timer rounding issue by enabling the local APIC on the Penti=
um M?
>  >> There is no difference in enabling the local APIC on the Pentium M WR=
T
>  >> this bug.
>  >>
>  >>>> The usermode (-t0) did not show a drifting, but is influenced by a
>  >>>> test ran in kernelmode before.
>  >>> What do you mean with "is influenced"?
>  >> Cornelius saw the following behaviour: If the latency test was run in
>  >> user space first, no drift appeared over time. If latency was run in
>  >> kernel space (with the reported ngeative drift) a following latency t=
est
>  >> in user space showed also negative values but with no additional drif=
t
>  >> over time.
>
>  Correction: The initial negative drift when starting user mode latency
>  does not depend on a former run of latency in kernel mode but on the
>  time passed between system start and the starting point of latency -t0.
>  Or, as explained below, it depends on the value of the TSC.
>
>
>
>  >>
>  >>>> I talked with Sebastian Smolorz about this and he builds his own
>  >>>> independent kernel-config to check. He got the same drifting-effect
>  >>>> with Xenomai 2.4.2 and Xenomai 2.4.3 running latency over several
>  >>>> hours. His kernel-config ist attached as
>  >>>> 'config-2.6.24-xenomai-2.4.3__ssm'.
>  >>>>
>  >>>> Our kernel-configs are both based on a config used with Xenomai 2.3=
.4
>  >>>> and Linux 2.6.20.15 without any drifting effects.
>  >>> 2.3.x did not incorporate the new TSC-to-ns conversion. Maybe it is
>  >>> not a PIC vs. APIC thing, but rather a rounding problem of larger TS=
C
>  >>> values (that naturally show up when the system runs for a longer tim=
e).
>  >> This hint seems to point into the right direction. I tried out a
>  >> modified pod_32.h (xnarch_tsc_to_ns() commented out) so that the old
>  >> implementation in include/asm-generic/bits/pod.h was used. The drifti=
ng
>  >> bug disappeared. So there seems so be a buggy x86-specific
>  >> implementation of this routine.
>  >
>  > Hmm, maybe even a conceptional issue: the multiply-shift-based
>  > xnarch_tsc_to_ns is not as precise as the still multiply-divide-based
>  > xnarch_ns_to_tsc. So when converting from tsc over ns back to tsc, we
>  > may loose some bits, maybe too many bits...
>  >
>  > It looks like this bites us in the kernel latency tests (-t2 should
>  > suffer as well). Those recalculate their timeouts each round based on
>  > absolute nanoseconds. In contrast, the periodic user mode task of -t0
>  > uses a periodic timer that is forwarded via a tsc-based interval.
>  >
>  > You (or Cornelius) could try to analyse the calculation path of the
>  > involved timeouts, specifically to understand why the scheduled timeou=
t
>  > of the underlying task timer (which is tsc-based) tend to diverge from
>  > the calculated one (ns-based).
>
>  So here comes the explanation. The error is inside the function
>  rthal_llmulshft(). It returns wrong values which are too small - the
>  higher the given TSC value the bigger the error. The function
>  rtdm_clock_read_monotonic() calls rthal_llmulshft(). As
>  rtdm_clock_read_monotonic() is called every time the latency kernel
>  thread runs [1] the values reported by latency become smaller over time.
>
>  In contrast, the latency task in user space only uses the conversion
>  from TSC to ns only once when calling rt_timer_inquire [2].
>  timer_info.date is too small, timer_info.tsc is right. So all calculated
>   deltas in [3] are shifted to a smaller value. This value is constant
>  during the runtime of lateny in user space because no more conversion
>  from TSC to ns occurs.

latency does conversions from tsc to ns, but it converts time
differences, so the error is small relative to the results. In
contrast, doing substractions of conversion results is wrong. In other
words, doing:

start =3D rt_timer_tsc();
stop =3D rt_timer_tsc();
diffns =3D rt_timer_tsc2ns(stop - start);

is right. Whereas doing:

start =3D rt_timer_tsc2ns(rt_timer_tsc());
stop =3D rt_timer_tsc2ns(rt_timer_tsc());
diffns =3D stop - start;

is wrong.


--=20
 Gilles

