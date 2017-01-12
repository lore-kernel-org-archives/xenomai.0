From: Jerry Huang <jerry.huang@nxp.com>
Date: Thu, 12 Jan 2017 10:24:29 +0000
Message-ID: <DB5PR0401MB1813914291F050C338CECB00FE790@DB5PR0401MB1813.eurprd04.prod.outlook.com>
References: <DB5PR0401MB1813333E8ACE184B87CFD047FE610@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <978e8199-bc2e-2241-1321-6d94b9c611e4@xenomai.org>
 <DB5PR0401MB18133712C3E024CD9B8CD907FE600@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <057c11d6-1b14-f6a1-f8a3-ddb17e24fc58@xenomai.org>
In-Reply-To: <057c11d6-1b14-f6a1-f8a3-ddb17e24fc58@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] arm64 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez <jro@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



> -----Original Message-----
> From: Jorge Ramirez [mailto:jro@xenomai.org]
> Sent: Thursday, January 05, 2017 7:09 PM
> To: Jerry Huang <jerry.huang@nxp.com>; xenomai@xenomai.org
> Subject: Re: [Xenomai] arm64 support
>=20
> On 01/05/2017 11:39 AM, Jerry Huang wrote:
> > Thanks a lot.
> > I sent the request t subscribe this mail list, I don't know if the appr=
oval is
> needed for this request.
> > >From the below links, they are about the 96boards.
> > I found one boards DragonBoard410c is based on ARM Contxt-A53, but I
> didn't find if it is  running ARM32 or ARM64.
> > Could you please point out where can I find these information?
> >
> > Best Regards
> > Jerry Huang
>=20
> yes, both boards (HiKey and dragon410c) run in 64 bit mode.
> We also demoed Android 64bit running Xenomai on the HiKey back at ELC-A
> 2016 to control motors.
>=20
> I think I wrote a simple post entry in the 96boards forum [1] about it.
>=20
> please remember to not top-post when writing to the mailing list.
>=20
> [1] http://www.96boards.org/forums/
I got the Ipipe patch "ipipe-core-4.1.18-arm64-6.patch" from xenomai websit=
e and ported it to Linux-4.1.35 with a little modification (for kernel/trac=
e/ring_buffer.c file).
But when I boot the Linux, I got the kernel panic as below shows, which was=
 caused by function "irqs_disabled", who can give more comment how to fix i=
t?

[    0.012441] ------------[ cut here ]------------
[    0.017084] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:129 __local_bh_en=
able+0x54/0x60()
[    0.025211] Modules linked in:
[    0.028276] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.35+ #3
[    0.034305] Hardware name: LS1043A RDB Board (DT)
[    0.039025] Call trace:
[    0.041478] [<ffff80000008a538>] dump_backtrace+0x0/0x11c
[    0.046899] [<ffff80000008a668>] show_stack+0x14/0x1c
[    0.051972] [<ffff8000007ab49c>] dump_stack+0x9c/0xc4
[    0.057043] [<ffff8000000b5884>] warn_slowpath_common+0x98/0xd0
[    0.062987] [<ffff8000000b5980>] warn_slowpath_null+0x18/0x20
[    0.068757] [<ffff8000000b8c5c>] __local_bh_enable+0x54/0x60
[    0.074439] [<ffff8000000b8c90>] _local_bh_enable+0x28/0x60
[    0.080035] [<ffff8000000b95ac>] irq_enter+0x4c/0x68
[    0.085021] [<ffff8000000f2b38>] __handle_domain_irq+0x4c/0xd4
[    0.090877] [<ffff8000000825c8>] gic_handle_irq+0x34/0x84
....
[    0.192022] ---[ end trace cb88537fdc8fa200 ]---
[    0.196668] BUG: failure at kernel/irq_work.c:135/irq_work_run_list()!
[    0.203222] Kernel panic - not syncing: BUG!
[    0.207507] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.1.=
35+ #3
[    0.214759] Hardware name: LS1043A RDB Board (DT)
[    0.219478] Call trace:
[    0.221929] [<ffff80000008a538>] dump_backtrace+0x0/0x11c
[    0.227350] [<ffff80000008a668>] show_stack+0x14/0x1c
[    0.232420] [<ffff8000007ab49c>] dump_stack+0x9c/0xc4
[    0.237491] [<ffff8000007aa254>] panic+0xe4/0x228
[    0.242214] [<ffff8000001321b8>] irq_work_run+0x0/0x64
[    0.247371] [<ffff80000013241c>] irq_work_tick+0x54/0x78
[    0.252706] [<ffff800000102f94>] update_process_times+0x54/0x6c
[    0.258650] [<ffff800000103004>] update_root_process_times+0x58/0x64
[    0.265032] [<ffff80000010f780>] tick_periodic+0x44/0xbc
[    0.270366] [<ffff80000010f9e4>] tick_handle_periodic+0x2c/0x80
[    0.276312] [<ffff80000066b918>] arch_timer_handler_phys+0x3c/0x5c
[    0.282519] [<ffff8000000f5bac>] handle_percpu_devid_irq+0x68/0xc8
[    0.288726] [<ffff8000000f2828>] generic_handle_irq+0x34/0x4c
[    0.294496] [<ffff8000000f2b5c>] __handle_domain_irq+0x70/0xd4
[    0.300352] [<ffff8000000825c8>] gic_handle_irq+0x34/0x84

