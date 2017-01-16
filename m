From: Jerry Huang <jerry.huang@nxp.com>
Date: Mon, 16 Jan 2017 03:26:14 +0000
Message-ID: <DB5PR0401MB18131434CBF68E3283535F4DFE7D0@DB5PR0401MB1813.eurprd04.prod.outlook.com>
References: <DB5PR0401MB1813333E8ACE184B87CFD047FE610@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <978e8199-bc2e-2241-1321-6d94b9c611e4@xenomai.org>
 <DB5PR0401MB18133712C3E024CD9B8CD907FE600@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <057c11d6-1b14-f6a1-f8a3-ddb17e24fc58@xenomai.org>
 <DB5PR0401MB1813914291F050C338CECB00FE790@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <f0c553f1-694f-2c46-2225-7adf0f7f2eb3@xenomai.org>
In-Reply-To: <f0c553f1-694f-2c46-2225-7adf0f7f2eb3@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, Jorge Ramirez <jro@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>


> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Thursday, January 12, 2017 8:04 PM
> To: Jerry Huang <jerry.huang@nxp.com>; Jorge Ramirez <jro@xenomai.org>;
> xenomai@xenomai.org
> Subject: Re: [Xenomai] arm64 support
>=20
> On 01/12/2017 11:24 AM, Jerry Huang wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jorge Ramirez [mailto:jro@xenomai.org]
> >> Sent: Thursday, January 05, 2017 7:09 PM
> >> To: Jerry Huang <jerry.huang@nxp.com>; xenomai@xenomai.org
> >> Subject: Re: [Xenomai] arm64 support
> >>
> >> On 01/05/2017 11:39 AM, Jerry Huang wrote:
> >>> Thanks a lot.
> >>> I sent the request t subscribe this mail list, I don't know if the
> >>> approval is
> >> needed for this request.
> >>> >From the below links, they are about the 96boards.
> >>> I found one boards DragonBoard410c is based on ARM Contxt-A53, but I
> >> didn't find if it is  running ARM32 or ARM64.
> >>> Could you please point out where can I find these information?
> >>>
> >>> Best Regards
> >>> Jerry Huang
> >>
> >> yes, both boards (HiKey and dragon410c) run in 64 bit mode.
> >> We also demoed Android 64bit running Xenomai on the HiKey back at
> >> ELC-A
> >> 2016 to control motors.
> >>
> >> I think I wrote a simple post entry in the 96boards forum [1] about it=
.
> >>
> >> please remember to not top-post when writing to the mailing list.
> >>
> >> [1] http://www.96boards.org/forums/
> > I got the Ipipe patch "ipipe-core-4.1.18-arm64-6.patch" from xenomai
> website and ported it to Linux-4.1.35 with a little modification (for
> kernel/trace/ring_buffer.c file).
> > But when I boot the Linux, I got the kernel panic as below shows, which
> was caused by function "irqs_disabled", who can give more comment how to
> fix it?
> >
>=20
> All arm64 patches present in the DL area are broken, some critical change=
s
> are missing due to a bug in some obscure code extraction script for this
> architecture, do not use them.
>=20
> Please pull the code from the I-pipe git tree instead (branch ipipe-4.1.y=
).
I clone the ipipe repos (git://git.xenomai.org/ipipe.git) and checkout to b=
ranch origin/ipipe-4.1.y.
And using the script ./scripts/ipipe/genpatches.sh to generate the patch "i=
pipe-core-4.1.18-arm64-6.patch",=20
Then applied it to my kernel Linux-4.1.35 with a litter modification (about=
 file kernel/trace/ring_buffer.c).
After building the kernel and booting my board, then I got the kernel panic=
 as the result of patch (ipipe-core-4.1.18-arm64-6.patch) from websit (http=
://xenomai.org/downloads/ipipe/).
Any comment for this issue?
...
[    0.012441] ------------[ cut here ]------------
[    0.017083] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:129 __local_bh_en=
able+0x54/0x60()
[    0.025209] Modules linked in:
[    0.028274] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.35+ #4
[    0.034304] Hardware name: LS1043A RDB Board (DT)
[    0.039024] Call trace:
[    0.041477] [<ffff80000008a538>] dump_backtrace+0x0/0x11c
[    0.046898] [<ffff80000008a668>] show_stack+0x14/0x1c
[    0.051971] [<ffff8000007ab49c>] dump_stack+0x9c/0xc4
[    0.057043] [<ffff8000000b5884>] warn_slowpath_common+0x98/0xd0
[    0.062987] [<ffff8000000b5980>] warn_slowpath_null+0x18/0x20
[    0.068757] [<ffff8000000b8c5c>] __local_bh_enable+0x54/0x60
[    0.074440] [<ffff8000000b8c90>] _local_bh_enable+0x28/0x60
[    0.080035] [<ffff8000000b95ac>] irq_enter+0x4c/0x68
[    0.085021] [<ffff8000000f2b38>] __handle_domain_irq+0x4c/0xd4
[    0.090878] [<ffff8000000825c8>] gic_handle_irq+0x34/0x84
...
[    0.192022] ---[ end trace cb88537fdc8fa200 ]---
[    0.196669] BUG: failure at kernel/irq_work.c:135/irq_work_run_list()!
[    0.203223] Kernel panic - not syncing: BUG!
[    0.207508] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.1.=
35+ #4
[    0.214761] Hardware name: LS1043A RDB Board (DT)
[    0.219480] Call trace:
[    0.221930] [<ffff80000008a538>] dump_backtrace+0x0/0x11c
[    0.227351] [<ffff80000008a668>] show_stack+0x14/0x1c
[    0.232422] [<ffff8000007ab49c>] dump_stack+0x9c/0xc4
[    0.237492] [<ffff8000007aa254>] panic+0xe4/0x228
[    0.242215] [<ffff8000001321b8>] irq_work_run+0x0/0x64
[    0.247373] [<ffff80000013241c>] irq_work_tick+0x54/0x78
[    0.252707] [<ffff800000102f94>] update_process_times+0x54/0x6c
[    0.258651] [<ffff800000103004>] update_root_process_times+0x58/0x64
[    0.265033] [<ffff80000010f780>] tick_periodic+0x44/0xbc
[    0.270367] [<ffff80000010f9e4>] tick_handle_periodic+0x2c/0x80
[    0.276313] [<ffff80000066b918>] arch_timer_handler_phys+0x3c/0x5c
[    0.282520] [<ffff8000000f5bac>] handle_percpu_devid_irq+0x68/0xc8
[    0.288726] [<ffff8000000f2828>] generic_handle_irq+0x34/0x4c
[    0.294496] [<ffff8000000f2b5c>] __handle_domain_irq+0x70/0xd4
[    0.300353] [<ffff8000000825c8>] gic_handle_irq+0x34/0x84


