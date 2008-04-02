Message-ID: <47F2F6F6.70009@domain.hid>
Date: Tue, 01 Apr 2008 23:01:10 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
In-Reply-To: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
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
To: =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi,

I don't have the answer, but just to feed my curiosity, do you know what=20
would happen if you run the benchmarks much longer ? I can imagine that=20
it would either stabilize on some value, or, it might start again from a=20
large value at the beginning..

Tomas

Cornelius K=F6pp wrote:
> Hello,
> I run the latency test from testsuite on several hard and software conf=
igurations. Running on Xenomai 2.4.2, Linux 2.6.24 the results shows a "s=
trange" behavior: In Kernel mode (-t1) the latencys constantly linear dec=
rease. See attached plot 'drifting_latencys_in_kernelmode.png' of latency=
 test running 48h on Pentium3 700. This effect could be reproduced, even =
on other hardware (Pentium-M 1400). The usermode (-t0) did not show a dri=
fting, but is influenced by a test ran in kernelmode before.
>
> I talked with Sebastian Smolorz about this and he builds his own indepe=
ndent kernel-config to check. He got the same drifting-effect with Xenoma=
i 2.4.2 and Xenomai 2.4.3 running latency over several hours. His kernel-=
config ist attached as 'config-2.6.24-xenomai-2.4.3__ssm'.
>
> Our kernel-configs are both based on a config used with Xenomai 2.3.4 a=
nd Linux 2.6.20.15 without any drifting effects.
>
> Bad luck with the config?
>
>
> Thanks in advance,
>
> Cornelius K=F6pp
>  =20
>
> -----------------------------------------------------------------------=
-
>
> -----------------------------------------------------------------------=
-
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>  =20


