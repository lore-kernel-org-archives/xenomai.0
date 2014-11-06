Date: Thu, 6 Nov 2014 11:57:20 +0100 (CET)
From: tbultel@free.fr
Message-ID: <637400768.107888843.1415271440604.JavaMail.root@zimbra90-e16.priv.proxad.net>
In-Reply-To: <20141105205917.GA28595@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



----- Mail original -----
De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
=C3=80: "Thierry Bultel" <tbultel@free.fr>
Cc: xenomai@xenomai.org, "TREDEZ jean-Baptiste (GE Healthcare, non-ge)" <Je=
an-baptiste.tredez@basystemes.fr>
Envoy=C3=A9: Mercredi 5 Novembre 2014 21:59:17
Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 + adeos-ipipe-3.0.43-mx6q-1.18=
-14 -> very slow boot

On Wed, Nov 05, 2014 at 09:38:47PM +0100, Thierry Bultel wrote:
> Hi,
> I have applied the adeos-ipipe-3.0.43-mx6q-1.18-14.patch provided with
> xenomai-2.6.4 ,
> onto the rel_imx_3.0.35_4.1.0 kernel

Have you tried commit d97b871cc396738ff62293df6b4ba78ade44b6d2
for which the patch is made?

--=20
=09=09=09=09=09    Gilles.
Hi Gilles,
I can't afford going on that commit, it is a too old kernel and my BSP
patch does not apply on it.
Meanwhile, I have fixed the slowness issue, I had not payed enough
attention to some rejections when applying the ipipe patch.

But this leads to the reason why I was interested in taking your latest
ipipe patch.
We used to work with the previous one, which was in 3 pieces (pre-x-post).

We are facing random kernel crashes when using the eth intensively.
(ping -i 0.01 -s 65000)
That crashs happen with both ipipe patches versions.

That random freeze only happen on some machines ( 3 machines on a total
of 17 are impacted), that first had let us think about an hardware bug.
(There are no CPU revs differences between those machines)
But after some testing, the crash does not happen with a non-patched
3.0.35_4.1.0 kernel, or with a patched kernel that has CONFIG_IPIPE
disabled.
The freeze sometimes gives a backtrace on the serial port, sometimes not.
See a backtrace sample below. It has rarely the same shape.

By doing some code re-reading, and performing some dichotomy,
I found out that removing the mb() call in bufdesc_read_status() ....

static inline unsigned short bufdesc_read_status(struct bufdesc *bdp)
{
#if 0
#ifdef CONFIG_ARCH_MX6
=09mb();
#endif /* CONFIG_ARCH_MX6 */
#endif /* 0 */
=09return bdp->cbd_sc;

}

... makes the freeze less reproducible (a machine that froze in less
than 10 secs stayed alive for 2h30)

I noticed that the call mb() is not done on more recent kernels.
It is introduced by the Ipipe patch.
I do not understand neither why it makes the freeze happen, nor why it
is part of the ipipe patch.
What is your opinion about that ?

Regards,
Thierry

The backtrace:

