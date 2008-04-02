Message-ID: <2ff1a98a0804020546v5eaa8ff4q100ad4820d4ad015@domain.hid>
Date: Wed, 2 Apr 2008 14:46:57 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F37BF8.6000401@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
	<47F34C0D.6090809@domain.hid> <47F37579.7080601@domain.hid>
	<47F37BF8.6000401@domain.hid>
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

On Wed, Apr 2, 2008 at 2:28 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Sebastian Smolorz wrote:
>  > Jan Kiszka wrote:
>  >> Cornelius K=F6pp wrote:
>  >>> Hello,
>  >>> I run the latency test from testsuite on several hard and software
>  >>> configurations. Running on Xenomai 2.4.2, Linux 2.6.24 the results
>  >>> shows a "strange" behavior: In Kernel mode (-t1) the latencys
>  >>> constantly linear decrease. See attached plot
>  >>> 'drifting_latencys_in_kernelmode.png' of latency test running 48h on
>  >>> Pentium3 700. This effect could be reproduced, even on other hardwar=
e
>  >>> (Pentium-M 1400).
>  >>
>  >> As our P3 boards did not support APIC-based timing (IIRC), your kerne=
l
>  >> has correctly disabled the related kernel support. But the Pentium M
>  >> should be fine. So could you check if we are seeing some TSC clocks
>  >> vs. PIT timer rounding issue by enabling the local APIC on the Pentiu=
m M?
>  >
>  > There is no difference in enabling the local APIC on the Pentium M WRT
>  > this bug.
>  >
>  >>> The usermode (-t0) did not show a drifting, but is influenced by a
>  >>> test ran in kernelmode before.
>  >>
>  >> What do you mean with "is influenced"?
>  >
>  > Cornelius saw the following behaviour: If the latency test was run in
>  > user space first, no drift appeared over time. If latency was run in
>  > kernel space (with the reported ngeative drift) a following latency te=
st
>  > in user space showed also negative values but with no additional drift
>  > over time.
>  >
>  >>> I talked with Sebastian Smolorz about this and he builds his own
>  >>> independent kernel-config to check. He got the same drifting-effect
>  >>> with Xenomai 2.4.2 and Xenomai 2.4.3 running latency over several
>  >>> hours. His kernel-config ist attached as
>  >>> 'config-2.6.24-xenomai-2.4.3__ssm'.
>  >>>
>  >>> Our kernel-configs are both based on a config used with Xenomai 2.3.=
4
>  >>> and Linux 2.6.20.15 without any drifting effects.
>  >>
>  >> 2.3.x did not incorporate the new TSC-to-ns conversion. Maybe it is
>  >> not a PIC vs. APIC thing, but rather a rounding problem of larger TSC
>  >> values (that naturally show up when the system runs for a longer time=
).
>  >
>  > This hint seems to point into the right direction. I tried out a
>  > modified pod_32.h (xnarch_tsc_to_ns() commented out) so that the old
>  > implementation in include/asm-generic/bits/pod.h was used. The driftin=
g
>  > bug disappeared. So there seems so be a buggy x86-specific
>  > implementation of this routine.
>
>  Hmm, maybe even a conceptional issue: the multiply-shift-based
>  xnarch_tsc_to_ns is not as precise as the still multiply-divide-based
>  xnarch_ns_to_tsc. So when converting from tsc over ns back to tsc, we
>  may loose some bits, maybe too many bits...

If you want to know whether llmulshft implementation is broken on x86
or if there is a design issue, you can attempt to use the generic
implementation on x86.

--=20
 Gilles

