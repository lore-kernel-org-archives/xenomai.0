MIME-Version: 1.0
In-Reply-To: <1288042994.26618.206.camel@domain.hid>
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>
	<4CC20AD2.4060501@domain.hid>
	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>
	<4CC44C02.4050003@domain.hid>
	<AANLkTinjUHYvNJwcuEd2RQuQLWL3WvGx-jFb5iG88f0c@domain.hid>
	<AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>
	<AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>
	<4CC5603E.1090707@domain.hid> <4CC566A2.2000702@domain.hid>
	<AANLkTik76N-mL6ogtzFJ_vX4NF=7oDc_zdCA_y33z+Jh@domain.hid>
	<AANLkTimp5_OXSo_EGkn6O0mexR1Oxb_m9SJEfPmrSf0M@mail.gmail.com>
	<AANLkTi=Ne35gXZ=BRo09eXRjEtvPaXnkp6ix9tMWUwvn@domain.hid>
	<4CC5C93E.70503@domain.hid>
	<AANLkTimS7-CEvA74Viwu4mLm9-O_NpakXYG7=FXK1L1f@domain.hid>
	<4CC5DD1F.4090405@domain.hid> <1288041712.26618.189.camel@domain.hid>
	<4CC5F612.8040508@domain.hid> <1288042994.26618.206.camel@domain.hid>
Date: Mon, 25 Oct 2010 17:58:37 -0700
Message-ID: <AANLkTikFj6tvYiQk13hsBxCe1oOuny2xee5UcAgKCTtO@mail.gmail.com>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016364ef2cee39b7c04937a9b20
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

--0016364ef2cee39b7c04937a9b20
Content-Type: text/plain; charset=ISO-8859-1

Hey Jan,

Unfortunately, assigning the irq 16 to be handled by only one cpu (which is
what I understand is the result of "echo 1 > /proc/irq/16/smp_affinity") did
not work.
After 3 hours of operation the event got triggered and the disc access
performance decreased. See below...

Well, I don't know what to try out next. Please let me know if you have any
idea of how to debug this.

Thanks so much,
 peter


###############################################################

[13536.435172] Pid: 0, comm: swapper Tainted: P
2.6.35-ipipe-2.5.4-slim #2
[13536.435174] Call Trace:
[13536.435176]  <IRQ>  [<ffffffff8108bb56>] __report_bad_irq+0x26/0xa0
[13536.435183]  [<ffffffff8108bd5c>] note_interrupt+0x18c/0x1d0
[13536.435185]  [<ffffffff8108c77d>] handle_fasteoi_irq+0xcd/0x100
[13536.435188]  [<ffffffff8100656d>] handle_irq+0x1d/0x30
[13536.435190]  [<ffffffff81005a40>] do_IRQ+0x70/0x100
[13536.435192]  [<ffffffff81092147>] __ipipe_sync_stage+0x207/0x20d
[13536.435194]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
[13536.435196]  [<ffffffff8109214d>] ? __xirq_end+0x0/0x9c
[13536.435197]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
[13536.435199]  [<ffffffff810926a3>] __ipipe_walk_pipeline+0x113/0x120
[13536.435202]  [<ffffffff81024414>] __ipipe_handle_irq+0x124/0x310
[13536.435204]  [<ffffffff8108bf10>] ? __ipipe_ack_fasteoi_irq+0x0/0x10
[13536.435207]  [<ffffffff814f78d3>] common_interrupt+0x13/0x2c
[13536.435208]  <EOI>  [<ffffffff810249d6>] ? __ipipe_halt_root+0x26/0x40
[13536.435213]  [<ffffffff81061191>] ? atomic_notifier_call_chain+0x11/0x20
[13536.435217]  [<ffffffff8100cbd5>] default_idle+0x45/0x50
[13536.435220]  [<ffffffff8100198a>] cpu_idle+0x7a/0xd0
[13536.435224]  [<ffffffff814e25fc>] rest_init+0xbc/0xd0
[13536.435228]  [<ffffffff817cbe98>] start_kernel+0x47a/0x486
[13536.435230]  [<ffffffff817cb31c>] x86_64_start_reservations+0x12c/0x130
[13536.435232]  [<ffffffff817cb432>] x86_64_start_kernel+0x112/0x119
[13536.435233] handlers:
[13536.435234] [<ffffffff8136ed60>] (usb_hcd_irq+0x0/0xb0)
[13536.435238] [<ffffffffa00c4c30>] (mpt_interrupt+0x0/0xa00 [mptbase])
[13536.435251] Disabling IRQ #16
root@domain.hid:~# cat /proc/irq/16/smp_affinity
01
root@domain.hid:~# hdparm -t /dev/sdg

