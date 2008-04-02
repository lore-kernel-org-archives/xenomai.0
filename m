Message-ID: <47F3B348.1090102@domain.hid>
Date: Wed, 02 Apr 2008 18:24:40 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>	
	<47F34C0D.6090809@domain.hid> <47F37579.7080601@domain.hid>	
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>
In-Reply-To: <2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

Gilles Chanteperdrix wrote:
> On Wed, Apr 2, 2008 at 5:58 PM, Sebastian Smolorz
> <smolorz@domain.hid> wrote:
>> Jan Kiszka wrote:
>>  > Sebastian Smolorz wrote:
>>  >> Jan Kiszka wrote:
>>  >>> Cornelius K=F6pp wrote:
>>  >>>> I talked with Sebastian Smolorz about this and he builds his own
>>  >>>> independent kernel-config to check. He got the same drifting-eff=
ect
>>  >>>> with Xenomai 2.4.2 and Xenomai 2.4.3 running latency over severa=
l
>>  >>>> hours. His kernel-config ist attached as
>>  >>>> 'config-2.6.24-xenomai-2.4.3__ssm'.
>>  >>>>
>>  >>>> Our kernel-configs are both based on a config used with Xenomai =
2.3.4
>>  >>>> and Linux 2.6.20.15 without any drifting effects.
>>  >>> 2.3.x did not incorporate the new TSC-to-ns conversion. Maybe it =
is
>>  >>> not a PIC vs. APIC thing, but rather a rounding problem of larger=
 TSC
>>  >>> values (that naturally show up when the system runs for a longer =
time).
>>  >> This hint seems to point into the right direction. I tried out a
>>  >> modified pod_32.h (xnarch_tsc_to_ns() commented out) so that the o=
ld
>>  >> implementation in include/asm-generic/bits/pod.h was used. The dri=
fting
>>  >> bug disappeared. So there seems so be a buggy x86-specific
>>  >> implementation of this routine.
>>  >
>>  > Hmm, maybe even a conceptional issue: the multiply-shift-based
>>  > xnarch_tsc_to_ns is not as precise as the still multiply-divide-bas=
ed
>>  > xnarch_ns_to_tsc. So when converting from tsc over ns back to tsc, =
we
>>  > may loose some bits, maybe too many bits...
>>  >
>>  > It looks like this bites us in the kernel latency tests (-t2 should
>>  > suffer as well). Those recalculate their timeouts each round based =
on
>>  > absolute nanoseconds. In contrast, the periodic user mode task of -=
t0
>>  > uses a periodic timer that is forwarded via a tsc-based interval.
>>  >
>>  > You (or Cornelius) could try to analyse the calculation path of the
>>  > involved timeouts, specifically to understand why the scheduled tim=
eout
>>  > of the underlying task timer (which is tsc-based) tend to diverge f=
rom
>>  > the calculated one (ns-based).
>>
>>  So here comes the explanation. The error is inside the function
>>  rthal_llmulshft(). It returns wrong values which are too small - the
>>  higher the given TSC value the bigger the error. The function
>>  rtdm_clock_read_monotonic() calls rthal_llmulshft(). As
>>  rtdm_clock_read_monotonic() is called every time the latency kernel
>>  thread runs [1] the values reported by latency become smaller over ti=
me.
>>
>>  In contrast, the latency task in user space only uses the conversion
>>  from TSC to ns only once when calling rt_timer_inquire [2].
>>  timer_info.date is too small, timer_info.tsc is right. So all calcula=
ted
>>   deltas in [3] are shifted to a smaller value. This value is constant
>>  during the runtime of lateny in user space because no more conversion
>>  from TSC to ns occurs.
>=20
> latency does conversions from tsc to ns, but it converts time
> differences, so the error is small relative to the results.

Of course. I wasn't precise with my last statement. It should be: No=20
more conversions from *absolute* TSC values to ns occur.

--=20
Sebastian

