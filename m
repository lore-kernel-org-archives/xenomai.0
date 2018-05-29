MIME-Version: 1.0
In-Reply-To: <E179B671-6D57-4517-B751-91AE099B2DCF@korgrd.com>
References: <E179B671-6D57-4517-B751-91AE099B2DCF@korgrd.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 29 May 2018 16:50:58 -0400
Message-ID: <CALLqZ8Qv6KppR1vAhw4VhKGGDHiyBySE+Tq+U6+_64U7L9=Wjw@mail.gmail.com>
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
To: Steve Pavao <stevep@korgrd.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I haven't tested Xenomai on RPI3 in 32-bit mode, I think someone else
tried it a while ago with out using Yocto and may be able to share his
experiences (Gustav?).  I haven't seen this issue on Raspberry pi 2b.
You can take a look at the output of ps and see if anything is using a
lot of the CPU.  I'm finishing up some RPI0 and 1 work now but I'll
hopefully move on to look at the rpi3 in the next couple of weeks.

-Greg

On Tue, May 29, 2018 at 4:37 PM, Steve Pavao <stevep@korgrd.com> wrote:
> Hello,
>
> I=E2=80=99m having an overheating problem when running xenomai 3.0.6 on R=
aspberry Pi 3 with the recipes and defconfig from https://github.com/pfiche=
ux/meta-xenomai <https://github.com/pficheux/meta-xenomai> , but I=E2=80=99=
m using the altered kernel setting CONFIG_HZ=3D1000.
>
> Under this configuration, the RPi3 overheats when idle.  I=E2=80=99d like=
 to try to understand why.  Is there perhaps a defconfig settting I need to=
 adjust, so that there will be not be so much heat-generating activity when=
 the system is idle?  I did not observe anything useful with ps.
>
> This is my first time successfully building and running xenomai on RPi3 3=
2-bit using yocto recipes and a defconfig.  I built in rocko branch.  I not=
ice there are many options in the defconfig which may affect operation. I d=
o not 100% understand all these options, but I have started googling them t=
o see if I can solve this issue.
>
> I appreciate any ideas you may have.
>
> Steve Pavao
> Korg R&D
>
> some of dmesg:
>
> [    0.000000] Linux version 4.9.45-xeno (oe-user@oe-host) (gcc version 7=
.3.0 (GCC) ) #2 SMP Tue May 29 19:19:23 UTC 2018
> [    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=3D1=
0c5383d
>
> [    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 19.20=
MHz (phys).
> [    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 ms
> [    0.000000] clocksource: ipipe_tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x46d987e47, max_idle_ns: 440795202767 ns
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_=
cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
> [    0.000007] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps ever=
y 4398046511078ns
> [    0.000025] Switching to timer-based delay loop, resolution 52ns
> [    0.001464] Interrupt pipeline (release #2)
>
> [    0.164653] [Xenomai] scheduling class idle registered.
> [    0.164676] [Xenomai] scheduling class rt registered.
> [    0.164820] I-pipe: head domain Xenomai registered.
> [    0.166498] [Xenomai] Cobalt v3.0.6 (Stellar Parallax)
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

