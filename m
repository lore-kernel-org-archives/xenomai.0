MIME-Version: 1.0
References: <CAOuPNLgBrZKCJuZkJdYPa4rwU-9+acYd=VomxPceuLFNQdZC9g@mail.gmail.com>
 <CAOuPNLgm1QU5EH+BVDdwXFnQ2qoosJ=59K+LnLF3ubu7V62jaA@mail.gmail.com>
In-Reply-To: <CAOuPNLgm1QU5EH+BVDdwXFnQ2qoosJ=59K+LnLF3ubu7V62jaA@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Mon, 11 Feb 2019 15:22:51 +0530
Message-ID: <CAOuPNLg1mmqzdrjBGuJAbnu5bLG0dEfDZdSP9w83WAHcrAXPbw@mail.gmail.com>
Subject: Re: kernel panic issue with IPIPE disabled for arm64
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jorge Ramirez <jro@xenomai.org>

Hi,
In the Xenomai SoC porting document:
https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_SOC

I read this:
{{{
When you boot the kernel without CONFIG_IPIPE, the timer code should be
almost not modified, except maybe for timer acknowledgement, so, if at
this point the kernel does not work, it probably means that you got the
timer acknowledgement wrong.
}}}

I am facing almost the similar issue.
So, when I disable CONFIG_IPIPE and CONFIG_XENOMAI, my kernel does not
boot normally.
I guess when you disable IPIPE, all code related to timer modification
will be also disabled.

But, I could not understand the above statement.
What is meant by timer acknowledgement here ?
I feel timer acknowledgement remains same like normal kernel.

Can someone explain about it?


Thanks,
Pintu

On Fri, Feb 8, 2019 at 4:50 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 3:50 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Hi All,
> >
> > I recently ported ipipe-arm64 and xenomai patches on Kernel 4.9.
> > But there were some issues so I disabled the XENOMAI/IPIPE config.
> >
> > Now, when I boot the same working working without IPIPE, I get kernel
> > panic issue.
> >
> > So, I am wondering what could be the impact if IPIPE is already disabled.
> > Is there some issues in ipipe which is fixed recently ?
> > Or, if this already known please let me know.
> >
> > [   21.578785] VFS: Mounted root (ext4 filesystem) readonly on device 8:6.
> > [   21.588181] devtmpfs: mounted
> > [   21.599961] Freeing unused kernel memory: 6528K
> > [   21.662796] BUG: sleeping function called from invalid context at
> > kernel/locking/rwsem.c:65
> > [   21.671231] in_atomic(): 0, irqs_disabled(): 128, pid: 1, name: init
> > [   21.677662] ------------[ cut here ]------------
> > [   21.682334] kernel BUG at kernel/sched/core.c:8490!
> > [   21.687281] ------------[ cut here ]------------
> > [   21.691957] kernel BUG at kernel/sched/core.c:8490!
> > [   21.696891] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [   21.702437] Modules linked in:
> > [   21.705591] CPU: 0 PID: 1 Comm: init Not tainted 4.9.103+ #111
> >
> > [   21.718691] task: ffffffc330440080 task.stack: ffffffc330448000
> > [   21.724686] PC is at ___might_sleep+0x140/0x188
> > [   21.729272] LR is at ___might_sleep+0x128/0x188
> > [   21.733862] pc : [<ffffff9688ce65a8>] lr : [<ffffff9688ce6590>]
> > pstate: 604001c5
> > [   21.741330] sp : ffffffc33044bba0
> > ....
> > [   21.944945] Process init (pid: 1, stack limit = 0xffffffc330448000)
> > [   21.951286] Call trace:
> > [   21.953785] Exception stack(0xffffffc33044b9a0 to 0xffffffc33044bad0)
> > ....
> > [   22.031465] bac0: 0000000000000462 0000000000000006
> > [   22.036406] [<ffffff9688ce65a8>] ___might_sleep+0x140/0x188
> > [   22.042041] [<ffffff9688ce6648>] __might_sleep+0x58/0x90
> > [   22.047428] [<ffffff9689d43f84>] down_write_killable+0x2c/0x80
> > [   22.053328] [<ffffff9688e53cd8>] setup_arg_pages+0xb8/0x208
> > [   22.058972] [<ffffff9688eb7534>] load_elf_binary+0x434/0x1298
> > [   22.064786] [<ffffff9688e55674>] search_binary_handler+0xac/0x1f0
> > [   22.070952] [<ffffff9688e560ec>] do_execveat_common.isra.15+0x504/0x6c8
> > [   22.077631] [<ffffff9688e562f4>] do_execve+0x44/0x58
> > [   22.082658] [<ffffff9688c84030>] run_init_process+0x38/0x48
> > [   22.088291] [<ffffff9689d3db1c>] kernel_init+0x8c/0x108
> > [   22.093578] [<ffffff9688c83f00>] ret_from_fork+0x10/0x50
> > [   22.098960] Code: b9453800 0b000020 6b00027f 540000c1 (d4210000)
> > [   22.105136] ---[ end trace fe061c4391feccb8 ]---
> > [   22.117057] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x0000000b
> > [   22.117057]
> >
>
> Dear Philippe,
>
> Are you already aware about this issue ?
> Have you seen this issue before ?
> Looks like there is some clash between ipipe patches and normal kernel
> scenarios (some where).
>
> If this issue is already fixed, please let me know.
> If this issue is not seen, then also let me know, so that I can debug further.
>
> Thanks,
> Pintu

