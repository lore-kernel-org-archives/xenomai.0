From: Steve Pavao <stevep@korgrd.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Tue, 29 May 2018 16:37:53 -0400
Message-Id: <E179B671-6D57-4517-B751-91AE099B2DCF@korgrd.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] xenomai 3.0.6 on RPi3 overheating when idle
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I=E2=80=99m having an overheating problem when running xenomai 3.0.6 on =
Raspberry Pi 3 with the recipes and defconfig from =
https://github.com/pficheux/meta-xenomai =
<https://github.com/pficheux/meta-xenomai> , but I=E2=80=99m using the =
altered kernel setting CONFIG_HZ=3D1000.

Under this configuration, the RPi3 overheats when idle.  I=E2=80=99d =
like to try to understand why.  Is there perhaps a defconfig settting I =
need to adjust, so that there will be not be so much heat-generating =
activity when the system is idle?  I did not observe anything useful =
with ps.

This is my first time successfully building and running xenomai on RPi3 =
32-bit using yocto recipes and a defconfig.  I built in rocko branch.  I =
notice there are many options in the defconfig which may affect =
operation. I do not 100% understand all these options, but I have =
started googling them to see if I can solve this issue.

I appreciate any ideas you may have.

Steve Pavao
Korg R&D

some of dmesg:

[    0.000000] Linux version 4.9.45-xeno (oe-user@oe-host) (gcc version =
7.3.0 (GCC) ) #2 SMP Tue May 29 19:19:23 UTC 2018
[    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), =
cr=3D10c5383d

[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at =
19.20MHz (phys).
[    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 =
ms
[    0.000000] clocksource: ipipe_tsc: mask: 0xffffffffffffffff =
max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff =
max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000007] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps =
every 4398046511078ns
[    0.000025] Switching to timer-based delay loop, resolution 52ns
[    0.001464] Interrupt pipeline (release #2)

[    0.164653] [Xenomai] scheduling class idle registered.
[    0.164676] [Xenomai] scheduling class rt registered.
[    0.164820] I-pipe: head domain Xenomai registered.
[    0.166498] [Xenomai] Cobalt v3.0.6 (Stellar Parallax)=20

