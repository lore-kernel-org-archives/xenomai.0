From: Michael Bernhard <michael.bernhard@domain.hid>
Date: Sat, 05 Mar 2011 16:12:33 +0100
Message-ID: <4D7252E1.9050000@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Runtime error on PXA270 for branch
	'for-ipipe-2.6.35-arm' in 'ipipe-gch.git'
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello!

I'm trying to get running the ipipe patch on a 2.6.35 kernel. I've seen
that Gilles was working on that port lately so I gave it a try.

The kernel is booting fine. However init does not continue and the
NETDEV watchdog triggers:


[   23.043294] Freeing init memory: 124K
[   31.995507] ------------[ cut here ]------------
[   32.009368] WARNING: at /home/mib/EBX04/ipipe-2.6/net/sched/sch_generic.c:258 dev_watchdog+0x17c/0x290()
[   32.037640] NETDEV WATCHDOG: eth0 (dm9000): transmit queue 0 timed out
[   32.057061] Modules linked in:
[   32.066209] [<c002d7a8>] (unwind_backtrace+0x0/0xec) from [<c004137c>] (warn_slowpath_common+0x4c/0x64)
[   32.094207] [<c004137c>] (warn_slowpath_common+0x4c/0x64) from [<c0041414>] (warn_slowpath_fmt+0x2c/0x3c)
[   32.122715] [<c0041414>] (warn_slowpath_fmt+0x2c/0x3c) from [<c026af20>] (dev_watchdog+0x17c/0x290)
[   32.149695] [<c026af20>] (dev_watchdog+0x17c/0x290) from [<c004c490>] (run_timer_softirq+0x184/0x258)
[   32.177192] [<c004c490>] (run_timer_softirq+0x184/0x258) from [<c00469a4>] (__do_softirq+0x88/0x124)
[   32.204409] [<c00469a4>] (__do_softirq+0x88/0x124) from [<c0046a88>] (irq_exit+0x48/0x5c)
[   32.228816] [<c0046a88>] (irq_exit+0x48/0x5c) from [<c0027070>] (asm_do_IRQ+0x70/0x8c)
[   32.252409] [<c0027070>] (asm_do_IRQ+0x70/0x8c) from [<c0027aa4>] (__irq_svc+0x44/0xd0)
[   32.276250] Exception stack(0xc0415f80 to 0xc0415fc8)
[   32.291291] 5f80: 00000001 00000000 c0415fc8 60000013 c0414000 c0022020 c002201c c0417b50
[   32.315654] 5fa0: a001ffa8 69054117 a001ff74 00000000 00000000 c0415fc8 c002905c c0029068
[   32.340003] 5fc0: 60000013 ffffffff
[   32.350403] [<c0027aa4>] (__irq_svc+0x44/0xd0) from [<c0029068>] (default_idle+0x2c/0x30)
[   32.374756] [<c0029068>] (default_idle+0x2c/0x30) from [<c0029550>] (cpu_idle+0x58/0xac)
[   32.398881] [<c0029550>] (cpu_idle+0x58/0xac) from [<c0008b0c>] (start_kernel+0x284/0x2e4)
[   32.423502] [<c0008b0c>] (start_kernel+0x284/0x2e4) from [<a0008034>] (0xa0008034)
[   32.446064] ---[ end trace a6d3f140188b1aa5 ]---

The same behavior happens even if I disable FCSE and IPIPE or either of it.
I think this is pretty much what this tree contains.

A vanilla 2.6.35.9 kernel is booting fine with colibri_pxa270_defconfig.

As you see from the defconfig, the target is a PXA270 colibri board.

For me the behavior is a bit strange because the kernel already fetched
the IP address via DHCP and also mounted the NFS root file system

Does somebody have an idea in which direction I should investigate?

Of course I can provide more information if needed. We would like to
use Xenomai on this ARM board with kernel 2.6.35.

Best regards,
Michael


