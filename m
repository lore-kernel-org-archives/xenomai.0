Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1161013724.5503.65.camel@domain.hid>
References: <1161013724.5503.65.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 16 Oct 2006 23:30:19 +0200
Message-Id: <1161034219.5131.81.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "=?ISO-8859-1?Q?Schl=E4gl?= Manfred jun." <manfred.schlaegl@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-10-16 at 17:48 +0200, Schl=E4gl Manfred jun. wrote:
> Hi!
>=20
> I've tried to implement Adeos 1.5 and Xenomai 2.2.3 on a
> Netsilicon-Platform (ns9750-evalboard with Arm926EJ).
>=20

Make sure to use 1.5-01.

[...]

> I know, it's a common problem with Xenomai/ARM. Is it true, that it has
> something to do with a slow processor-cache-flush? Does anybody know
> more about that?
>=20

FWIW, we had the very same issue on an Integrator CP.

>=20
> 2. I've to use very high Periods on Latency-Tests.
>=20
> With load i've to use > 500 us
> Without load i've to use > 1000 us (!?!)
>=20
> If I run ./latency -p 1000 without any load I get latencies between 40
> and 70 us, but the Process is killed after a few seconds.=20
>  - sometimes simply the message "Killed" is printed.

Could you "strace" your process instead of running it over GDB? I'm not
yet sure that we are actually chasing a SIGSTOP.

[...]

> 3. in-kernel periodic task & in-kernel timer benchmark=20
>=20
> -sh-3.00# ./latency -t 2 -T 10
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel timer handler
> =3D=3D All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25

Eh? That's weird. The fact that the RTDM benchmark device could be
opened, but that a wrong ioctl code seemed to flow to it might be the
sign of the worm, somewhere in the Adeos syscall propagation path. Btw,
are the RTDM-based benchmark drivers compiled statically into the
kernel?

Also, could you patch this in, and tell us if anything appears in the
kernel log during the fail attempt to start the test? TIA,

--- ksrc/drivers/testing/timerbench.c~	2006-07-18 15:19:02.000000000 +020=
0
+++ ksrc/drivers/testing/timerbench.c	2006-10-16 23:28:06.000000000 +0200
@@ -409,6 +409,7 @@
             break;
=20
         default:
+	    printk("%s: bad ioctl code (0x%x)\n", __FUNCTION__, request);
             ret =3D -ENOTTY;
     }
=20

[...]

> -sh-3.00# ./switchbench -n 100 -p 100=20
> =3D=3D Sampling period: 100 us
> =3D=3D Do not interrupt this program
> [  122.670000] Unable to handle kernel paging request at virtual addres=
s
> e2822059
> [  122.670000] pgd =3D c3b60000
> [  122.670000] [e2822059] *pgd=3D00000000
> [  122.670000] Internal error: Oops: 805 [#1]
> [  122.670000] Modules linked in:
> [  122.670000] CPU: 0
> [  122.670000] pc : [<c0150930>]    lr : [<c015080c>]    Not tainted
> [  122.670000] sp : c39d0014  ip : c3b54044  fp : c39d0040
> [  122.670000] r10: c02d43e4  r9 : 00800000  r8 : c0322b2c
> [  122.670000] r7 : c032212c  r6 : 00000000  r5 : c01194e0  r4 :
> 00000000
> [  122.670000] r3 : 00000000  r2 : e282200c  r1 : c3b54000  r0 :
> c3b54000
> [  122.670000] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  Segment use=
r
> [  122.670000] Control: 5317F  Table: 03B60000  DAC: 00000015
> [  122.670000] Process worker (pid: 131, stack limit =3D 0xc39ce194)
> [  122.670000] Stack: (0xc39d0014 to 0xc39d0000)
> [  122.670000] Backtrace:=20
> [  122.670000] Function entered at [<c01502e8>] from [<c014d25c>]
> [  122.670000] Function entered at [<c014d1c4>] from [<c014d2a4>]
> [  122.670000]  r7 =3D 00000000  r6 =3D C02D2680  r5 =3D C02D2880  r4 =3D
> C02D2688
> [  122.670000] Function entered at [<c014d288>] from [<c014a350>]
> [  122.670000] Function entered at [<c014a1e8>] from [<c014a7a4>]
> [  122.670000] Function entered at [<c014a700>] from [<c0126000>]
> [  122.670000]  r7 =3D C02D2680  r6 =3D C02D2880  r5 =3D 00000010  r4 =3D
> C02D2680
> [  122.670000] Function entered at [<c0125e64>] from [<c01260a8>]
> [  122.670000] Function entered at [<c0126010>] from [<c011f824>]
> [  122.670000] Code: e3c3303f e593300c e5932004 e3a03001 (e5c2304d)=20
>=20

As mentioned already, it would be really nice to activate the debug
option and ask ksymoops to dump some symbolic backtrace about this
crash.

[...]

> 5. cyclictest
>=20
> Here some test-cases:
>=20
> -sh-3.00# ./cyclictest -l 100
> 0.03 0.01 0.00 1/21 53         =20

[...]

> cyclic-Test runs, but while it is running, timer_tick is never called.
>=20

If you want to run this test by hand, try:
./cyclictest -n -t 1 -i 100
or just use the "run" script. The output you got is likely because the
default setup uses plain Linux signals for triggering the sampling
activity.

[...]

--=20
Philippe.