/dev/sdg:
 Timing buffered disk reads:    8 MB in  3.21 seconds =   2.49 MB/sec

###############################################################




On Mon, Oct 25, 2010 at 2:43 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Mon, 2010-10-25 at 23:26 +0200, Jan Kiszka wrote:
> > Am 25.10.2010 23:21, Philippe Gerum wrote:
> > > On Mon, 2010-10-25 at 21:40 +0200, Jan Kiszka wrote:
> > >> Am 25.10.2010 21:03, Peter Pastor wrote:
> > >>> Hey Jan,
> > >>>
> > >>> I did not apply any ubuntu patch for kernel 2.6.35 (since I do not
> have
> > >>> one).  Also, good to know that I should not use xenomai patches
> together
> > >>> with ubuntu patches.
> > >>>
> > >>> Anyway, the problem occurred as well with the kernel 2.6.35 (see
> attached
> > >>> dmesg_bad_2.6.35)
> > >>> I also attached the config.
> > >>>
> > >>
> > >> ...
> > >>
> > >>> [ 5751.714643] irq 16: nobody cared (try booting with the "irqpoll"
> option)
> > >>> [ 5751.714649] Pid: 0, comm: swapper Tainted: P
>  2.6.35-ipipe-2.5.4-slim #2
> > >>> [ 5751.714653] Call Trace:
> > >>> [ 5751.714655]  <IRQ>  [<ffffffff8108bb56>]
> __report_bad_irq+0x26/0xa0
> > >>> [ 5751.714668]  [<ffffffff8108bd5c>] note_interrupt+0x18c/0x1d0
> > >>> [ 5751.714672]  [<ffffffff8108c77d>] handle_fasteoi_irq+0xcd/0x100
> > >>> [ 5751.714677]  [<ffffffff8100656d>] handle_irq+0x1d/0x30
> > >>> [ 5751.714681]  [<ffffffff81005a40>] do_IRQ+0x70/0x100
> > >>> [ 5751.714685]  [<ffffffff81092147>] __ipipe_sync_stage+0x207/0x20d
> > >>> [ 5751.714689]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
> > >>> [ 5751.714692]  [<ffffffff8109214d>] ? __xirq_end+0x0/0x9c
> > >>> [ 5751.714696]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
> > >>> [ 5751.714700]  [<ffffffff810926a3>]
> __ipipe_walk_pipeline+0x113/0x120
> > >>> [ 5751.714706]  [<ffffffff81024414>] __ipipe_handle_irq+0x124/0x310
> > >>> [ 5751.714708]  [<ffffffff8108bf10>] ?
> __ipipe_ack_fasteoi_irq+0x0/0x10
> > >>> [ 5751.714712]  [<ffffffff814f78d3>] common_interrupt+0x13/0x2c
> > >>> [ 5751.714713]  <EOI>  [<ffffffff810249d6>] ?
> __ipipe_halt_root+0x26/0x40
> > >>> [ 5751.714718]  [<ffffffff81061191>] ?
> atomic_notifier_call_chain+0x11/0x20
> > >>> [ 5751.714722]  [<ffffffff8100cbd5>] default_idle+0x45/0x50
> > >>> [ 5751.714725]  [<ffffffff8100198a>] cpu_idle+0x7a/0xd0
> > >>> [ 5751.714728]  [<ffffffff814f14a1>] start_secondary+0x1c1/0x1c5
> > >>> [ 5751.714730] handlers:
> > >>> [ 5751.714730] [<ffffffff8136ed60>] (usb_hcd_irq+0x0/0xb0)
> > >>> [ 5751.714735] [<ffffffffa00bac30>] (mpt_interrupt+0x0/0xa00
> [mptbase])
> > >>> [ 5751.714747] Disabling IRQ #16
> > >>
> > >> I'm not yet sure, but a first thought: We have a shared fasteoi IRQ
> > >> here, and we are on SMP. Compared to vanilla, the fasteoi flow of
> ipipe
> > >> looks so much different to me ATM that I tend to believe two cores end
> > >> up having this IRQ queued at the same time. One runs first and handles
> > >> all triggers, the second bails out like above.
> > >>
> > >> Philippe, we _end_ fasteoi in the ipipe ack path. Do we mask them
> prior
> > >> to this? What prevents a second IRQ arriving after this early eoi?
> > >
> > > All fasteoi handlers are supposed to mask+ack when the pipeline is
> > > enabled,
> >
> > What am I missing? The code I was looking at (__ipipe_ack_fasteoi) just
> > does a regular eoi at chip level.
>
> Have a look at the chip handlers.
>
> >
> > > to avoid interrupt storm due to the deferral we may introduce
> > > in the irq delivery. I do see this in the regular ioapic chip
> > > descriptor, but this is lacking with interrupt remap. I guess we could
> > > have a problem with Intel IOMMUs.
> >
> > IOMMUs should blow up the system anyway once a PCI driver is used in the
> > RT domain (DMA remapping involved Linux locks and may even allocate
> > memory). Guess we should add a !IPIPE to their Kconfig entries.
> >
>
> Yes, would make sense.
>
> > Jan
> >
>
> --
> Philippe.
>
>
>