[root@SGT_AGV2 ~]# Unable to handle kernel NULL pointer dereference at
virtual address 0000011c
pgd =3D 80004000
[0000011c] *pgd=3D00000000
Internal error: Oops: 17 [#2] PREEMPT SMP
Modules linked in: adv7180_tvin
CPU: 3    Tainted: G      D      (3.0.35_4.1.0 #1)
PC is at dev_alloc_skb+0x20/0x3c
LR is at dev_alloc_skb+0x18/0x3c
pc : [<8054bd2c>]    lr : [<8054bd24>]    psr: 20000113
sp : bff01e48  ip : 00000066  fp : 00000040
r10: 00000000  r9 : 00000040  r8 : 00000084
r7 : 00000001  r6 : bffec000  r5 : 00000020  r4 : 00000800
r3 : 80c89204  r2 : 00000000  r1 : 00000020  r0 : 00000084
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 4449004a  DAC: 00000015
Process swapper (pid: 0, stack limit =3D 0xbff002f0)
Stack: (0xbff01e48 to 0xbff02000)
1e40:                   ffffffff 00000800 ffdfd108 bffec000 00000001
bffecec8
1e60: 80c88890 8054bd24 00000005 803f2430 bffece50 00000066 4446d020
b446d020
1e80: bffec250 80cbc320 00000080 bffecec8 00000001 0000012c 8c02a080
80c700a0
1ea0: 00000040 8c02a088 bff00000 80556648 ffff85a3 bff00000 00000020
00000001
1ec0: 00000003 0000000c bff00000 80c70070 00000010 80c7006c 80cd9ae0
800913d0
1ee0: 80c75f34 bfc21cc0 00000102 bff00020 00000003 0000000a 80060b74
80c88da8
1f00: 800499cc 00000096 00000000 80c88da8 00000010 80c9cfc0 00000004
8009195c
1f20: 00000270 80051e18 800461b8 00000099 80ce8960 00400000 00000001
800d1f38
1f40: 80d120a0 800467e8 80ce9c80 800494c8 b45201a0 bff01f80 f2a00100
00000096
1f60: 80c8c08c 1000406a bff00000 00000000 00000000 8005bc78 ffffffff
80050ec0
1f80: 20000000 0000001d 00000000 f40dc010 8c0267e8 80cdacc4 80667b04
80c8c08c
1fa0: 1000406a 412fc09a 00000000 00000000 00000001 bff01fc8 80061db0
800605ec
1fc0: 20000013 ffffffff bff00000 00000003 80667b04 800520f4 bff00000
800522d4
1fe0: 80659ffc 4ff0406a 00000015 10c03c7d 80cdae78 1065a014 00000000
00000000
[<8054bd2c>] (dev_alloc_skb+0x20/0x3c) from [<00000800>] (0x800)
Code: e3e03000 ebffffc1 e3500000 08bd8008 (e5902098)
---[ end trace 072d847414ccbc44 ]---
Kernel panic - not syncing: Fatal exception in interrupt
[<800586ac>] (unwind_backtrace+0x0/0xf8) from [<8065de10>]
(panic+0x64/0x180)
[<8065de10>] (panic+0x64/0x180) from [<80054efc>] (die+0x228/0x28c)
[<80054efc>] (die+0x228/0x28c) from [<8065d064>]
(__do_kernel_fault.part.4+0x54/0x74)
[<8065d064>] (__do_kernel_fault.part.4+0x54/0x74) from [<8005d454>]
(do_page_fault+0x214/0x3e4)
[<8005d454>] (do_page_fault+0x214/0x3e4) from [<8004b404>]
(do_DataAbort+0x34/0x17c)
[<8004b404>] (do_DataAbort+0x34/0x17c) from [<80050e50>]
(__dabt_svc+0x70/0xa0)
Exception stack(0xbff01e00 to 0xbff01e48)
1e00: 00000084 00000020 00000000 80c89204 00000800 00000020 bffec000
00000001
1e20: 00000084 00000040 00000000 00000040 00000066 bff01e48 8054bd24
8054bd2c
1e40: 20000113 ffffffff
[<80050e50>] (__dabt_svc+0x70/0xa0) from [<8054bd2c>]
(dev_alloc_skb+0x20/0x3c)
[<8054bd2c>] (dev_alloc_skb+0x20/0x3c) from [<00000800>] (0x800)
CPU2: stopping
[<800586ac>] (unwind_backtrace+0x0/0xf8) from [<8004b3a8>]
(do_IPI+0x12c/0x154)
[<8004b3a8>] (do_IPI+0x12c/0x154) from [<800d1f38>]
(__ipipe_sync_stage+0x254/0x270)
Exception stack(0xbffb5f40 to 0xbffb5f88)
5f40: 80d120a0 800467e8 80ce8a80 800494c8 8c01c7e8 bffb5f80 f2a00100
00000c06
5f60: 80c8c08c 1000406a bffb4000 00000000 00000000 8004b214 ffffffff
80050ec0
5f80: 20000000 0000001d
[<800d1f38>] (__ipipe_sync_stage+0x254/0x270) from [<8004b214>]
(__ipipe_grab_ipi+0x30/0x98)
[<8004b214>] (__ipipe_grab_ipi+0x30/0x98) from [<80050ec0>]
(__irq_svc+0x40/0xd4)
Exception stack(0xbffb5f80 to 0xbffb5fc8)
5f80: 20000000 0000001d 00000000 f40dc010 8c01c7e8 80cdacc4 80667b04
80c8c08c
5fa0: 1000406a 412fc09a 00000000 00000000 00000001 bffb5fc8 80061db0
800605ec
5fc0: 20000013 ffffffff
[<80050ec0>] (__irq_svc+0x40/0xd4) from [<800605ec>]
(cpu_v7_do_idle+0x8/0xc)
[<800605ec>] (cpu_v7_do_idle+0x8/0xc) from [<4ffb806a>] (0x4ffb806a)
CPU0: stopping
[<800586ac>] (unwind_backtrace+0x0/0xf8) from [<8004b3a8>]
(do_IPI+0x12c/0x154)
[<8004b3a8>] (do_IPI+0x12c/0x154) from [<800d1f38>]
(__ipipe_sync_stage+0x254/0x270)
Exception stack(0x80c6ff18 to 0x80c6ff60)
ff00:                                                       80d120a0
800467e8
ff20: 80ce8a80 800494c8 8c0087e8 80c6ff58 f2a00100 00000c06 80c8c08c
1000406a
ff40: 80c6e000 00000000 00000000 8004b214 ffffffff 80050ec0 20000000
0000001d
[<800d1f38>] (__ipipe_sync_stage+0x254/0x270) from [<8004b214>]
(__ipipe_grab_ipi+0x30/0x98)
[<8004b214>] (__ipipe_grab_ipi+0x30/0x98) from [<80050ec0>]
(__irq_svc+0x40/0xd4)
Exception stack(0x80c6ff58 to 0x80c6ffa0)
ff40:                                                       20000000
0000001d
ff60: 00000000 f40dc010 8c0087e8 80cdacc4 80667b04 80c8c08c 1000406a
412fc09a
ff80: 00000000 00000000 00000001 80c6ffa0 80061db0 800605ec 200f0013
ffffffff
[<80050ec0>] (__irq_svc+0x40/0xd4) from [<800605ec>]
(cpu_v7_do_idle+0x8/0xc)
[<800605ec>] (cpu_v7_do_idle+0x8/0xc) from [<80c88c24>] (0x80c88c24)
CPU1: stopping
[<800586ac>] (unwind_backtrace+0x0/0xf8) from [<8004b3a8>]
(do_IPI+0x12c/0x154)
[<8004b3a8>] (do_IPI+0x12c/0x154) from [<800d1f38>]
(__ipipe_sync_stage+0x254/0x270)
Exception stack(0xbffadf40 to 0xbffadf88)
df40: 80d120a0 800467e8 80ce8a80 800494c8 8c0127e8 bffadf80 f2a00100
00000c06
df60: 80c8c08c 1000406a bffac000 00000000 00000000 8004b214 ffffffff
80050ec0
df80: 20000000 0000001d
[<800d1f38>] (__ipipe_sync_stage+0x254/0x270) from [<8004b214>]
(__ipipe_grab_ipi+0x30/0x98)
[<8004b214>] (__ipipe_grab_ipi+0x30/0x98) from [<80050ec0>]
(__irq_svc+0x40/0xd4)
Exception stack(0xbffadf80 to 0xbffadfc8)
df80: 20000000 0000001d 00000000 f40dc010 8c0127e8 80cdacc4 80667b04
80c8c08c
dfa0: 1000406a 412fc09a 00000000 00000000 00000001 bffadfc8 80061db0
800605ec
dfc0: 200f0013 ffffffff
[<80050ec0>] (__irq_svc+0x40/0xd4) from [<800605ec>]
(cpu_v7_do_idle+0x8/0xc)
[<800605ec>] (cpu_v7_do_idle+0x8/0xc) from [<4ffb006a>] (0x4ffb006a)

