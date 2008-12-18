Message-ID: <494A7ED0.8090008@domain.hid>
Date: Thu, 18 Dec 2008 16:48:16 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e0812180831n6ebf4ff1gcb990864ba112eab@domain.hid>
In-Reply-To: <8b216e9e0812180831n6ebf4ff1gcb990864ba112eab@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on Gumstix (ARM XScale PXA270)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Cc: xenomai@xenomai.org

Felipe Brand=E3o Cavalcanti wrote:
> Hi,
>=20
> I am currently trying to get Xenomai running on the gumstix plataform (=

> http://www.gumstix.com/), which is a *very* small linux board based on =
the
> PXA270 ARM XScale (I am using a Verdex board). However, I did run into =
a few
> problems during the procedure (the user space portion locks up!)
>=20
> I followed the instructions on the README file, and patched the kernel =
with
> the proper Adeos patch using the command:
> ./prepare-kernel.sh
> --linux=3D/home/felipe/gumstix/gumstix-oe/tmp/work/gumstix-custom-verde=
x-angstrom-linux-gnueabi/gumstix-kernel-2.6.24-r1/linux-2.6.24/
> --adeos=3D/home/felipe/gumstix/adeos-ipipe-2.6.24-arm-1.9-01.patch --ar=
ch=3Darm
>=20
> I did the standart kernel configuration procedure afterwards, and did
> configure the Xenomai options. The kernel did boot fine, and I can conf=
irm
> that Adeos is running (I have /proc/xenomai and some messages during th=
e
> boot process).
>=20
> My problem is with the user space portion of Xenomai. I compiled it usi=
ng
> the usual cross-compiling procedure:
> ./configure --enable-arm-mach=3Dpxa3xx --host=3Darm-linux
> make
> make install
> However, the "make install" command runs on a fakeroot, than gets packa=
ged
> and transfered to the embedded plataform (the Gumstix). Basically, the
> package contains the stuff on /dev and on /usr/xenomai.
>=20
> Basically, when I try to run xeno-test, the whole systems locks up (I h=
ave
> to hard-reset) when it gets to the latency test.
> When I run ./latency, it also freezes up.

Known issue. The default period of the latency test is 100us which is
much to small for an ARM. Try latency -p 1000. I believe xeno-test also
has a -p option passed to latency.

>=20
> However, when I try ./latency -t 1 and ./latency -t 2 (testing the kern=
el
> latency, IIRC), it runs fine. My guess is that the problems is with the=

> user-space instalation procedure (somehow it is not being correctly
> installed?).
>=20
> My other question is regarding the latencies I should be getting (they =
do
> seem quite high.) Here is the output from my latency tests:
> root@domain.hid$ ./latency -t 2
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel timer handler
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel timer handler, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=

> worst
> RTD|       0.307|       0.925|      10.153|       0|       0.307|
> 10.153
> RTD|       0.613|       0.988|     145.229|       1|       0.307|
> 145.229
> RTD|      -3.695|       0.962|      78.767|       1|      -3.695|
> 145.229
> RTD|       0.612|       0.969|      80.920|       1|      -3.695|
> 145.229
> RTD|      -4.003|       0.962|      77.535|       1|      -4.003|
> 145.229
> =16RTD|      -1.850|       0.970|      80.919|       1|      -4.003|
> 145.229
> ---|------------|------------|------------|--------|-------------------=
------
> RTS|      -4.003|       0.962|     145.229|       1|    00:00:08/00:00:=
08
> root@domain.hid$ ./latency -t 1
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel periodic task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=

> worst
> RTD|       4.921|       8.581|      23.383|       0|       4.921|
> 23.383
> RTD|       4.921|       8.662|     135.998|       5|       4.921|
> 135.998
> RTD|       4.920|       8.692|     173.228|       9|       4.920|
> 173.228
> RTD|       4.919|       8.658|     173.843|      12|       4.919|
> 173.843
> RTD|       4.919|       8.640|     171.689|      15|       4.919|
> 173.843
> RTD|       4.918|       8.676|     171.380|      21|       4.918|
> 173.843
> RTD|       4.917|       8.642|     171.379|      24|       4.917|
> 173.843
> RTD|       4.916|       8.684|     174.763|      29|       4.916|
> 174.763
> RTD|       4.916|       8.640|     175.070|      32|       4.916|
> 175.070
> RTD|       4.915|       8.651|     169.839|      36|       4.915|
> 175.070
> RTD|       4.914|       8.638|     172.915|      39|       4.914|
> 175.070
> RTD|       4.914|       8.702|     170.145|      47|
> 4.914---|------------|------------|------------|--------|--------------=
-----------
> RTS|       4.914|       8.655|     175.070|      47|    00:00:12/00:00:=
12
>=20
> The worst latency seem to be arround 175, which is not very good (compa=
ring
> it to an X86 processor). Is this normal or is there some kernel
> configuration option which I can use to improve on this? (I am running =
it
> with a farly custom config file, so some undeserible options might be
> enabled).

There are a few answers to this question:
- we know of a way to improve the pure interrupt latency, it consists in
switching contexts with interrupts on (the idea was taken from linux) it
is currently implemented in trunk, but unfortunately not in the stable
branch;
- you can improve the context switch time (which results in better
user-space latency) by using the ARM FCSE, the option is available on
the latest Adeos patch for linux 2.6.26 and reduces the context switch
time of about 100us.

Note however that even with this two optimizations, 100us is still too
hard for an ARM, but you will observe overruns instead of a lockup.

>=20
> BTW, for the curious, I am using this in order to control a humanoid ro=
bot
> (Bioloid) - I am doing research on humanoid robots, and the idea is to =
use
> embedded linux for the control portion of the project. I am a student a=
t the
> LARA research lab in the University of Bras=EDlia, Brazil.
>=20
> Thank you very much for any help,
>             -Felipe B Cavalcanti
>             LARA - Laboratory of Robotics and Automation
>             UnB - University of Bras=EDlia, Brazil

That is interesting.

Regards.

--=20
                                                 Gilles.


