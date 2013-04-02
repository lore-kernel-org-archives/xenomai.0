Message-ID: <515B599E.4020003@xenomai.org>
Date: Wed, 03 Apr 2013 00:20:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5148C728.6000101@gmail.com> <5148CEA9.7060700@xenomai.org>
	<515175FA.4030901@gmail.com> <51518D16.2050803@xenomai.org>
	<5154161F.8030608@gmail.com> <51543B8D.3000301@xenomai.org>
	<51543FD9.6080707@gmail.com> <5154A702.8060307@xenomai.org>
	<515B1A28.6070802@gmail.com>
In-Reply-To: <515B1A28.6070802@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Decrease Latency (below 10 us) on x32 or x32_64?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manuel Huber <manuel.h87@gmail.com>
Cc: xenomai@xenomai.org

On 04/02/2013 07:49 PM, Manuel Huber wrote:

> Hello!
>=20
> Okay, I miss-configured the last kernel, HPET was still on. Now I compi=
led
> one version on 32bit and one on 64bit. Sorry for the delay, I had some
> issues with 64bit (RTL8169 card doesn't work; I have to check what's th=
e
> problem (I will open another thread for this, but maybe it's just relat=
ed
> to our machine because there is an on-board chip that may cause the
> problem...). I've included two trace-files, one for 32bits and one for
> 64bits, both with HPET disabled.
>=20
> I also checked the C1 Setting in BIOS and the kernel configuration:
>=20
> |---------------------------+----------|
> | AMD C1E Support           | Disabled |
> | AMD K8 Cool&Quiet control | Disabled |
> |---------------------------+----------|
> | HPET Support              | Disabled |
> |---------------------------+----------|
>=20
>> You would probably have better latencies with using Xenomai on only on=
e
>> core. But 36us with the tracer on does not look so bad, does it?
>=20
> Is it enough to boot the kernel with isolcpus=3Dcpu-id and then run the=

> latency tool with the -c option or do I have to restrict IRQ's to the
> specific cpu-id? Do I have to adjust /proc/irq/<some-number>/smp_affini=
ty,
> or is there some other thing I have to do?


Hi,

You have to use the "supported_cpus" argument. If xenomai is not
compiled as a module, pass the "xeno_nucleus.supported_cpus" argument on
the kernel command line.

>=20
> So, the timing of the system is awesome most of the time. I just wanted=
 to
> clarify, whether there is a problem with my setup, or it's normal. It w=
ould
> be cool to get rid of let's say all above 10=C2=B5s. It just rarely hap=
pens, but
> it does.


If there is a problem with your setup, it does not appear clearly on the
traces you sent. Maybe what would help is to trigger a trace on the
opposite cpus when the current cpu has spun for some time on a nucleus lo=
ck.

>=20
> These were the results (tracer disabled) of a test in single/vga mode
> (nouveau driver not in use), with heavy stress on the system (nice -20;=
 10
> instances of burnK7) and IRQ mode (latency -t 2) for 1 hour. (I have


I do not know what burnK7 does, but if it only uses cpu it is not really
a heavy stress. See "dohell" for stressing the system with a more
composite load.

> already posted them, just to point out the problem)
>=20
> Thanks again for your help!
>=20
> Statistics
> ----------
>=20
> |-----+---------+---------+---------+---------+-----+------------------=
-|
> | RTH | lat min | lat avg | lat max | overrun | msw | time             =
 |
> | RTS |  -3.386 |  -2.725 |  19.469 |       0 |   0 | 01:00:00/01:00:00=
 |
> |-----+---------+---------+---------+---------+-----+------------------=
-|



Your system is not calibrated correctly. In order to measure latency you
should run:

echo 0 > /proc/xenomai/latency

Then when you have run the latency test for a sufficient time, echo the
minimum latency you measured, minus some safety margin, to
/proc/xenomai/latency again. If you want to avoid setting the latency
again every time you boot, use the kernel configuration parameter
CONFIG_XENO_OPT_TIMING_SCHEDLAT



--=20
                                                                Gilles.


