From: Sebastian Smolorz <ssm@domain.hid>
Date: Thu, 9 Nov 2006 17:24:54 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WZ1UFsFMb7teeCs"
Message-Id: <E1GiChy-0006Bp-5K@mailer.emlix.com>
Subject: [Xenomai-core] I-pipe patch for ARM S3C24xx (v4)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_WZ1UFsFMb7teeCs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

now that the teething problems of my I-pipe port to the S3C24xx are cured 
(hopefully ...) I'm going to iterate it to v4. We've established a project 
homepage for that port
http://opensource.emlix.com/ipipe-s3c24xx/
in order to concentrate the source code and information at one point. Probably 
tomorrow I will come up with a patch in order to address point 2 in my email 
from 27.10.2006 ([1]). After that I can go to v5 of my patch and beg for 
integration. :-)

However, there is one disturbing issue. When I execute

dd if=/dev/zero of=/dev/null

and the latency test in userspace with a period not less than 150 us the worst 
case latency is about 220 us. But when I start latency with -p 100 I get a 
softlock like the one attached. I guess this is the same problem as Detlef 
Vollmann described in [2]. So I think it's time for a big fat ARM-specific 
warning in the troubleshooting file and perhaps a modification of the 
testsuite so that if being compiled for ARM the default sample periods are 
greater than the 100 us now.

Sebastian


[1] https://mail.gna.org/public/xenomai-core/2006-10/msg00079.html
[2] https://mail.gna.org/public/xenomai-core/2006-09/msg00055.html

--Boundary-00=_WZ1UFsFMb7teeCs
Content-Type: text/plain;
  charset="us-ascii";
  name="softlock"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="softlock"

# ./latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
BUG: soft lockup detected on CPU#0!

Pid: 772, comm:                   dd
CPU: 0
PC is at __ipipe_mach_get_tsc+0x44/0x54
LR is at 0x0
pc : [<bf000bac>]    lr : [<00000000>]    Not tainted
sp : 00000000  ip : 00000000  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
Flags: nZcv  IRQs on  FIQs on  Mode USER_32  Segment user
Control: C000317F  Table: 31FF0000  DAC: 00000015
[<c0022a90>] (show_regs+0x0/0x4c) from [<c005b86c>] (softlockup_tick+0x64/0x7c)
 r4 = C027F424
[<c005b808>] (softlockup_tick+0x0/0x7c) from [<c0047820>] (do_timer+0x3e8/0x468)
 r4 = C02A265C
[<c0047438>] (do_timer+0x0/0x468) from [<c0025ae0>] (timer_tick+0xb4/0xe4)
[<c0025a2c>] (timer_tick+0x0/0xe4) from [<c002b8ec>] (s3c2410_timer_interrupt+0x78/0xa4)
 r6 = C02A1610  r5 = 00000000  r4 = C022A4C8
[<c002b874>] (s3c2410_timer_interrupt+0x0/0xa4) from [<c0021bdc>] (__do_irq+0x40/0x74)
 r8 = C027F424  r7 = 0000001E  r6 = 00000000  r5 = 00000000
 r4 = C022A4C8
[<c0021b9c>] (__do_irq+0x0/0x74) from [<c0021d20>] (do_edge_IRQ+0xa0/0xfc)
 r8 = C027F424  r7 = C027F424  r6 = C022A4C8  r5 = 0000001E
 r4 = C027E3A0
[<c0021c80>] (do_edge_IRQ+0x0/0xfc) from [<c0021e74>] (asm_do_IRQ+0x50/0x13c)
 r7 = C022DFC0  r6 = 0000001E  r5 = 00000000  r4 = C022DFC8
[<c0021e24>] (asm_do_IRQ+0x0/0x13c) from [<c005bfd8>] (__ipipe_sync_stage+0x1e0/0x268)
[<c005bdf8>] (__ipipe_sync_stage+0x0/0x268) from [<c005c440>] (__ipipe_walk_pipeline+0x98/0xbc)
[<c005c3a8>] (__ipipe_walk_pipeline+0x0/0xbc) from [<c00270a4>] (__ipipe_handle_irq+0x1a4/0x1b4)
 r7 = C02A3B00  r6 = 0000001E  r5 = 0000001E  r4 = FFFFFFFF
[<c0026f00>] (__ipipe_handle_irq+0x0/0x1b4) from [<c0027178>] (__ipipe_grab_irq+0xc4/0x110)
[<c00270b4>] (__ipipe_grab_irq+0x0/0x110) from [<c0020c60>] (__irq_usr+0x40/0x170)

--Boundary-00=_WZ1UFsFMb7teeCs--