--0016364ef2cee39b7c04937a9b20
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Jan,<br><br>Unfortunately, assigning the irq 16 to be handled by only o=
ne cpu (which is what I understand is the result of &quot;echo 1 &gt; /proc=
/irq/16/smp_affinity&quot;) did not work.<br>After 3 hours  of operation th=
e event got triggered and the disc access performance decreased. See below.=
..<br>
<br>Well, I don&#39;t know what to try out next. Please let me know if you =
have any idea of how to debug this.<br><br>Thanks so much, <br>=A0peter<br>=
<br><br>###############################################################<br>

<br>[13536.435172] Pid: 0, comm: swapper Tainted: P=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 2.6.35-ipipe-2.5.4-slim #2<br>[13536.435174] Call Trace:<br>[1353=
6.435176]=A0 &lt;IRQ&gt;=A0 [&lt;ffffffff8108bb56&gt;] __report_bad_irq+0x2=
6/0xa0<br>[13536.435183]=A0 [&lt;ffffffff8108bd5c&gt;] note_interrupt+0x18c=
/0x1d0<br>
[13536.435185]=A0 [&lt;ffffffff8108c77d&gt;] handle_fasteoi_irq+0xcd/0x100<=
br>[13536.435188]=A0 [&lt;ffffffff8100656d&gt;] handle_irq+0x1d/0x30<br>[13=
536.435190]=A0 [&lt;ffffffff81005a40&gt;] do_IRQ+0x70/0x100<br>[13536.43519=
2]=A0 [&lt;ffffffff81092147&gt;] __ipipe_sync_stage+0x207/0x20d<br>
[13536.435194]=A0 [&lt;ffffffff810059d0&gt;] ? do_IRQ+0x0/0x100<br>[13536.4=
35196]=A0 [&lt;ffffffff8109214d&gt;] ? __xirq_end+0x0/0x9c<br>[13536.435197=
]=A0 [&lt;ffffffff810059d0&gt;] ? do_IRQ+0x0/0x100<br>[13536.435199]=A0 [&l=
t;ffffffff810926a3&gt;] __ipipe_walk_pipeline+0x113/0x120<br>
[13536.435202]=A0 [&lt;ffffffff81024414&gt;] __ipipe_handle_irq+0x124/0x310=
<br>[13536.435204]=A0 [&lt;ffffffff8108bf10&gt;] ? __ipipe_ack_fasteoi_irq+=
0x0/0x10<br>[13536.435207]=A0 [&lt;ffffffff814f78d3&gt;] common_interrupt+0=
x13/0x2c<br>
[13536.435208]=A0 &lt;EOI&gt;=A0 [&lt;ffffffff810249d6&gt;] ? __ipipe_halt_=
root+0x26/0x40<br>[13536.435213]=A0 [&lt;ffffffff81061191&gt;] ? atomic_not=
ifier_call_chain+0x11/0x20<br>[13536.435217]=A0 [&lt;ffffffff8100cbd5&gt;] =
default_idle+0x45/0x50<br>
[13536.435220]=A0 [&lt;ffffffff8100198a&gt;] cpu_idle+0x7a/0xd0<br>[13536.4=
35224]=A0 [&lt;ffffffff814e25fc&gt;] rest_init+0xbc/0xd0<br>[13536.435228]=
=A0 [&lt;ffffffff817cbe98&gt;] start_kernel+0x47a/0x486<br>[13536.435230]=
=A0 [&lt;ffffffff817cb31c&gt;] x86_64_start_reservations+0x12c/0x130<br>
[13536.435232]=A0 [&lt;ffffffff817cb432&gt;] x86_64_start_kernel+0x112/0x11=
9<br>[13536.435233] handlers:<br>[13536.435234] [&lt;ffffffff8136ed60&gt;] =
(usb_hcd_irq+0x0/0xb0)<br>[13536.435238] [&lt;ffffffffa00c4c30&gt;] (mpt_in=
terrupt+0x0/0xa00 [mptbase])<br>
[13536.435251] Disabling IRQ #16<br>root@domain.hid:~# cat /proc/irq/16/smp_affi=
nity <br>01<br>root@domain.hid:~# hdparm -t /dev/sdg<br><br>/dev/sdg:<br>=A0Timi=
ng buffered disk reads:=A0=A0=A0 8 MB in=A0 3.21 seconds =3D=A0=A0 2.49 MB/=
sec<br><br>###############################################################<=
br>

