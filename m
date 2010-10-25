MIME-Version: 1.0
In-Reply-To: <4CC5E887.9050703@domain.hid>
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
	<4CC5DD1F.4090405@domain.hid> <4CC5E887.9050703@domain.hid>
Date: Mon, 25 Oct 2010 14:10:34 -0700
Message-ID: <AANLkTi=pkzz=OghXUWEFqFLoxVT7PKicH6Fiq2Vx-yr1@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=001636426fdb53af7e0493776c5b
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--001636426fdb53af7e0493776c5b
Content-Type: text/plain; charset=ISO-8859-1

Hey Jan,

THANKS a lot for your response !!

I added "echo 1 > /proc/irq/16/smp_affinity" to rc.local and rebooted the
system. I confirmed that after the reboot the entry is set to "01" (before
it was "ff"). I will let you know whether the problem occurs again.
I am not sure whether irqbalance is running on my system (ps ax does not
show anything). So I didn't start/stop anything.

Can binding the IRQ #16 to a single core cause any problems ? Or does it
only cause some more latency (in the linux domain) ?

THANKS,
 peter

root@domain.hid:~# cat /proc/irq/16/spurious
count 88
unhandled 0
last_unhandled 0 ms






On Mon, Oct 25, 2010 at 1:28 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Am 25.10.2010 21:40, Jan Kiszka wrote:
> > Am 25.10.2010 21:03, Peter Pastor wrote:
> >> Hey Jan,
> >>
> >> I did not apply any ubuntu patch for kernel 2.6.35 (since I do not have
> >> one).  Also, good to know that I should not use xenomai patches together
> >> with ubuntu patches.
> >>
> >> Anyway, the problem occurred as well with the kernel 2.6.35 (see
> attached
> >> dmesg_bad_2.6.35)
> >> I also attached the config.
> >>
> >
> > ...
> >
> >> [ 5751.714643] irq 16: nobody cared (try booting with the "irqpoll"
> option)
> >> [ 5751.714649] Pid: 0, comm: swapper Tainted: P
>  2.6.35-ipipe-2.5.4-slim #2
> >> [ 5751.714653] Call Trace:
> >> [ 5751.714655]  <IRQ>  [<ffffffff8108bb56>] __report_bad_irq+0x26/0xa0
> >> [ 5751.714668]  [<ffffffff8108bd5c>] note_interrupt+0x18c/0x1d0
> >> [ 5751.714672]  [<ffffffff8108c77d>] handle_fasteoi_irq+0xcd/0x100
> >> [ 5751.714677]  [<ffffffff8100656d>] handle_irq+0x1d/0x30
> >> [ 5751.714681]  [<ffffffff81005a40>] do_IRQ+0x70/0x100
> >> [ 5751.714685]  [<ffffffff81092147>] __ipipe_sync_stage+0x207/0x20d
> >> [ 5751.714689]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
> >> [ 5751.714692]  [<ffffffff8109214d>] ? __xirq_end+0x0/0x9c
> >> [ 5751.714696]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
> >> [ 5751.714700]  [<ffffffff810926a3>] __ipipe_walk_pipeline+0x113/0x120
> >> [ 5751.714706]  [<ffffffff81024414>] __ipipe_handle_irq+0x124/0x310
> >> [ 5751.714708]  [<ffffffff8108bf10>] ? __ipipe_ack_fasteoi_irq+0x0/0x10
> >> [ 5751.714712]  [<ffffffff814f78d3>] common_interrupt+0x13/0x2c
> >> [ 5751.714713]  <EOI>  [<ffffffff810249d6>] ?
> __ipipe_halt_root+0x26/0x40
> >> [ 5751.714718]  [<ffffffff81061191>] ?
> atomic_notifier_call_chain+0x11/0x20
> >> [ 5751.714722]  [<ffffffff8100cbd5>] default_idle+0x45/0x50
> >> [ 5751.714725]  [<ffffffff8100198a>] cpu_idle+0x7a/0xd0
> >> [ 5751.714728]  [<ffffffff814f14a1>] start_secondary+0x1c1/0x1c5
> >> [ 5751.714730] handlers:
> >> [ 5751.714730] [<ffffffff8136ed60>] (usb_hcd_irq+0x0/0xb0)
> >> [ 5751.714735] [<ffffffffa00bac30>] (mpt_interrupt+0x0/0xa00 [mptbase])
> >> [ 5751.714747] Disabling IRQ #16
> >
> > I'm not yet sure, but a first thought: We have a shared fasteoi IRQ
> > here, and we are on SMP. Compared to vanilla, the fasteoi flow of ipipe
> > looks so much different to me ATM that I tend to believe two cores end
> > up having this IRQ queued at the same time. One runs first and handles
> > all triggers, the second bails out like above.
> >
> > Philippe, we _end_ fasteoi in the ipipe ack path. Do we mask them prior
> > to this? What prevents a second IRQ arriving after this early eoi?
> >
>
> Slowly getting more confident in this theory. Peter, you could increase
> the confidence further by binding the IRQ #16 to a single core (e.g.
> echo 1 > /proc/irq/16/smp_affinity, make sure to stop irqbalance first
> in case it's running).
>
> Moreover, edge handling looks similarly broken: We ack the IRQ early,
> there is no further masking, but we do not block delivery /wrt other
> cores - in contrast to Linux which has IRQ_INPROGRESS, checked and set
> atomically along with the ack (if I-pipe is off). And this issue should
> not only affect Linux, Xenomai may get equally unhappy if ever faced
> with a bunch of shared edge RT-IRQs on a SMP box. Uff.
>
> Jan
>
>

