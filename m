Message-ID: <47F37579.7080601@domain.hid>
Date: Wed, 02 Apr 2008 14:00:57 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
	<47F34C0D.6090809@domain.hid>
In-Reply-To: <47F34C0D.6090809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] latencys drifting into negative
	(Xenomai	2.4.2/2.4.3)
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

Jan Kiszka wrote:
> Cornelius K=F6pp wrote:
>> Hello,
>> I run the latency test from testsuite on several hard and software=20
>> configurations. Running on Xenomai 2.4.2, Linux 2.6.24 the results=20
>> shows a "strange" behavior: In Kernel mode (-t1) the latencys=20
>> constantly linear decrease. See attached plot=20
>> 'drifting_latencys_in_kernelmode.png' of latency test running 48h on=20
>> Pentium3 700. This effect could be reproduced, even on other hardware=20
>> (Pentium-M 1400).
>=20
> As our P3 boards did not support APIC-based timing (IIRC), your kernel=20
> has correctly disabled the related kernel support. But the Pentium M=20
> should be fine. So could you check if we are seeing some TSC clocks vs.=
=20
> PIT timer rounding issue by enabling the local APIC on the Pentium M?

There is no difference in enabling the local APIC on the Pentium M WRT=20
this bug.

>> The usermode (-t0) did not show a drifting, but is influenced by a=20
>> test ran in kernelmode before.
>=20
> What do you mean with "is influenced"?

Cornelius saw the following behaviour: If the latency test was run in=20
user space first, no drift appeared over time. If latency was run in=20
kernel space (with the reported ngeative drift) a following latency test=20
in user space showed also negative values but with no additional drift=20
over time.

>> I talked with Sebastian Smolorz about this and he builds his own=20
>> independent kernel-config to check. He got the same drifting-effect=20
>> with Xenomai 2.4.2 and Xenomai 2.4.3 running latency over several=20
>> hours. His kernel-config ist attached as=20
>> 'config-2.6.24-xenomai-2.4.3__ssm'.
>>
>> Our kernel-configs are both based on a config used with Xenomai 2.3.4=20
>> and Linux 2.6.20.15 without any drifting effects.
>=20
> 2.3.x did not incorporate the new TSC-to-ns conversion. Maybe it is not=
=20
> a PIC vs. APIC thing, but rather a rounding problem of larger TSC value=
s=20
> (that naturally show up when the system runs for a longer time).

This hint seems to point into the right direction. I tried out a=20
modified pod_32.h (xnarch_tsc_to_ns() commented out) so that the old=20
implementation in include/asm-generic/bits/pod.h was used. The drifting=20
bug disappeared. So there seems so be a buggy x86-specific=20
implementation of this routine.

--=20
Sebastian

