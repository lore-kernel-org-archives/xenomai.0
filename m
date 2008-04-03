Message-ID: <2ff1a98a0804030552k562e58d1v5b010b5cc359f699@domain.hid>
Date: Thu, 3 Apr 2008 14:52:51 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F4D29F.4020500@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
	<47F34C0D.6090809@domain.hid> <47F37579.7080601@domain.hid>
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>
	<2ff1a98a0804030527r5d41efafg4aa6a464373711cc@domain.hid>
	<47F4D29F.4020500@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

On Thu, Apr 3, 2008 at 2:50 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
>
> > On Thu, Apr 3, 2008 at 2:17 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >
> > > Sebastian Smolorz wrote:
> > >
> > >
> > > > Gilles Chanteperdrix wrote:
> > > >
> > > >
> > > > > On Wed, Apr 2, 2008 at 5:58 PM, Sebastian Smolorz
> > > > > <smolorz@domain.hid> wrote:
> > > > >
> > > > >
> > > > > > Jan Kiszka wrote:
> > > > > >  > Sebastian Smolorz wrote:
> > > > > >  >> Jan Kiszka wrote:
> > > > > >  >>> Cornelius K=F6pp wrote:
> > > > > >  >>>> I talked with Sebastian Smolorz about this and he builds =
his
> own
> > > > > >  >>>> independent kernel-config to check. He got the same
> > > > > >
> > > > >
> > > >
> > > drifting-effect
> > >
> > > >
> > > > >
> > > > > >  >>>> with Xenomai 2.4.2 and Xenomai 2.4.3 running latency over
> > > > > >
> > > > >
> > > >
> > > several
> > >
> > > >
> > > > >
> > > > > >  >>>> hours. His kernel-config ist attached as
> > > > > >  >>>> 'config-2.6.24-xenomai-2.4.3__ssm'.
> > > > > >  >>>>
> > > > > >  >>>> Our kernel-configs are both based on a config used with
> Xenomai
> > > > > >
> > > > >
> > > >
> > > 2.3.4
> > >
> > > >
> > > > >
> > > > > >  >>>> and Linux 2.6.20.15 without any drifting effects.
> > > > > >  >>> 2.3.x did not incorporate the new TSC-to-ns conversion. Ma=
ybe
> it
> > > > > >
> > > > >
> > > >
> > > is
> > >
> > > >
> > > > >
> > > > > >  >>> not a PIC vs. APIC thing, but rather a rounding problem of
> larger
> > > > > >
> > > > >
> > > >
> > > TSC
> > >
> > > >
> > > > >
> > > > > >  >>> values (that naturally show up when the system runs for a
> longer
> > > > > >
> > > > >
> > > >
> > > time).
> > >
> > > >
> > > > >
> > > > > >  >> This hint seems to point into the right direction. I tried =
out
> a
> > > > > >  >> modified pod_32.h (xnarch_tsc_to_ns() commented out) so tha=
t
> the
> > > > > >
> > > > >
> > > >
> > > old
> > >
> > > >
> > > > >
> > > > > >  >> implementation in include/asm-generic/bits/pod.h was used. =
The
> > > > > >
> > > > >
> > > >
> > > drifting
> > >
> > > >
> > > > >
> > > > > >  >> bug disappeared. So there seems so be a buggy x86-specific
> > > > > >  >> implementation of this routine.
> > > > > >  >
> > > > > >  > Hmm, maybe even a conceptional issue: the multiply-shift-bas=
ed
> > > > > >  > xnarch_tsc_to_ns is not as precise as the still
> > > > > >
> > > > >
> > > >
> > > multiply-divide-based
> > >
> > > >
> > > > >
> > > > > >  > xnarch_ns_to_tsc. So when converting from tsc over ns back t=
o
> tsc,
> > > > > >
> > > > >
> > > >
> > > we
> > >
> > > >
> > > > >
> > > > > >  > may loose some bits, maybe too many bits...
> > > > > >  >
> > > > > >  > It looks like this bites us in the kernel latency tests (-t2
> should
> > > > > >  > suffer as well). Those recalculate their timeouts each round
> based
> > > > > >
> > > > >
> > > >
> > > on
> > >
> > > >
> > > > >
> > > > > >  > absolute nanoseconds. In contrast, the periodic user mode ta=
sk
> of
> > > > > >
> > > > >
> > > >
> > > -t0
> > >
> > > >
> > > > >
> > > > > >  > uses a periodic timer that is forwarded via a tsc-based
> interval.
> > > > > >  >
> > > > > >  > You (or Cornelius) could try to analyse the calculation path=
 of
