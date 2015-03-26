MIME-Version: 1.0
In-Reply-To: <20150326145437.GR15125@hermes.click-hack.org>
References: <CAJT0owGYuZ8L47AKM0FdjOw5x3g0cjXcXAFPaL91TaxMun6WBw@mail.gmail.com>
 <20150323220935.GA19836@hermes.click-hack.org>
 <CAJT0owGFHg9cuqWQWYY1y93=Dff9pHUyE+Gct_1=RM2gOwNK_w@mail.gmail.com>
 <20150324160153.GB15125@hermes.click-hack.org>
 <20150324161347.GC15125@hermes.click-hack.org>
 <CAJT0owE5VFmOfH05BZTZ4xZ_8=Co6Anu7VWa3qcW-MLMJK8GTQ@mail.gmail.com>
 <CAJT0owE7vtJDWM289=4cNR_LuUqPWAO60nvg9D0NiTQWeN9Xbg@mail.gmail.com>
 <20150326143151.GM15125@hermes.click-hack.org>
 <CAJT0owEumqaqe+Kd2cRN+cqxx1ZzA905MYE_wbeGv2t61OkNkQ@mail.gmail.com>
 <20150326145437.GR15125@hermes.click-hack.org>
Date: Thu, 26 Mar 2015 16:40:58 +0100
Message-ID: <CAJT0owFNyAPqyu4hRAU1SFdXZQjQkukvWi5sgwHoMijGxO17kQ@mail.gmail.com>
From: Tianchi Huang <gz.eddie.htc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 3.0-rc3 Interruption on Arietta G25
 (AT91SAM9G25 chip)
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

*If i call request_irq and rtdm_irq_request, i've got this warning when the
irq comes in :*

------------[ cut here ]------------
WARNING: CPU: 0 PID: 629 at kernel/irq/handle.c:146
handle_irq_event_percpu+0x70/0x1c0()
irq 28 handler irq_handler+0x0/0x18 [BioS_spi] enabled interrupts
Modules linked in: BioS_spi(O) usb_f_eem g_ether usb_f_rndis u_ether
libcomposite atmel_usba_udc ohci_at91 ohci_hcd
CPU: 0 PID: 629 Comm: udevd Tainted: G           O 3.14.17 #3
[<c000dad4>] (unwind_backtrace) from [<c000b954>] (show_stack+0x10/0x14)
[<c000b954>] (show_stack) from [<c0018b54>] (warn_slowpath_common+0x60/0x80=
)
[<c0018b54>] (warn_slowpath_common) from [<c0018bf4>]
(warn_slowpath_fmt+0x2c/0x3c)
[<c0018bf4>] (warn_slowpath_fmt) from [<c0042490>]
(handle_irq_event_percpu+0x70/0x1c0)
[<c0042490>] (handle_irq_event_percpu) from [<c0042608>]
(handle_irq_event+0x28/0x38)
[<c0042608>] (handle_irq_event) from [<c004484c>]
(handle_simple_irq+0x88/0x90)
[<c004484c>] (handle_simple_irq) from [<c0041dbc>]
(generic_handle_irq+0x20/0x30)
[<c0041dbc>] (generic_handle_irq) from [<c019681c>]
(gpio_irq_handler+0x98/0xd0)
[<c019681c>] (gpio_irq_handler) from [<c005913c>]
(__ipipe_dispatch_irq+0x7c/0x258)
[<c005913c>] (__ipipe_dispatch_irq) from [<c0008624>]
(__ipipe_grab_irq+0x58/0x70)
[<c0008624>] (__ipipe_grab_irq) from [<c000c4a0>] (__irq_svc+0x40/0x4c)
Exception stack(0xcfac1e00 to 0xcfac1e48)
1e00: cf401038 00000001 cfa7fc00 00000011 cfac1ef0 00000000 ceda001d
cfac1ef8
1e20: cfac0000 ceda001c ceda001d cfac1e78 00000000 cfac1e48 c00b34f0
c00b320c
1e40: 60000013 ffffffff
[<c000c4a0>] (__irq_svc) from [<c00b320c>] (__inode_permission+0x8/0x58)
[<c00b320c>] (__inode_permission) from [<c00b34f0>]
(link_path_walk+0x4c/0x724)
[<c00b34f0>] (link_path_walk) from [<c00b6700>] (path_openat+0x1c8/0x524)
[<c00b6700>] (path_openat) from [<c00b6d58>] (do_filp_open+0x2c/0x78)
[<c00b6d58>] (do_filp_open) from [<c00a9f08>] (do_sys_open+0x11c/0x1bc)
[<c00a9f08>] (do_sys_open) from [<c0009620>] (ret_fast_syscall+0x0/0x2c)
---[ end trace 68f2788b079d4fa7 ]---



*Tianchi HUANG*

Ing=C3=A9nieur Informatique en Apprentissage

eddie.huang@bioserenity.com

Tel : +33(0) 6 52 86 29 86



BioSerenity

ICM-iPEPS

47-85 boulevard de l'H=C3=B4pital

75013 Paris


www.bioserenity.com

2015-03-26 15:54 GMT+01:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On Thu, Mar 26, 2015 at 03:52:06PM +0100, Tianchi Huang wrote:
> > Yes, I downloaded the vanilla kernel from kernel.org and then I patched
> it
> > directly with ipipe. What kinds of patches I need to patch?
> > I've looked into the /arch/arm/mach-at91/irq.c
> > and /arch/arm/mach-at91/gipo.c, but i can't find any generic_handle_irq
> but
> > ipipe_handle_multi_irq and ipipe_handle_demuxed_irq.
>
> Yes, this is what I tell you. Maybe some other code is compiled for
> your board, but I do not find anything called at91 in drivers/gpio
> either. Which is why I asked for your kernel configuration to see
> what GPIO driver is compiled.
>
> --
>                                             Gilles.
>