<br><br><br><br><div class=3D"gmail_quote">On Mon, Oct 25, 2010 at 2:43 PM,=
 Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rp=
m@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Mon, 2010-10-25 at 23:26 +0200, Jan Ki=
szka wrote:<br>
&gt; Am 25.10.2010 23:21, Philippe Gerum wrote:<br>
&gt; &gt; On Mon, 2010-10-25 at 21:40 +0200, Jan Kiszka wrote:<br>
&gt; &gt;&gt; Am 25.10.2010 21:03, Peter Pastor wrote:<br>
&gt; &gt;&gt;&gt; Hey Jan,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I did not apply any ubuntu patch for kernel 2.6.35 (since=
 I do not have<br>
&gt; &gt;&gt;&gt; one). =A0Also, good to know that I should not use xenomai=
 patches together<br>
&gt; &gt;&gt;&gt; with ubuntu patches.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Anyway, the problem occurred as well with the kernel 2.6.=
35 (see attached<br>
&gt; &gt;&gt;&gt; dmesg_bad_2.6.35)<br>
&gt; &gt;&gt;&gt; I also attached the config.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ...<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; [ 5751.714643] irq 16: nobody cared (try booting with the=
 &quot;irqpoll&quot; option)<br>
&gt; &gt;&gt;&gt; [ 5751.714649] Pid: 0, comm: swapper Tainted: P =A0 =A0 =
=A0 =A0 =A0 =A02.6.35-ipipe-2.5.4-slim #2<br>
&gt; &gt;&gt;&gt; [ 5751.714653] Call Trace:<br>
&gt; &gt;&gt;&gt; [ 5751.714655] =A0&lt;IRQ&gt; =A0[&lt;ffffffff8108bb56&gt=
;] __report_bad_irq+0x26/0xa0<br>
&gt; &gt;&gt;&gt; [ 5751.714668] =A0[&lt;ffffffff8108bd5c&gt;] note_interru=
pt+0x18c/0x1d0<br>
&gt; &gt;&gt;&gt; [ 5751.714672] =A0[&lt;ffffffff8108c77d&gt;] handle_faste=
oi_irq+0xcd/0x100<br>
&gt; &gt;&gt;&gt; [ 5751.714677] =A0[&lt;ffffffff8100656d&gt;] handle_irq+0=
x1d/0x30<br>
&gt; &gt;&gt;&gt; [ 5751.714681] =A0[&lt;ffffffff81005a40&gt;] do_IRQ+0x70/=
0x100<br>
&gt; &gt;&gt;&gt; [ 5751.714685] =A0[&lt;ffffffff81092147&gt;] __ipipe_sync=
_stage+0x207/0x20d<br>
&gt; &gt;&gt;&gt; [ 5751.714689] =A0[&lt;ffffffff810059d0&gt;] ? do_IRQ+0x0=
/0x100<br>
&gt; &gt;&gt;&gt; [ 5751.714692] =A0[&lt;ffffffff8109214d&gt;] ? __xirq_end=
+0x0/0x9c<br>
&gt; &gt;&gt;&gt; [ 5751.714696] =A0[&lt;ffffffff810059d0&gt;] ? do_IRQ+0x0=
/0x100<br>
&gt; &gt;&gt;&gt; [ 5751.714700] =A0[&lt;ffffffff810926a3&gt;] __ipipe_walk=
_pipeline+0x113/0x120<br>
&gt; &gt;&gt;&gt; [ 5751.714706] =A0[&lt;ffffffff81024414&gt;] __ipipe_hand=
le_irq+0x124/0x310<br>
&gt; &gt;&gt;&gt; [ 5751.714708] =A0[&lt;ffffffff8108bf10&gt;] ? __ipipe_ac=
k_fasteoi_irq+0x0/0x10<br>
&gt; &gt;&gt;&gt; [ 5751.714712] =A0[&lt;ffffffff814f78d3&gt;] common_inter=
rupt+0x13/0x2c<br>
&gt; &gt;&gt;&gt; [ 5751.714713] =A0&lt;EOI&gt; =A0[&lt;ffffffff810249d6&gt=
;] ? __ipipe_halt_root+0x26/0x40<br>
&gt; &gt;&gt;&gt; [ 5751.714718] =A0[&lt;ffffffff81061191&gt;] ? atomic_not=
ifier_call_chain+0x11/0x20<br>
&gt; &gt;&gt;&gt; [ 5751.714722] =A0[&lt;ffffffff8100cbd5&gt;] default_idle=
+0x45/0x50<br>
&gt; &gt;&gt;&gt; [ 5751.714725] =A0[&lt;ffffffff8100198a&gt;] cpu_idle+0x7=
a/0xd0<br>
&gt; &gt;&gt;&gt; [ 5751.714728] =A0[&lt;ffffffff814f14a1&gt;] start_second=
ary+0x1c1/0x1c5<br>
&gt; &gt;&gt;&gt; [ 5751.714730] handlers:<br>
&gt; &gt;&gt;&gt; [ 5751.714730] [&lt;ffffffff8136ed60&gt;] (usb_hcd_irq+0x=
0/0xb0)<br>
&gt; &gt;&gt;&gt; [ 5751.714735] [&lt;ffffffffa00bac30&gt;] (mpt_interrupt+=
0x0/0xa00 [mptbase])<br>
&gt; &gt;&gt;&gt; [ 5751.714747] Disabling IRQ #16<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I&#39;m not yet sure, but a first thought: We have a shared f=
asteoi IRQ<br>
&gt; &gt;&gt; here, and we are on SMP. Compared to vanilla, the fasteoi flo=
w of ipipe<br>
&gt; &gt;&gt; looks so much different to me ATM that I tend to believe two =
cores end<br>
&gt; &gt;&gt; up having this IRQ queued at the same time. One runs first an=
d handles<br>
&gt; &gt;&gt; all triggers, the second bails out like above.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Philippe, we _end_ fasteoi in the ipipe ack path. Do we mask =
them prior<br>
&gt; &gt;&gt; to this? What prevents a second IRQ arriving after this early=
 eoi?<br>
&gt; &gt;<br>
&gt; &gt; All fasteoi handlers are supposed to mask+ack when the pipeline i=
s<br>
&gt; &gt; enabled,<br>
&gt;<br>
&gt; What am I missing? The code I was looking at (__ipipe_ack_fasteoi) jus=
t<br>
&gt; does a regular eoi at chip level.<br>
<br>
</div></div>Have a look at the chip handlers.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; &gt; to avoid interrupt storm due to the deferral we may introduce<br>
&gt; &gt; in the irq delivery. I do see this in the regular ioapic chip<br>
&gt; &gt; descriptor, but this is lacking with interrupt remap. I guess we =
could<br>
&gt; &gt; have a problem with Intel IOMMUs.<br>
&gt;<br>
&gt; IOMMUs should blow up the system anyway once a PCI driver is used in t=
he<br>
&gt; RT domain (DMA remapping involved Linux locks and may even allocate<br=
>
&gt; memory). Guess we should add a !IPIPE to their Kconfig entries.<br>
&gt;<br>
<br>
</div>Yes, would make sense.<br>
<br>
&gt; Jan<br>
&gt;<br>
<br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016364ef2cee39b7c04937a9b20--