--001636426fdb53af7e0493776c5b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Jan,<br><br>THANKS a lot for your response !!<br><br>I added &quot;echo=
 1 &gt; /proc/irq/16/smp_affinity&quot; to rc.local and rebooted the system=
. I confirmed that after the reboot the entry is set to &quot;01&quot; (bef=
ore it was &quot;ff&quot;). I will let you know whether the problem occurs =
again.<br>
I am not sure whether irqbalance is running on my system (ps ax does not sh=
ow anything). So I didn&#39;t start/stop anything.<br><br>Can binding the I=
RQ #16 to a single core cause any problems ? Or does it only cause some mor=
e latency (in the linux domain) ?<br>
<br>THANKS,<br>=A0peter<br><br>root@domain.hid:~# cat /proc/irq/16/spurious <br>=
count 88<br>unhandled 0<br>last_unhandled 0 ms<br><br><br><br><br><br><br><=
div class=3D"gmail_quote">On Mon, Oct 25, 2010 at 1:28 PM, Jan Kiszka <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>=
&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div><div></div><=
div class=3D"h5">Am 25.10.2010 21:40, Jan Kiszka wrote:<br>
&gt; Am 25.10.2010 21:03, Peter Pastor wrote:<br>
&gt;&gt; Hey Jan,<br>
&gt;&gt;<br>
&gt;&gt; I did not apply any ubuntu patch for kernel 2.6.35 (since I do not=
 have<br>
&gt;&gt; one). =A0Also, good to know that I should not use xenomai patches =
together<br>
&gt;&gt; with ubuntu patches.<br>
&gt;&gt;<br>
&gt;&gt; Anyway, the problem occurred as well with the kernel 2.6.35 (see a=
ttached<br>
&gt;&gt; dmesg_bad_2.6.35)<br>
&gt;&gt; I also attached the config.<br>
&gt;&gt;<br>
&gt;<br>
&gt; ...<br>
&gt;<br>
&gt;&gt; [ 5751.714643] irq 16: nobody cared (try booting with the &quot;ir=
qpoll&quot; option)<br>
&gt;&gt; [ 5751.714649] Pid: 0, comm: swapper Tainted: P =A0 =A0 =A0 =A0 =
=A0 =A02.6.35-ipipe-2.5.4-slim #2<br>
&gt;&gt; [ 5751.714653] Call Trace:<br>
&gt;&gt; [ 5751.714655] =A0&lt;IRQ&gt; =A0[&lt;ffffffff8108bb56&gt;] __repo=
rt_bad_irq+0x26/0xa0<br>
&gt;&gt; [ 5751.714668] =A0[&lt;ffffffff8108bd5c&gt;] note_interrupt+0x18c/=
0x1d0<br>
&gt;&gt; [ 5751.714672] =A0[&lt;ffffffff8108c77d&gt;] handle_fasteoi_irq+0x=
cd/0x100<br>
&gt;&gt; [ 5751.714677] =A0[&lt;ffffffff8100656d&gt;] handle_irq+0x1d/0x30<=
br>
&gt;&gt; [ 5751.714681] =A0[&lt;ffffffff81005a40&gt;] do_IRQ+0x70/0x100<br>
&gt;&gt; [ 5751.714685] =A0[&lt;ffffffff81092147&gt;] __ipipe_sync_stage+0x=
207/0x20d<br>
&gt;&gt; [ 5751.714689] =A0[&lt;ffffffff810059d0&gt;] ? do_IRQ+0x0/0x100<br=
>
&gt;&gt; [ 5751.714692] =A0[&lt;ffffffff8109214d&gt;] ? __xirq_end+0x0/0x9c=
<br>
&gt;&gt; [ 5751.714696] =A0[&lt;ffffffff810059d0&gt;] ? do_IRQ+0x0/0x100<br=
>
&gt;&gt; [ 5751.714700] =A0[&lt;ffffffff810926a3&gt;] __ipipe_walk_pipeline=
+0x113/0x120<br>
&gt;&gt; [ 5751.714706] =A0[&lt;ffffffff81024414&gt;] __ipipe_handle_irq+0x=
124/0x310<br>
&gt;&gt; [ 5751.714708] =A0[&lt;ffffffff8108bf10&gt;] ? __ipipe_ack_fasteoi=
_irq+0x0/0x10<br>
&gt;&gt; [ 5751.714712] =A0[&lt;ffffffff814f78d3&gt;] common_interrupt+0x13=
/0x2c<br>
&gt;&gt; [ 5751.714713] =A0&lt;EOI&gt; =A0[&lt;ffffffff810249d6&gt;] ? __ip=
ipe_halt_root+0x26/0x40<br>
&gt;&gt; [ 5751.714718] =A0[&lt;ffffffff81061191&gt;] ? atomic_notifier_cal=
l_chain+0x11/0x20<br>
&gt;&gt; [ 5751.714722] =A0[&lt;ffffffff8100cbd5&gt;] default_idle+0x45/0x5=
0<br>
&gt;&gt; [ 5751.714725] =A0[&lt;ffffffff8100198a&gt;] cpu_idle+0x7a/0xd0<br=
>
&gt;&gt; [ 5751.714728] =A0[&lt;ffffffff814f14a1&gt;] start_secondary+0x1c1=
/0x1c5<br>
&gt;&gt; [ 5751.714730] handlers:<br>
&gt;&gt; [ 5751.714730] [&lt;ffffffff8136ed60&gt;] (usb_hcd_irq+0x0/0xb0)<b=
r>
&gt;&gt; [ 5751.714735] [&lt;ffffffffa00bac30&gt;] (mpt_interrupt+0x0/0xa00=
 [mptbase])<br>
