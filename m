MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Sat, 16 Dec 2017 23:01:35 +0000
Message-ID: <CAKJ14NcLeYWfjRdLnagFo9ZaukU3Bq8W8sPV1sC4LOD4OUgp8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>
> I pushed a pile of RTnet fixes in a WIP branch of the official repo
> (wip/rtnet-fixes). Most of them address invalid direct references to
> user memory from kernel space (instead of properly copying back and
> forth via the copy_from/to_user interface), which are badly wrong at any
> rate, even breaking the kernel on SMAP-enabled x86 platforms.
>
> Most I/O calls were affected, ioctl, sendmsg and recvmsg. I'm still in
> the early process of testing the changes gradually, which involves
> running tests for all socket levels (RAW, DGRAM) and protocols (INET,
> PACKET) enabled.
>
> If you depend on RTnet and want to help with testing, you may want to
> give this branch a try. Any help with reviewing the changes would be
> beneficial to the project too.
>

I merged the most recent ipipe version for the 4.9.y kernel into
4.9.69 and patched it with xenomai 3 from the WIP branch (see snip1
below). The kernel boots on the Wandboard with an imx.6 quad. I then
can load the rtnet modules including the rt_fec.ko driver for the FEC
MAC on the imx.6 SoC (see snip2 below) and rtping works. I compiled
and started a udp server [1] that I know works on a similar setup with
the 4.1.y kernel. However, I still see a page domain fault (see snip3
below). That seems to happen somewhere early on in the rt_udp_bind()
function.... I'm currently compiling the 4.9 kernel with debug symbols
to see where it exactly happens. I'll continue looking into it
tomorrow...

A.





[1] http://www.binarytides.com/programming-udp-sockets-c-linux/

<snip1>
debian@arm:~$ cat /proc/version
Linux version 4.9.69-armv7-x6 (agl@TheMint) (gcc version 6.4.1
20171012 (Linaro GCC 6.4-2017.11) ) #5 SMP Sat Dec 16 20:05:17 GMT
2017
debian@arm:~$ cat /proc/xenomai/version
3.0.6
debian@arm:~$ cat /proc/rtnet/version
RTnet for Xenomai v3.0.6
RTcap:      yes
rtnetproxy: yes
bug checks: no
</snip1>

<snip2>
debian@arm:~$ lsmod
Module                  Size  Used by
rt_fec                 16499  1
rtpacket                9149  0
rtudp                  14691  2
rtipv4                 41477  1 rtudp
rt_loopback             1825  1
rtnet                  57796  5 rtipv4,rt_loopback,rtpacket,rt_fec,rtudp
...
</snip2>

<snip3>
root@arm:/home/debian# env LD_LIBRARY_PATH=/usr/xenomai/lib ./server
[ 3425.960029] Unhandled fault: page domain fault (0x01b) at 0xbef98c0a
[ 3425.966405] pgd = ebbbc000
[ 3425.969125] [bef98c0a] *pgd=8f8f1831
[ 3425.972739] Internal error: : 1b [#2] SMP ARM
[ 3425.977107] Modules linked in: rt_fec rtpacket rtudp rtipv4
rt_loopback rtnet caam_jr iptable_nat nf_conntrack_ipv4 ]
[ 3426.024101] CPU: 0 PID: 1822 Comm: server Tainted: G      D
4.9.69-armv7-x6 #5
[ 3426.032028] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[ 3426.038564] I-pipe domain: Linux
[ 3426.041803] task: ecf2e1c0 task.stack: eb330000
[ 3426.046366] PC is at rt_udp_bind+0x2c/0x38c [rtudp]
[ 3426.051268] LR is at rt_udp_ioctl+0xa4/0xb4 [rtudp]
[ 3426.056158] pc : [<bf4af3c0>]    lr : [<bf4afa24>]    psr: 200e0013
[ 3426.056158] sp : eb331e68  ip : bf4af3ac  fp : eb331ea4
[ 3426.067647] r10: bef98c08  r9 : ed4df824  r8 : 00000003
[ 3426.072882] r7 : 0000fef8  r6 : ed4df800  r5 : 40080022  r4 : c160418c
[ 3426.079419] r3 : eb331ea8  r2 : 00040945  r1 : bef98c08  r0 : ed4df824
[ 3426.085956] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 3426.093100] Control: 10c5387d  Table: 3bbbc04a  DAC: 00000051
[ 3426.098856] Process server (pid: 1822, stack limit = 0xeb330220)
[ 3426.104874] Stack: (0xeb331e68 to 0xeb332000)
[ 3426.109247] 1e60:                   00000000 00000051 ed4df800
c160418c 00000003 c160418c
[ 3426.117441] 1e80: 40080022 ed4df800 c160418c 00000003 40080022
c15159b4 eb331ecc eb331ea8
[ 3426.125632] 1ea0: bf4afa24 bf4af3a0 bef98c08 00040945 eb331fb0
ed4df800 c1517cf4 800e0013
[ 3426.133824] 1ec0: eb331f10 eb331ed0 c0299dd0 bf4af98c c027dedc
c01183a4 00000000 bef989c8
[ 3426.142015] 1ee0: eb331f18 00040945 eb331fb0 00000052 c160504c
f0936008 00000001 c029eb3c
[ 3426.150207] 1f00: c15159b4 eb331f2c eb331f20 c029eb54 c0299d2c
40080022 bef989c8 bef989c8
[ 3426.158398] 1f20: eb331f64 eb331f30 c02ac9a0 c029eb48 40080022
00000000 eb331fa4 eed959b4
[ 3426.166589] 1f40: 00000001 eed969b4 c160504c c1820600 c1820600
c15159b4 eb331fac eb331f68
[ 3426.174780] 1f60: c02236bc c02ac874 c15159b4 c1517cf4 c1820600
eb331fb0 c1820600 200e0013
[ 3426.182973] 1f80: b6f476e0 bef989c8 40080022 00000003 000f0042
c0109668 eb330000 00000002
[ 3426.191164] 1fa0: 00000000 eb331fb0 c01095b4 c02235b0 10000050
00000003 40080022 bef989c8
[ 3426.199355] 1fc0: bef989c8 40080022 00000003 000f0042 00000000
00000000 b6f70000 00000000
[ 3426.207545] 1fe0: b6f470dc bef989a8 00000000 b6f2ee72 000e0030
10000050 ffffffff ffffffff
[ 3426.215770] [<bf4af3c0>] (rt_udp_bind [rtudp]) from [<bf4afa24>]
(rt_udp_ioctl+0xa4/0xb4 [rtudp])
[ 3426.224681] [<bf4afa24>] (rt_udp_ioctl [rtudp]) from [<c0299dd0>]
(rtdm_fd_ioctl+0xb4/0x214)
[ 3426.233145] [<c0299dd0>] (rtdm_fd_ioctl) from [<c029eb54>]
(CoBaLt_ioctl+0x18/0x1c)
[ 3426.240823] [<c029eb54>] (CoBaLt_ioctl) from [<c02ac9a0>]
(ipipe_syscall_hook+0x138/0x370)
[ 3426.249109] [<c02ac9a0>] (ipipe_syscall_hook) from [<c02236bc>]
(__ipipe_notify_syscall+0x118/0x1dc)
[ 3426.258266] [<c02236bc>] (__ipipe_notify_syscall) from [<c01095b4>]
(pipeline_syscall+0x8/0x24)
[ 3426.266982] Code: e1a09000 e1a0a001 9a0000cc e30f7ef8 (e1d130b2)
[ 3426.273092] ---[ end trace 08b1f9b9e22886fc ]---
</snip3>

