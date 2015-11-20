Message-ID: <B7E9A6C055724C8F931591A5C2DD07C8@itd206>
From: "Sureshvs" <sureshvs@datapatterns.co.in>
Date: Fri, 20 Nov 2015 12:22:15 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Reg: Linux assertion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: aditya <aditya.kumar@industeqsite.com>, sureshvsmca@gmail.com


Hi

ARCH=3DpowerPC
Processor: MPC8641
Linux Kernel : 2.6.30
Xenomai patch version: xenomai-2.5.2


We are getting the below assertion randomly.

kindly help us to isolate the problem, stack trace during assertion is =
given below.


------------[ cut here ]------------
Badness at a00384e8 [verbose debug info unavailable]
NIP: a00384e8 LR: a0038568 CTR: a037455c
REGS: a05c3ac0 TRAP: 0700   Not tainted  (2.6.30-dpvpx0689)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22028024  XER: 00000000
TASK =3D a0556530[0] 'swapper' THREAD: a05c2000 CPU: 0
GPR00: 00000001 a05c3b70 a0556530 00000001 a05c3bc8 00000004 00009032 =
00000000
GPR08: 00009032 a05e0000 a054fcb0 00000000 22028042 afbffe3d 7fed9700 =
7ff4a000
GPR16: cedd9380 00008000 00000040 a05c2000 00000000 00000001 cf8d3800 =
a0630000
GPR24: a05d9188 a05b988c 00000004 a05c3bc8 cedd9000 a05c2000 a05b97ac =
a05c2000
NIP [a00384e8] local_bh_enable_ip+0x30/0xd0
LR [a0038568] local_bh_enable_ip+0xb0/0xd0
Call Trace:
[a05c3b70] [a0402354] _read_lock_bh+0x28/0x3c (unreliable)
[a05c3b80] [a0402180] _read_unlock_bh+0x38/0x48
[a05c3b90] [a032f6d4] neigh_lookup+0xe0/0x174
[a05c3bc0] [a0375528] arp_process+0x1c8/0x6c4
[a05c3c40] [a032b094] netif_receive_skb+0x2ac/0x408
[a05c3c70] [a02b8f4c] gfar_clean_rx_ring+0x400/0x424
[a05c3cb0] [a02b916c] gfar_poll+0x1fc/0x388
[a05c3d00] [a032682c] net_rx_action+0x18c/0x21c
[a05c3d40] [a0038ab0] __do_softirq+0xfc/0x24c
[a05c3d90] [a0005e70] do_softirq+0x8c/0x90
[a05c3da0] [a0038660] irq_exit+0xd8/0xdc
[a05c3db0] [a000d708] __ipipe_do_IRQ+0x94/0xd8
[a05c3dd0] [a006ff14] __ipipe_sync_stage+0x2d4/0x328
[a05c3e20] [a000c8c0] __ipipe_handle_irq+0x1b4/0x1b8
[a05c3e60] [a000c914] __ipipe_grab_irq+0x50/0x200
[a05c3ea0] [a0016594] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at cpu_idle+0xb8/0x108
    LR =3D cpu_idle+0xac/0x108
[a05c3f60] [a000a450] cpu_idle+0x68/0x108 (unreliable)
[a05c3f80] [a0004114] rest_init+0x80/0xac
[a05c3fa0] [a051d890] start_kernel+0x30c/0x38c
[a05c3ff0] [00003764] 0x3764
Instruction dump:
7c0802a6 9421fff0 93e1000c 543f0024 90010014 801f000c 740903ff 41820090
3d20a05e 800993a0 21600000 7c0b0114 <0f000000> 2f800000 409e008c =
813f000c



Regards
suresh V.S