&gt;&gt; [ 5751.714747] Disabling IRQ #16<br>
&gt;<br>
&gt; I&#39;m not yet sure, but a first thought: We have a shared fasteoi IR=
Q<br>
&gt; here, and we are on SMP. Compared to vanilla, the fasteoi flow of ipip=
e<br>
&gt; looks so much different to me ATM that I tend to believe two cores end=
<br>
&gt; up having this IRQ queued at the same time. One runs first and handles=
<br>
&gt; all triggers, the second bails out like above.<br>
&gt;<br>
&gt; Philippe, we _end_ fasteoi in the ipipe ack path. Do we mask them prio=
r<br>
&gt; to this? What prevents a second IRQ arriving after this early eoi?<br>
&gt;<br>
<br>
</div></div>Slowly getting more confident in this theory. Peter, you could =
increase<br>
the confidence further by binding the IRQ #16 to a single core (e.g.<br>
echo 1 &gt; /proc/irq/16/smp_affinity, make sure to stop irqbalance first<b=
r>
in case it&#39;s running).<br>
<br>
Moreover, edge handling looks similarly broken: We ack the IRQ early,<br>
there is no further masking, but we do not block delivery /wrt other<br>
cores - in contrast to Linux which has IRQ_INPROGRESS, checked and set<br>
atomically along with the ack (if I-pipe is off). And this issue should<br>
not only affect Linux, Xenomai may get equally unhappy if ever faced<br>
with a bunch of shared edge RT-IRQs on a SMP box. Uff.<br>
<font color=3D"#888888"><br>
Jan<br>
<br>
</font></blockquote></div><br>

--001636426fdb53af7e0493776c5b--