> the
> > > > > >  > involved timeouts, specifically to understand why the schedu=
led
> > > > > >
> > > > >
> > > >
> > > timeout
> > >
> > > >
> > > > >
> > > > > >  > of the underlying task timer (which is tsc-based) tend to
> diverge
> > > > > >
> > > > >
> > > >
> > > from
> > >
> > > >
> > > > >
> > > > > >  > the calculated one (ns-based).
> > > > > >
> > > > > >  So here comes the explanation. The error is inside the functio=
n
> > > > > >  rthal_llmulshft(). It returns wrong values which are too small=
 -
> the
> > > > > >  higher the given TSC value the bigger the error. The function
> > > > > >  rtdm_clock_read_monotonic() calls rthal_llmulshft(). As
> > > > > >  rtdm_clock_read_monotonic() is called every time the latency
> kernel
> > > > > >  thread runs [1] the values reported by latency become smaller
> over
> > > > > >
> > > > >
> > > >
> > > time.
> > >
> > > >
> > > > >
> > > > > >  In contrast, the latency task in user space only uses the
> conversion
> > > > > >  from TSC to ns only once when calling rt_timer_inquire [2].
> > > > > >  timer_info.date is too small, timer_info.tsc is right. So all
> > > > > >
> > > > >
> > > >
> > > calculated
> > >
> > > >
> > > > >
> > > > > >  deltas in [3] are shifted to a smaller value. This value is
> constant
> > > > > >  during the runtime of lateny in user space because no more
> conversion
> > > > > >  from TSC to ns occurs.
> > > > > >
> > > > > >
> > > > > latency does conversions from tsc to ns, but it converts time
> > > > > differences, so the error is small relative to the results.
> > > > >
> > > > >
> > > > Of course. I wasn't precise with my last statement. It should be: N=
o
> more
> > > >
> > > conversions from *absolute* TSC values to ns occur.
> > >
> > > >
> > > >
> > >  This patch may do the trick: it uses the inverted tsc-to-ns function
> > > instead of the frequency-based one. Be warned, it is totally untested
> inside
> > > Xenomai, I just ran it in a user space test program. But it may give =
an
> > > idea.
> > >
> > >  Gilles, not sure if this is related to my quickly hacked test, but w=
ith
> > > RTHAL_CPU_FREQ =3D 800MHz and TSC =3D 0x7000000000000000 (or larger) =
I get
> an
> > > arithmetic exception with the rthal_llimd-based conversion to
> nanoseconds.
> > > Is there an input range we may have to exclude for rthal_llimd?
> > >
> >
> > rthal_llimd does a multiplication first, then a division. The
> > multiplication can not overflow, but the result of the division may
> > not fit on 64 bits, you then get an exception on x86. This happens
> > only with m > d.
> >
>
>  OK, for tsc-to-ns this only bites us after a few hundred years of uptime=
 -
> or when we have settable tsc counters (does Linux tweak them beyond align=
ing
> on SMP?).
>
>  But there is also the risk the other way around: ns-to-tsc with frequenc=
y >
> 1GHz will fall apart (kernel oops!) when the user provides a large timeou=
t
> in nanoseconds that we then try to convert to tsc. Not good. Wrong values
> are one thing, but oopses are even worse.
>
>  Any idea how to fix this?

Since in the failure case the result of llimd would need 96 bits, the
only way is to make llimd result a 96 bits variable.

--=20
 Gilles

