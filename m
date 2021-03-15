From: steve freyder <steve@freyder.net>
Subject: Kernel 5.4 xenomai 3.1 -stable, e1000e, NIC crash on ifup
Message-ID: <a5d49a09-0317-9f58-03ff-f1a1ef109b99@freyder.net>
Date: Mon, 15 Mar 2021 12:19:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Greetings Xenomai list,


We are seeing the following stack trace when we 'ifup' the e1000e 
adapter.  4.19 exhibits same failure, 4.14.96 also fails but with a 
different stack trace.  Last working version is 4.14.85.

Thanks in advance for any assist,

Steve

------------------------------------------------------------------------

[   47.635779] ------------[ cut here ]------------
[   47.637083] ip (658) used greatest stack depth: 3960 bytes left
[   47.640416] WARNING: CPU: 0 PID: 0 at kernel/ipipe/core.c:1968 
__ipipe_spin_unlock_debug+0x50/0x5c
[   47.655297] Modules linked in: xeno_gpio_mxc e1000e
[   47.660198] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
5.4.93-00202-g1070d76ae3f5-dirty #7
[   47.668386] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   47.674923] I-pipe domain: Linux
[   47.678159] Backtrace:
[   47.680620] [<80992f10>] (dump_backtrace) from [<8099328c>] 
(show_stack+0x20/0x24)
[   47.688199]  r7:81238180 r6:00000080 r5:00000000 r4:811a66f0
[   47.693867] [<8099326c>] (show_stack) from [<8099cac0>] 
(dump_stack+0xf4/0x128)
[   47.701184] [<8099c9cc>] (dump_stack) from [<8012ba1c>] 
(__warn+0xd0/0x108)
[   47.708154]  r9:00000000 r8:00000009 r7:000007b0 r6:801e1448 
r5:00000009 r4:80c02be0
[   47.715905] [<8012b94c>] (__warn) from [<809942b8>] 
(warn_slowpath_fmt+0x6c/0xc4)
[   47.723396]  r7:801e1448 r6:000007b0 r5:80c02be0 r4:00000000
[   47.729065] [<80994250>] (warn_slowpath_fmt) from [<801e1448>] 
(__ipipe_spin_unlock_debug+0x50/0x5c)
[   47.738206]  r8:ffffffff r7:00000000 r6:ffff9d6c r5:bf54b4c0 r4:bd354580
[   47.744917] [<801e13f8>] (__ipipe_spin_unlock_debug) from 
[<801a2d90>] (mod_timer+0x190/0x400)
[   47.753537] [<801a2c00>] (mod_timer) from [<7f01a5b8>] 
(e1000_msix_other+0xac/0xb8 [e1000e])
[   47.761984]  r10:80e748d4 r9:00000001 r8:81101d78 r7:00000137 
r6:bd3549e4 r5:81000004
[   47.769822]  r4:bd354000
[   47.772365] [<7f01a50c>] (e1000_msix_other [e1000e]) from 
[<801859b8>] (__handle_irq_event_percpu+0x64/0x240)
[   47.782289]  r7:00000137 r6:00000000 r5:bd23e870 r4:bc09aa80
[   47.787957] [<80185954>] (__handle_irq_event_percpu) from 
[<80185bd0>] (handle_irq_event_percpu+0x3c/0x98)
[   47.797618]  r10:80e748d4 r9:00000001 r8:81106fe8 r7:c0faf65c 
r6:bd23e870 r5:bd23e870
[   47.805456]  r4:bd23e800
[   47.807999] [<80185b94>] (handle_irq_event_percpu) from [<80185c74>] 
(handle_irq_event+0x48/0x6c)
[   47.816878]  r5:bd23e870 r4:bd23e800
[   47.820463] [<80185c2c>] (handle_irq_event) from [<8018ba84>] 
(handle_edge_irq+0xb4/0x1f8)
[   47.828735]  r7:c0faf65c r6:80e8a410 r5:bd23e870 r4:bd23e800
[   47.834403] [<8018b9d0>] (handle_edge_irq) from [<801849d8>] 
(generic_handle_irq+0x30/0x44)
[   47.842762]  r9:00000001 r8:00000830 r7:00000000 r6:00000000 
r5:be412e58 r4:00000003
[   47.850513] [<801849a8>] (generic_handle_irq) from [<8057dca8>] 
(dw_handle_msi_irq+0x9c/0xf4)
[   47.859046] [<8057dc0c>] (dw_handle_msi_irq) from [<8057dd34>] 
(dw_chained_msi_isr+0x34/0x80)
[   47.867579]  r9:8116cad4 r8:8111e8a8 r7:0000001a r6:bee36414 
r5:811119dc r4:bee36400
[   47.875331] [<8057dd00>] (dw_chained_msi_isr) from [<801e2dd0>] 
(__ipipe_dispatch_irq+0x154/0x228)
[   47.884297]  r7:0000001a r6:00000001 r5:00000019 r4:00000000
[   47.889965] [<801e2c7c>] (__ipipe_dispatch_irq) from [<801028dc>] 
(__ipipe_grab_irq+0x54/0xb4)
[   47.898585]  r9:8116cad4 r8:f4000100 r7:bf3b7ae0 r6:81101eb8 
r5:bf3b5ae0 r4:00000019
[   47.906337] [<80102888>] (__ipipe_grab_irq) from [<80102a8c>] 
(gic_handle_irq+0x58/0xb0)
[   47.914437]  r7:811072f8 r6:000003ff r5:f400010c r4:81101eb8
[   47.920105] [<80102a34>] (gic_handle_irq) from [<80101c64>] 
(__irq_svc+0x84/0x90)
[   47.927595] Exception stack(0x81101eb8 to 0x81101f00)
[   47.932657] 1ea0: 80000000 00000000
[   47.940842] 1ec0: bf3b5ae0 00000000 80e8fae0 00000000 81106b68 
81106ba8 811abf50 80bfbb3c
[   47.949027] 1ee0: 80e748d4 81101f1c 81101f08 81101f08 801e26f8 
801e26fc 60070013 ffffffff
[   47.957214]  r9:81100000 r8:811abf50 r7:81101eec r6:ffffffff 
r5:60070013 r4:801e26fc
[   47.964966] [<801e269c>] (ipipe_unstall_root) from [<8010a2d8>] 
(arch_cpu_idle+0x98/0xb0)
[   47.973151]  r5:00000000 r4:80e8fae0
[   47.976735] [<8010a240>] (arch_cpu_idle) from [<809a4a20>] 
(default_idle_call+0x44/0x50)
[   47.984833]  r5:00000000 r4:81100000
[   47.988419] [<809a49dc>] (default_idle_call) from [<8016059c>] 
(do_idle+0xd8/0x1e4)
[   47.996083] [<801604c4>] (do_idle) from [<8016097c>] 
(cpu_startup_entry+0x28/0x2c)
[   48.003661]  r9:00000001 r8:811b1000 r7:00000000 r6:81106b40 
r5:811b1000 r4:000000ce
[   48.011413] [<80160954>] (cpu_startup_entry) from [<8099cc6c>] 
(rest_init+0x9c/0xbc)
[   48.019165] [<8099cbd0>] (rest_init) from [<80e00b44>] 
(arch_call_rest_init+0x18/0x1c)
[   48.027089]  r5:811b1000 r4:80e748d4
[   48.030675] [<80e00b2c>] (arch_call_rest_init) from [<80e00fa0>] 
(start_kernel+0x3e0/0x4a4)
[   48.039035] [<80e00bc0>] (start_kernel) from [<00000000>] (0x0)
[   48.044963] ---[ end trace cea0b6f9eb21f4eb ]---
[   48.049596] ------------[ cut here ]------------
[   48.054244] WARNING: CPU: 0 PID: 0 at kernel/irq/handle.c:152 
__handle_irq_event_percpu+0x220/0x240
[   48.063398] irq 311 handler e1000_msix_other+0x0/0xb8 [e1000e] 
enabled interrupts
[   48.070894] Modules linked in: xeno_gpio_mxc e1000e
[   48.075806] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G W         
5.4.93-00202-g1070d76ae3f5-dirty #7
[   48.085385] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   48.091925] I-pipe domain: Linux
[   48.095164] Backtrace:
[   48.097644] [<80992f10>] (dump_backtrace) from [<8099328c>] 
(show_stack+0x20/0x24)
[   48.105232]  r7:81238180 r6:00000000 r5:00000000 r4:811a66f0
[   48.110915] [<8099326c>] (show_stack) from [<8099cac0>] 
(dump_stack+0xf4/0x128)
[   48.118251] [<8099c9cc>] (dump_stack) from [<8012ba1c>] 
(__warn+0xd0/0x108)
[   48.125229]  r9:00000001 r8:00000009 r7:00000098 r6:80185b74 
r5:00000009 r4:80bfd600
[   48.132993] [<8012b94c>] (__warn) from [<809942e8>] 
(warn_slowpath_fmt+0x9c/0xc4)
[   48.140490]  r7:80185b74 r6:00000098 r5:80bfd600 r4:80bfd5d8
[   48.146176] [<80994250>] (warn_slowpath_fmt) from [<80185b74>] 
(__handle_irq_event_percpu+0x220/0x240)
[   48.155496]  r8:81101d78 r7:00000137 r6:00000000 r5:00000001 r4:bc09aa80
[   48.162216] [<80185954>] (__handle_irq_event_percpu) from 
[<80185bd0>] (handle_irq_event_percpu+0x3c/0x98)
[   48.171885]  r10:80e748d4 r9:00000001 r8:81106fe8 r7:c0faf65c 
r6:bd23e870 r5:bd23e870
[   48.179724]  r4:bd23e800
[   48.182277] [<80185b94>] (handle_irq_event_percpu) from [<80185c74>] 
(handle_irq_event+0x48/0x6c)
[   48.191161]  r5:bd23e870 r4:bd23e800
[   48.194759] [<80185c2c>] (handle_irq_event) from [<8018ba84>] 
(handle_edge_irq+0xb4/0x1f8)
[   48.203037]  r7:c0faf65c r6:80e8a410 r5:bd23e870 r4:bd23e800
[   48.208714] [<8018b9d0>] (handle_edge_irq) from [<801849d8>] 
(generic_handle_irq+0x30/0x44)
[   48.217080]  r9:00000001 r8:00000830 r7:00000000 r6:00000000 
r5:be412e58 r4:00000003
[   48.224845] [<801849a8>] (generic_handle_irq) from [<8057dca8>] 
(dw_handle_msi_irq+0x9c/0xf4)
[   48.233388] [<8057dc0c>] (dw_handle_msi_irq) from [<8057dd34>] 
(dw_chained_msi_isr+0x34/0x80)
[   48.241928]  r9:8116cad4 r8:8111e8a8 r7:0000001a r6:bee36414 
r5:811119dc r4:bee36400
[   48.249698] [<8057dd00>] (dw_chained_msi_isr) from [<801e2dd0>] 
(__ipipe_dispatch_irq+0x154/0x228)
[   48.258669]  r7:0000001a r6:00000001 r5:00000019 r4:00000000
[   48.264350] [<801e2c7c>] (__ipipe_dispatch_irq) from [<801028dc>] 
(__ipipe_grab_irq+0x54/0xb4)
[   48.272977]  r9:8116cad4 r8:f4000100 r7:bf3b7ae0 r6:81101eb8 
r5:bf3b5ae0 r4:00000019
[   48.280738] [<80102888>] (__ipipe_grab_irq) from [<80102a8c>] 
(gic_handle_irq+0x58/0xb0)
[   48.288843]  r7:811072f8 r6:000003ff r5:f400010c r4:81101eb8
[   48.294519] [<80102a34>] (gic_handle_irq) from [<80101c64>] 
(__irq_svc+0x84/0x90)
[   48.302015] Exception stack(0x81101eb8 to 0x81101f00)
[   48.307084] 1ea0: 80000000 00000000
[   48.315279] 1ec0: bf3b5ae0 00000000 80e8fae0 00000000 81106b68 
81106ba8 811abf50 80bfbb3c
[   48.323473] 1ee0: 80e748d4 81101f1c 81101f08 81101f08 801e26f8 
801e26fc 60070013 ffffffff
[   48.331665]  r9:81100000 r8:811abf50 r7:81101eec r6:ffffffff 
r5:60070013 r4:801e26fc
[   48.339431] [<801e269c>] (ipipe_unstall_root) from [<8010a2d8>] 
(arch_cpu_idle+0x98/0xb0)
[   48.347619]  r5:00000000 r4:80e8fae0
[   48.351215] [<8010a240>] (arch_cpu_idle) from [<809a4a20>] 
(default_idle_call+0x44/0x50)
[   48.359317]  r5:00000000 r4:81100000
[   48.362914] [<809a49dc>] (default_idle_call) from [<8016059c>] 
(do_idle+0xd8/0x1e4)
[   48.370588] [<801604c4>] (do_idle) from [<8016097c>] 
(cpu_startup_entry+0x28/0x2c)
[   48.378172]  r9:00000001 r8:811b1000 r7:00000000 r6:81106b40 
r5:811b1000 r4:000000ce
[   48.385936] [<80160954>] (cpu_startup_entry) from [<8099cc6c>] 
(rest_init+0x9c/0xbc)
[   48.393699] [<8099cbd0>] (rest_init) from [<80e00b44>] 
(arch_call_rest_init+0x18/0x1c)
[   48.401627]  r5:811b1000 r4:80e748d4
[   48.405220] [<80e00b2c>] (arch_call_rest_init) from [<80e00fa0>] 
(start_kernel+0x3e0/0x4a4)
[   48.413585] [<80e00bc0>] (start_kernel) from [<00000000>] (0x0)
[   48.419518] ---[ end trace cea0b6f9eb21f4ec ]---



