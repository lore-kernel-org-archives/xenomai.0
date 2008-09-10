Message-ID: <48C789B6.5090203@domain.hid>
Date: Wed, 10 Sep 2008 10:47:50 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1221003645.5414.26.camel@domain.hid>
In-Reply-To: <1221003645.5414.26.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] AMCC PowerPC 460EX - error
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
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Henry Bausley wrote:
> I am getting the following error when I added xenomai 2.4.5 to the Denx
> 2.6.26-2 kernel.  I can still use the O.S. even though I get this error.
> However, I'm afraid it is something that may eventually crash my app.
>

This is an interrupt pipeline issue. It will be addressed next week.

> IP-Config: Complete:
>      device=eth0, addr=10.34.9.214, mask=255.0.0.0, gw=255.255.255.255,
>      host=canyonlands, domain=, nis-domain=(none),
>      bootserver=10.34.9.29, rootserver=10.34.9.29, rootpath=
> Looking up port of RPC 100003/2 on 10.34.9.29
> Looking up port of RPC 100005/1 on 10.34.9.29
> NOHZ: local_softirq_pending 08
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 156k init
> ------------[ cut here ]------------
> Badness at c00255d0 [verbose debug info unavailable]
> NIP: c00255d0 LR: c0203a74 CTR: 00000000
> REGS: ef82b6e0 TRAP: 0700   Not tainted  (2.6.26.2)
> MSR: 00029000 <EE,ME>  CR: 42042048  XER: 00000007
> TASK = ef82c000[1] 'swapper' THREAD: ef82a000
> GPR00: 00000001 ef82b790 ef82c000 00000000 00000000 00000000 000007b2
> 00000000 
> GPR08: 0000000f c0359bc0 0000009e 00000006 00000850 10049ef0 ef82bc6c
> ef82bd70 
> GPR16: 00000000 0a22091d 00000801 00000000 00000000 0a22091d 00000000
> 00000000 
> GPR24: 0a22091d 00004000 00000040 efb76e02 00000003 efb85aa0 ef824000
> 00000000 
> NIP [c00255d0] local_bh_enable+0x84/0x9c
> LR [c0203a74] dev_queue_xmit+0xb8/0x360
> Call Trace:
> [ef82b790] [efb85aa0] 0xefb85aa0 (unreliable)
> [ef82b7a0] [c0203a74] dev_queue_xmit+0xb8/0x360
> [ef82b7c0] [c021e184] ip_finish_output+0xf8/0x2e0
> [ef82b7e0] [c021e3f0] ip_local_out+0x34/0x48
> [ef82b7f0] [c021e698] ip_push_pending_frames+0x294/0x3b8
> [ef82b820] [c023ac10] udp_push_pending_frames+0x108/0x348
> [ef82b850] [c023be14] udp_sendmsg+0x2dc/0x590
> [ef82b8f0] [c0242bb8] inet_sendmsg+0x4c/0x78
> [ef82b910] [c01f3090] sock_sendmsg+0xac/0xe4
> [ef82ba00] [c01f3474] kernel_sendmsg+0x2c/0x44
> [ef82ba20] [c02581a0] xs_send_kvec+0x74/0xa8
> [ef82ba60] [c0258250] xs_sendpages+0x7c/0x250
> [ef82ba90] [c0259ec0] xs_udp_send_request+0x44/0x158
> [ef82bab0] [c0256ba0] xprt_transmit+0x64/0x21c
> [ef82bae0] [c0253a6c] call_transmit+0x1e4/0x284
> [ef82bb00] [c025b62c] __rpc_execute+0xa8/0x2ac
> [ef82bb30] [c025431c] rpc_run_task+0x44/0x90
> [ef82bb40] [c012080c] nfs_read_rpcsetup+0x16c/0x1d4
> [ef82bba0] [c011e070] nfs_pageio_doio+0x70/0xa0
> [ef82bbb0] [c011fcdc] nfs_readpages+0xd4/0x17c
> [ef82bc10] [c008f4cc] __do_page_cache_readahead+0x14c/0x22c
> [ef82bc60] [c00889b8] generic_file_aio_read+0x474/0x594
> [ef82bce0] [c0116ff8] nfs_file_read+0xf8/0x13c
> [ef82bd10] [c00b15a8] do_sync_read+0xc4/0x138
> [ef82bdd0] [c00b1f80] vfs_read+0xb4/0x16c
> [ef82bdf0] [c00b751c] kernel_read+0x38/0x50
> [ef82be20] [c00b7c28] do_execve+0x12c/0x1c8
> [ef82be50] [c0006054] sys_execve+0x50/0x7c
> [ef82be70] [c000e04c] ret_from_syscall+0x0/0x3c
> [ef82bf30] [00000000] 0x0
> [ef82bf40] [c0001418] init_post+0xb0/0xf0
> [ef82bf50] [c02ff320] kernel_init+0x218/0x27c
> [ef82bff0] [c000ddcc] kernel_thread+0x44/0x60
> Instruction dump:
> 80010014 83e1000c 7c0803a6 38210010 4e800020 4bfde661 4bffffdc 3d20c036 
> 39299bc0 80090154 7c000034 5400d97e <0f000000> 2f800000 419eff94
> 38000001 
> NOHZ: local_softirq_pending 08
> NOHZ: local_softirq_pending 08
> NOHZ: local_softirq_pending 08
> NOHZ: local_softirq_pending 08
> NOHZ: local_softirq_pending 08
> NOHZ: local_softirq_pending 08
> NOHZ: local_softirq_pending 08
> NOHZ: local_softirq_pending 08
> NOHZ: local_softirq_pending 08
> modprobe: FATAL: Could not load /lib/modules/2.6.26.2/modules.dep: No
> such filey
> 
> modprobe: FATAL: Could not load /lib/modules/2.6.26.2/modules.dep: No
> such filey
> 
> INIT: version 2.86 booting
>                 Welcome to DENX Embedded Linux Environment
>                 Press 'I' to enter interactive startup.
> modprobe: FATAL: Could not load /lib/modules/2.6.26.2/modules.dep: No
> such filey
> 
> modprobe: FATAL: Could not load /lib/modules/2.6.26.2/modules.dep: No
> such filey
> 
> Cannot access the Hardware Clock via any known method.
> Use the --debug option to see the details of our search for an access
> method.
> Setting clock : Thu Jan  1 01:00:04 CET 1970 [  OK  ]
> Building the cache [  OK  ]
> Setting hostname canyonlands:  [  OK  ]
> Mounting local filesystems:  [  OK  ]
> Enabling /etc/fstab swaps:  [  OK  ]
> INIT: Entering runlevel: 3
> Entering non-interactive startup
> FATAL: Could not load /lib/modules/2.6.26.2/modules.dep: No such file or
> directy
> Bringing up loopback interface:  [  OK  ]
> FATAL: Could not load /lib/modules/2.6.26.2/modules.dep: No such file or
> directy
> Starting system logger: [  OK  ]
> Starting kernel logger: [  OK  ]
> Starting rpcbind: [  OK  ]
> Mounting NFS filesystems:  [  OK  ]
> Mounting other filesystems:  [  OK  ]
> Starting powerpmac:  ubus: module license 'PRIVATE' taints kernel.
> ubus started
> [  OK  ]
> Starting xinetd: [  OK  ]
> 
> DENX ELDK version 4.2 build 2008-04-01
> Linux 2.6.26.2 on a ppc
> 
> canyonlands login: 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

