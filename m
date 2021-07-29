MIME-Version: 1.0
References: <VI1PR04MB404687DFF801F6DFCDCF8617F3EA9@VI1PR04MB4046.eurprd04.prod.outlook.com>
 <7e1e996a-94ac-9522-f3f8-0816c128753f@siemens.com>
In-Reply-To: <7e1e996a-94ac-9522-f3f8-0816c128753f@siemens.com>
From: Peng Fan <van.freenix@gmail.com>
Date: Thu, 29 Jul 2021 16:48:52 +0800
Message-ID: <CAEfxd-8mXL6ojaxGUZmNsrPMNc6f0r_jTktHnZiewVTy=b7QJg@mail.gmail.com>
Subject: Re: IMX8M Nano compatibility
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Kristiansen, Morten (INT)" <Morten.Kristiansen@teledyne.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka via Xenomai <xenomai@xenomai.org> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8829=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:39=E5=86=99=E9=81=93=
=EF=BC=9A

> On 28.07.21 15:47, Kristiansen, Morten (INT) via Xenomai wrote:
> > Hi Everybody.
> >
> > I have a boot problem on IMX8M Nano.
> >
> > NXP provide a ported kernel for their evaluation board based on Linux
> 5.4.70. (https://source.codeaurora.org/external/imx/linux-imx, branch
> imx_5.4.70_2.3.0)
> >
>
> You generally don't want to use this, you want an upstream version.
>

Jan,

Do you see an issue with that version?

THanks,
Peng.


>
> > I managed to modify apply the ipipe-core-5.4.72-arm64-0.patch to apply
> to kernel. It required a few modifications for irq-imx-gpcv2.c.
> >
>
> See https://xenomai.org/pipermail/xenomai/2021-July/045793.html.
>
> Jan
>
> > The following files files was removed during the NXP port:
> > drivers/gpu/ipu-v3/ipu-prv.h
> > drivers/gpu/ipu-v3/ipu-common.c
> >
> > For reference, I=E2=80=99ve attached my revised patch.
> >
> > The end result is the kernel mostly boots fine, but about 1 out of 5 it
> fails with the message below. Has anybody had any luck running Xenomai on
> the IMX8M series?
> >
> > Any help is highly appreciated. =F0=9F=98=8A
> >
> > /Morten Kristiansen
> >
> >
> >
> > [   12.672926] irq 103: nobody cared (try booting with the "irqpoll"
> option)
> > [   12.680938] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 5.4.70-2.3.2+g8c73bc625c4d #1
> > [   12.689246] Hardware name: NXP i.MX8MNano EVK board (DT)
> > [   12.695120] I-pipe domain: Linux
> > [   12.698889] Call trace:
> > [   12.702267]  dump_backtrace+0x0/0x140
> > [   12.706694]  show_stack+0x14/0x20
> > [   12.711023]  dump_stack+0xe4/0x12c
> > [   12.715277]  __report_bad_irq+0x48/0xd8
> > [   12.719873]  note_interrupt+0x2c4/0x37c
> > [   12.724448]  handle_irq_event_percpu+0x80/0x88
> > [   12.729604]  handle_irq_event+0x44/0xd0
> > [   12.734249]  handle_level_irq+0x90/0xe8
> > [   12.739058]  generic_handle_irq+0x24/0x38
> > [   12.743762]  __handle_domain_irq+0x60/0xb8
> > [   12.748789]  __ipipe_do_IRQ+0x28/0x30
> > [   12.753419]  __ipipe_do_sync_stage+0x198/0x1c8
> > [   12.758628]  ipipe_unstall_root+0x40/0x50
> > [   12.763370]  __do_softirq+0xa4/0x248
> > [   12.767896]  irq_exit+0xb8/0xd8
> > [   12.771730]  __handle_domain_irq+0x64/0xb8
> > [   12.776598]  __ipipe_do_IRQ+0x28/0x30
> > [   12.781055]  __ipipe_do_sync_stage+0x198/0x1c8
> > [   12.786295]  ipipe_unstall_root+0x40/0x50
> > [   12.791263]  cpuidle_enter_state+0xa4/0x330
> > [   12.796213]  cpuidle_enter+0x34/0x48
> > [   12.800673]  call_cpuidle+0x18/0x38
> > [   12.804939]  do_idle+0x1f0/0x288
> > [   12.808940]  cpu_startup_entry+0x20/0x50
> > [   12.813665]  rest_init+0xd4/0xe0
> > [   12.817842]  arch_call_rest_init+0xc/0x14
> > [   12.822659]  start_kernel+0x410/0x444
> > [   12.826855] handlers:
> > [   12.829882] [<00000000ab81b488>] irq_default_primary_handler threade=
d
> [<000000002543e636>] _tcpci_irq
> > [   12.840309] Disabling IRQ #103
> > [   24.092075] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [   24.098209] rcu:     0-...0: (5 ticks this GP) idle=3Db8e/0/0x3
> softirq=3D80/80 fqs=3D2621
> > [   24.105801]  (detected by 2, t=3D5252 jiffies, g=3D-959, q=3D16)
> > [   24.111304] Task dump for CPU 0:
> > [   24.114554] swapper/0       R  running task        0     0      0
> 0x0000002a
> > [   24.121611] Call trace:
> > [   24.124099]  __switch_to+0x108/0x1c0
> > [   24.127695]  0x18
> >
> >
> > Teledyne Confidential; Commercially Sensitive Business Data
> > -------------- next part --------------
> > A non-text attachment was scrubbed...
> > Name: imx-ipipe-core-5.4.72-arm64-0.patch
> > Type: application/octet-stream
> > Size: 515901 bytes
> > Desc: imx-ipipe-core-5.4.72-arm64-0.patch
> > URL: <
> http://xenomai.org/pipermail/xenomai/attachments/20210728/4fde70e5/attach=
ment.obj
> >
> >
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
>

--
