Message-ID: <4533CD7B.9050303@domain.hid>
Date: Mon, 16 Oct 2006 20:20:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161013724.5503.65.camel@domain.hid>
In-Reply-To: <1161013724.5503.65.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?=22Schl=E4gl_=5C=22Manfred_jun=2E=5C=22=22?= <manfred.schlaegl@domain.hid>
Cc: xenomai@xenomai.org

Schl=E4gl Manfred jun. wrote:
> Hi!
>=20
> I've tried to implement Adeos 1.5 and Xenomai 2.2.3 on a
> Netsilicon-Platform (ns9750-evalboard with Arm926EJ).
>=20
> The Timer is implemented (with a manual __ipipe_trigger_irq if
> reload<3). The Interrupt-Demuxer is deactivated.
>=20
> The System boots with Adeos & Xenomai. Time is running normally. Things
> look generally very good, but there are some Problems:
>=20
>=20
> 1. Latencies are very high.
>=20
> dd if=3D/dev/zero of=3D/dev/null &
> ./latency -p 10000 -T 20
>=20
> RTS|      92.592|      95.486|     125.506|       0|
> 00:00:20/00:00:20
>=20
> I know, it's a common problem with Xenomai/ARM. Is it true, that it has
> something to do with a slow processor-cache-flush? Does anybody know
> more about that?

Welcome to the club.

See http://www.linuxdevices.com/articles/AT2598317046.html

According to this article, disabling MMU should improve the situation.
But the I-pipe patch has not yet been tested on ucLinux for ARM.

Also, if you want to measure the real effect of the cache on the
latency test, you should run the cache calibrator in an infinite loop:
http://monetdb.cwi.nl/Calibrator/
With this tool, I easily get a bit less than 200 us latency on an ARM
clocked at 600 MHz.

>=20
>=20
> 2. I've to use very high Periods on Latency-Tests.
>=20
> With load i've to use > 500 us
> Without load i've to use > 1000 us (!?!)
>=20
> If I run ./latency -p 1000 without any load I get latencies between 40
> and 70 us, but the Process is killed after a few seconds.=20
>  - sometimes simply the message "Killed" is printed.=20
> 	In this case the system is running, but if i try to start another
> latency-Process the system crashes (most of time: "Unable to handle
> kernel paging request at virtual address xxxxxxxx".)
>  - sometimes the system simply stands still (linux-timerisr /
> linux-timer_tick is'nt called anymore)
> 	jtag-debugger gdb-output:
>=20
> 	Program received signal SIGSTOP, Stopped (signal).
> 	0x0000ba40 in ?? ()
> 	(gdb) stepi
> 	0x0000ba40 in ?? ()
> 	Infinite loop detected
>=20
> The same happens if I run ./latency -p 500 with load.

I observed the same phenomenon, and thought that the sampling period was
simply too small to let the display task run. Your debugger trace seems
to prove me wrong. It would be interesting to know the reason why the
task receives this SIGSTOP.

>=20
>=20
>=20
> 3. in-kernel periodic task & in-kernel timer benchmark=20
>=20
> -sh-3.00# ./latency -t 2 -T 10
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel timer handler
> =3D=3D All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25
> ---|------------|------------|------------|--------|-------------------=
------
> RTS|-1093001.752|       0.001|      93.252|   93340|
> 00:00:10/00:00:10
>=20
> -sh-3.00# ./latency -t 1 -T 10
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel periodic task
> =3D=3D All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25
> ---|------------|------------|------------|--------|-------------------=
------
> RTS|-1097339.416|       0.001|      93.252|   93340|
> 00:00:10/00:00:10
>=20
> What does "latency: failed to start in-kernel timer benchmark, code -25=
"
> mean? Are the results valid?

-25 is -ENOTTY, it happens when you issue an unknown ioctl on an RTDM
device.

>=20
>=20
> 4. switchtest & switchbench
>=20
> -sh-3.00# ./switchtest      =20
> =3D=3D Testing FPU check routines...
> =3D=3D FPU check routines: unimplemented, skipping FPU switches tests.
> =3D=3D Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-=
7
> rtuo-8
> RTT|  00:00:01
> RTH|ctx switches|-------total
> RTD|         450|         450
> RTD|         450|         900
> RTD|         459|        1359
> RTD|         450|        1809
> RTD|         459|        2268
> RTD|         459|        2727
> RTD|         450|        3177
> switchtest seems to run normally, but what does the output mean?
>=20
>=20
> The problems with switchbench are similar to the Problems discussed in
> #2.=20
> -sh-3.00# ./switchbench -n 100 -p 10000
> =3D=3D Sampling period: 10000 us
> =3D=3D Do not interrupt this program
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|       86443|       90060|      101634|           0
> -sh-3.00# ./switchbench -n 100 -p 1000=20
> =3D=3D Sampling period: 1000 us
> =3D=3D Do not interrupt this program
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|       77039|       81741|       98741|           0
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

ksymoops will help you there.

>=20
>=20
>=20
> 5. cyclictest
>=20
> Here some test-cases:
>=20
> -sh-3.00# ./cyclictest -l 100
> 0.03 0.01 0.00 1/21 53         =20
>=20
> T: 0 (   53) P: 0 I:    1000 C:     100 Min:-1087273 Act:-1087273 Max:
> -989708
> -sh-3.00# ./cyclictest -l 1000
> 0.02 0.01 0.00 2/22 56         =20
>=20
> T: 0 (   56) P: 0 I:    1000 C:    1000 Min:-1973899 Act:-1973899 Max:
> -989170
> -sh-3.00# ./cyclictest -l 10000
> 0.01 0.01 0.00 1/21 59         =20
>=20
> T: 0 (   59) P: 0 I:    1000 C:   10000 Min:-10848662 Act:-10848662 Max=
:
> -992290
> -sh-3.00# ./cyclictest -l 100000
> 0.01 0.00 0.00 2/22 62         =20
>=20
> T: 0 (   62) P: 0 I:    1000 C:  100000 Min:-99563368 Act:-99563368 Max=
:
> -989732
> -sh-3.00# ./cyclictest -l 1000000
> 0.98 0.22 0.07 3/22 65         =20
>=20
> T: 0 (   65) P: 0 I:    1000 C: 1000000 Min:-986731091 Act:-986731091
> Max: -989084
>=20
> cyclic-Test runs, but while it is running, timer_tick is never called.
>=20
>=20
>=20
>=20
> I think that all above problems depends on the same root. I tried to
> find that root, but currently without success.=20

I think that you have several problems:
1 and 2 exists on other ARM platforms;
3 is probably a simple problem of device index;
4 and 5 are really worrying, you should start running ksymoops on the=20
oops and/or investigate the case where the timer stop.

--=20
                                                  Gilles Chanteperdrix

