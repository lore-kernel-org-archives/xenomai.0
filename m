MIME-Version: 1.0
In-Reply-To: <CALLqZ8Qv6KppR1vAhw4VhKGGDHiyBySE+Tq+U6+_64U7L9=Wjw@mail.gmail.com>
References: <E179B671-6D57-4517-B751-91AE099B2DCF@korgrd.com>
 <CALLqZ8Qv6KppR1vAhw4VhKGGDHiyBySE+Tq+U6+_64U7L9=Wjw@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 30 May 2018 09:24:44 +0530
Message-ID: <CAOuPNLgSKf=vucNgqVWHndg6NoLBbCJE2u7mS3kZh1_qdGrEsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai 3.0.6 on RPi3 overheating when idle
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Steve Pavao <stevep@korgrd.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have done Xenomai-3 bring up RPi3-ModelB-2015 with 32-bit Kernel and
Raspbian, but without Yocto.
I havent changed any kernel configuration and so far I havent seen any
heating issue.
But I have just finished the bring up and havent tested any functionality
yet.

May be you can compare the kernel configuration that comes with Yocto and
Raspbian default.
You can also check the "top" output and see for any CPU increase suspect.
You can monitor dmesg logs and check for suspicious output.


Thanks,
Pintu

FYI:
This is the latency test output is from Rpi3:
pi@raspberrypi:~ $ sudo /usr/xenomai/bin/latency
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|      0.364|      1.164|      8.385|       0|     0|      0.364|
8.385
RTD|      0.780|      1.528|      7.707|       0|     0|      0.364|
8.385
RTD|      0.728|      1.541|      8.019|       0|     0|      0.364|
8.385
RTD|      0.779|      1.543|      9.060|       0|     0|      0.364|
9.060
RTD|      0.675|      1.495|      5.050|       0|     0|      0.364|
9.060
RTD|      0.726|      1.499|      9.685|       0|     0|      0.364|
9.685
RTD|      0.726|      1.503|      6.455|       0|     0|      0.364|
9.685
RTD|      0.361|      1.166|      8.851|       0|     0|      0.361|
9.685
RTD|      0.465|      1.486|     17.496|       0|     0|      0.361|
 17.496
RTD|      0.360|      1.128|      9.006|       0|     0|      0.360|
 17.496
RTD|      0.360|      1.101|      4.943|       0|     0|      0.360|
 17.496
RTD|      0.412|      1.148|     12.391|       0|     0|      0.360|
 17.496
RTD|      0.359|      1.177|     10.047|       0|     0|      0.359|
 17.496
RTD|      0.463|      1.436|      3.901|       0|     0|      0.359|
 17.496
RTD|      0.411|      1.137|      7.650|       0|     0|      0.359|
 17.496
RTD|      0.462|      1.145|      5.514|       0|     0|      0.359|
 17.496
RTD|      0.410|      1.141|      5.410|       0|     0|      0.359|
 17.496
RTD|      0.409|      1.188|      8.066|       0|     0|      0.359|
 17.496
RTD|      0.461|      1.449|      9.628|       0|     0|      0.359|
 17.496
RTD|      0.357|      1.075|      6.659|       0|     0|      0.357|
 17.496
RTD|      0.356|      1.109|      6.971|       0|     0|      0.356|
 17.496
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|      0.356|      1.107|      9.366|       0|     0|      0.356|
 17.496
RTD|      0.303|      1.116|      5.303|       0|     0|      0.303|
 17.496
RTD|      0.355|      1.410|      5.980|       0|     0|      0.303|
 17.496





On Wed, May 30, 2018 at 2:20 AM, Greg Gallagher <greg@embeddedgreg.com>
wrote:

> I haven't tested Xenomai on RPI3 in 32-bit mode, I think someone else
> tried it a while ago with out using Yocto and may be able to share his
> experiences (Gustav?).  I haven't seen this issue on Raspberry pi 2b.
> You can take a look at the output of ps and see if anything is using a
> lot of the CPU.  I'm finishing up some RPI0 and 1 work now but I'll
> hopefully move on to look at the rpi3 in the next couple of weeks.
>
> -Greg
>
> On Tue, May 29, 2018 at 4:37 PM, Steve Pavao <stevep@korgrd.com> wrote:
> > Hello,
> >
> > I=E2=80=99m having an overheating problem when running xenomai 3.0.6 on
> Raspberry Pi 3 with the recipes and defconfig from
> https://github.com/pficheux/meta-xenomai <https://github.com/pficheux/
> meta-xenomai> , but I=E2=80=99m using the altered kernel setting CONFIG_H=
Z=3D1000.
> >
> > Under this configuration, the RPi3 overheats when idle.  I=E2=80=99d li=
ke to try
> to understand why.  Is there perhaps a defconfig settting I need to adjus=
t,
> so that there will be not be so much heat-generating activity when the
> system is idle?  I did not observe anything useful with ps.
> >
> > This is my first time successfully building and running xenomai on RPi3
> 32-bit using yocto recipes and a defconfig.  I built in rocko branch.  I
> notice there are many options in the defconfig which may affect operation=
.
> I do not 100% understand all these options, but I have started googling
> them to see if I can solve this issue.
> >
> > I appreciate any ideas you may have.
> >
> > Steve Pavao
> > Korg R&D
> >
> > some of dmesg:
> >
> > [    0.000000] Linux version 4.9.45-xeno (oe-user@oe-host) (gcc version
> 7.3.0 (GCC) ) #2 SMP Tue May 29 19:19:23 UTC 2018
> > [    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7),
> cr=3D10c5383d
> >
> > [    0.000000] arm_arch_timer: Architected cp15 timer(s) running at
> 19.20MHz (phys).
> > [    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 =
ms
> > [    0.000000] clocksource: ipipe_tsc: mask: 0xffffffffffffffff
> max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
> > [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
> > [    0.000007] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps
> every 4398046511078ns
> > [    0.000025] Switching to timer-based delay loop, resolution 52ns
> > [    0.001464] Interrupt pipeline (release #2)
> >
> > [    0.164653] [Xenomai] scheduling class idle registered.
> > [    0.164676] [Xenomai] scheduling class rt registered.
> > [    0.164820] I-pipe: head domain Xenomai registered.
> > [    0.166498] [Xenomai] Cobalt v3.0.6 (Stellar Parallax)
> >
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > https://xenomai.org/mailman/listinfo/xenomai
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
