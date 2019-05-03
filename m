MIME-Version: 1.0
References: <CAPgPmP0GhAroDvwFVR0c6rJP2J1gffHw0=L0p_t9=D9DUoPVVA@mail.gmail.com>
 <e036f069-1aa3-7edc-274d-0362702a0d3f@xenomai.org>
In-Reply-To: <e036f069-1aa3-7edc-274d-0362702a0d3f@xenomai.org>
From: Nitin Kulkarni <nitin.kulkarni@mindmusiclabs.com>
Date: Fri, 3 May 2019 20:53:42 +0200
Message-ID: <CAPgPmP2DzPuFdG3WQ1MXj5r7wp6BC4xH2JOh0qm4x8PHf9FBYQ@mail.gmail.com>
Subject: Re: Request for latest I-pipe arm64 patch
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2 May 2019 at 18:49, Philippe Gerum <rpm@xenomai.org> wrote:

> On 5/2/19 12:38 PM, Nitin Kulkarni via Xenomai wrote:
> > Hello,
> > I am trying to patch a 4.14.78 kernel for arm64 (IMX8m mini), but the
> > latest Ipipe patch for arm64
> > is at 4.9.51 on the downloads page. Is it possible for someone to
> generate
> > latest patch for 4.14.y for arm64 ? (Preferably 4.14.78).
> > I see that the arm64 ipipe kernel is at 4.14.71 but I can't find the
> script
> > to generate patch which was there long time ago.
> >
>
> git diff v4.14.71 is enough with this single-arch tree.
>
> As mentioned in my earlier message to the list, I'm taking over the
> I-pipe ARM64 maintenance, in addition to maintaining ARM. I'll push 4.14
> patches in the coming days.
>
> --
> Philippe.


Thanks Phillipe,  here is what I did.
I got the ipipe patch from a git diff to v4.14.71. I tried to patch it to
the imx8mm kernel from code aurora and had conflicts in the following files
drivers/gpio/gpio-mxc.c and drivers/irqchip/irq-gic-v3.c.

Fixed them manually since they were a couple of hunks which couldn't apply,
the IMX guys have also made some changes to the same code.
(In drivers/irqchip/irq-gic-v3.c the imx8mm kernel has got some extra
IRQCHIP flags enabled.)
When I try to boot the kernel I get this kernel panic.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.480950] Mem abort info:
[    0.483751]   Exception class = IABT (current EL), IL = 32 bits
[    0.489699]   SET = 0, FnV = 0
[    0.492762]   EA = 0, S1PTW = 0
[    0.495913] [0000000000000000] user address but active_mm is swapper
[    0.502303] Internal error: Oops: 86000004 [#1] PREEMPT SMP
[    0.507901] Modules linked in:
[    0.510966] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.14.78+ge7405910ca55 #1
[    0.518225] Hardware name: CompuLab UCM i.MX8MM board (DT)
[    0.523737] I-pipe domain: Linux
[    0.526975] task: ffff0000092e1f00 task.stack: ffff0000092d0000
[    0.532928] PC is at 0x0
[    0.535470] LR is at __ipipe_ack_fasteoi_irq+0x1c/0x28
[    0.540625] pc : [<0000000000000000>] lr : [<ffff00000810a01c>] pstate:
000001c5
[    0.548062] sp : ffff000008003f40
...
Call trace:
[    0.725863] [<          (null)>]           (null)
[    0.730592] [<ffff000008165188>] __ipipe_dispatch_irq+0x178/0x1c8
[    0.736715] [<ffff000008081334>] __ipipe_grab_irq+0x5c/0x98
[    0.742314] [<ffff000008081a44>] gic_handle_irq+0x6c/0x11c
[    0.747828] [<ffff000008085224>] handle_arch_irq_pipelined+0x14/0x60
...
[<ffff000008083240>] el1_irq+0xc0/0x154
[    0.849240] [<ffff000008164a8c>] ipipe_unstall_root+0x34/0x50
[    0.855014] [<ffff000008086094>] arch_cpu_idle+0x1c/0x1c8
[    0.860442] [<ffff000008d025f4>] default_idle_call+0x3c/0x44
[    0.866127] [<ffff0000080f405c>] do_idle+0x174/0x1f0
[    0.871114] [<ffff0000080f4284>] cpu_startup_entry+0x24/0x28
[    0.876801] [<ffff000008cfc6f0>] rest_init+0xc8/0xd8
[    0.881792] [<ffff0000091e0b6c>] start_kernel+0x394/0x3a8
[    0.887216] Code: bad PC value
[    0.890284] ---[ end trace 4bd2b664e2e2ddc6 ]---

I want to know if its a good idea to use the current ipipe kernel for IMX8
family of SoCs ?
Looks like the IMX kernel has got some IMX specific changes to irq_chip
drivers which doesn't go well with ipipe.
We are trying to run Xenomai for IMX8M mini from Compulabs.
Thanks a lot for the help.

- Nitin
