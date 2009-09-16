MIME-Version: 1.0
In-Reply-To: <72cf3fb0909151542h163e7c03h1a393a969caf0c58@domain.hid>
References: <9c789a000909130535j4dc046a1h3af2976ab504a000@domain.hid>
	<72cf3fb0909151542h163e7c03h1a393a969caf0c58@domain.hid>
Date: Wed, 16 Sep 2009 11:14:21 +0300
Message-ID: <9c789a000909160114h4a3b5ebbj46e1abfeed07f61c@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0016364d2a31736f140473ad7c94
Subject: Re: [Xenomai-help] Comedi port over Xenomai fault question !
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

--0016364d2a31736f140473ad7c94
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Sep 16, 2009 at 1:42 AM, Alexis Berlemont <berlemont.hauw@domain.hid>wrote:

> Hi,
>
> > I've took a snapshot of the xenomai-abe (Comedi port related) git repos
> > pointing to the last update and tried it up and it seems that are some
> > errors.
>
> That is very nice of you to test the driver on your board. I had read
> your former mail and was about to ask you to test the code on your
> configuration.
>
> >
> > /usr/xenomai/sbin # ./comedi_config -v comedi0 comedi_pcimio
> > Comedi: comedi_pcimio: pcimio_attach: found pci-6024e board
> > Comedi: MITE: 0x90000000 mapped to c907a000 <6>Comedi: DAQ: 0x90001000
> > mapped to c907c000
> > Comedi: MITE: version = 2, type = 1, mite mode = 1, interface mode = 3
> > Comedi: MITE: num channels = 1, write post fifo depth = 1, wins = 0,
> iowins
> > = 2
> > Comedi: comedi_pcimio: pcimio_attach: found irq 48
> > Unable to handle kernel paging request for data at address 0x00012400
> > Faulting instruction address: 0xc023dd08
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > MPC831x RDB
> > Modules linked in:
> > NIP: c023dd08 LR: c0246b70 CTR: 00000000
> > REGS: c7a51c30 TRAP: 0300   Not tainted  (2.6.24.2)
> > MSR: 00001032 <ME,IR,DR>  CR: 84008422  XER: 00000000
> > DAR: 00012400, DSISR: 20000000
> > TASK = c7864430[898] 'comedi_config' THREAD: c7a50000
> > GPR00: c0246b70 c7a51ce0 c7864430 00012400 00000001 00000000 c79062c0
> > c03c0000
> > GPR08: 00000000 c7900a00 c03d6144 c03a37e8 c7906200 1004a5b8 c033e0b8
> > c03c0000
> > GPR16: c03ba578 c03d1a00 c02464fc c03b4d60 c0244e5c c024509c c024535c
> > c0245380
> > GPR24: c03da628 c02453a4 20001040 00000000 00000000 c03a2e50 c03c0000
> > 00012400
> > Call Trace:
> > [c7a51ce0] [c024bae0]  (unreliable)
> > [c7a51d00] [c0246b70]
> > [c7a51d20] [c0246bdc]
> > [c7a51d40] [c024b88c]
> > [c7a51d90] [c024c69c]
> > [c7a51dc0] [c0238b2c]
> > [c7a51de0] [c0238c64]
> > [c7a51e20] [c0239094]
> > [c7a51e40] [c023ba00]
> > [c7a51e70] [c008b404]
> > [c7a51eb0] [c008d634]
> > [c7a51ec0] [c0059eb8]
> > [c7a51ee0] [c004ad5c]
> > [c7a51f30] [c0009644]
> > [c7a51f40] [c0010ca4]
> > --- Exception: c01Instruction dump:
> > 7d6b1a14 39290010 38000001 7fe34a14 900b00b0 90ff0010 4bffff9c 9421ffe0
> > 7c0802a6 bf61000c 7c7f1b78 90010024 <83c30000> 7c0000a6 5400045e 7c000124
> > ---[ end trace f35e90f95f5de008 ]---
> >
> >
> > A quick disassembly shows that the error is generated in the mite driver
> as
> > pointed next,
> >
> > c023dcf4 <mite_release_channel>:
> > mite_release_channel():
> >
> /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/drivers/xenomai/comedi/national_instruments/mite.c:308
> > c023dcf4:    94 21 ff e0     stwu    r1,-32(r1)
> > c023dcf8:    7c 08 02 a6     mflr    r0
> > c023dcfc:    bf 61 00 0c     stmw    r27,12(r1)
> > c023dd00:    7c 7f 1b 78     mr      r31,r3
> > c023dd04:    90 01 00 24     stw     r0,36(r1)
> >
> /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/drivers/xenomai/comedi/national_instruments/mite.c:309
> > c023dd08:    83 c3 00 00     lwz     r30,0(r3)
> >
>
> Without any access on you board, I have no other solution but to ask
> you to add some debug traces in the driver so as to locate the
> problem:
>
> Could you try these two patches and send me the results. On my side,
> this driver (partly) works on the NI 6221 board plugged into some x86
> motherboard. Your configuration (6024e + PPC) is not that close but it
> is just a segfault, we will figure this out quite quickly with ugly
> printks.
>
>
> diff --git a/ksrc/drivers/comedi/national_instruments/mite.c
> b/ksrc/drivers/comedi/national_instruments/mite.c
> index 8f1ccd7..56013d0 100644
> --- a/ksrc/drivers/comedi/national_instruments/mite.c
> +++ b/ksrc/drivers/comedi/national_instruments/mite.c
> @@ -309,6 +309,22 @@ void mite_release_channel(struct mite_channel
> *mite_chan)
>       struct mite_struct *mite = mite_chan->mite;
>       unsigned long flags;
>
> +#if 1 /* debug */
> +       int i;
> +
> +       printk("mite_release_channel: mite_chan = %p\n", mite_chan);
> +       printk("mite_release_channel: mite_chan->channel = %p\n",
> +              mite_chan->channel);
> +       printk("mite_release_channel: mite = %p\n", mite);
> +       printk("mite_release_channel: mite->mite_io_addr = %p\n",
> +              mite->mite_io_addr);
> +       for (i = 0; i < MAX_MITE_DMA_CHANNELS; i++) {
> +               printk("mite_release_channel: \talloc[%d] = %u\n",
> +                      i, mite->channel_allocated[i]);
> +       }
> +
> +#endif /* debug */
> +
>       // spin lock to prevent races with mite_request_channel
>       comedi_lock_irqsave(&mite->lock, flags);
>       if (mite->channel_allocated[mite_chan->channel]) {
> @@ -318,13 +334,24 @@ void mite_release_channel(struct mite_channel
> *mite_chan)
>                       CHCR_CLR_MRDY_IE | CHCR_CLR_DRDY_IE |
>                       CHCR_CLR_LC_IE | CHCR_CLR_CONT_RB_IE,
>                       mite->mite_io_addr + MITE_CHCR(mite_chan->channel));
> +#if 1 /* debug */
> +               printk("mite_release_channel: before disarm\n");
> +#endif /* debug */
>               mite_dma_disarm(mite_chan);
> +#if 1 /* debug */
> +               printk("mite_release_channel: before reset\n");
> +#endif /* debug */
>               mite_dma_reset(mite_chan);
> +
>               mite->channel_allocated[mite_chan->channel] = 0;
>               mite_chan->ring = NULL;
>               mmiowb();
>       }
>       comedi_unlock_irqrestore(&mite->lock, flags);
> +
> +#if 1 /* debug */
> +               printk("mite_release_channel: out\n");
> +#endif /* debug */
>  }
>
>  void mite_dma_arm(struct mite_channel *mite_chan)
>
>
> diff --git a/ksrc/drivers/comedi/national_instruments/mio_common.c
> b/ksrc/drivers/comedi/national_instruments/mio_common.c
> index 3f70c3e..e29c2c5 100644
> --- a/ksrc/drivers/comedi/national_instruments/mio_common.c
> +++ b/ksrc/drivers/comedi/national_instruments/mio_common.c
> @@ -424,6 +424,10 @@ void ni_release_ai_mite_channel(comedi_dev_t *dev)
>
>       unsigned long flags;
>
> +#if 1 /* debug */
> +       printk("ni_release_ai_mite_channel: in\n");
> +#endif /* debug */
> +
>       comedi_lock_irqsave(&devpriv->mite_channel_lock, flags);
>       if (devpriv->ai_mite_chan) {
>               ni_set_ai_dma_channel(dev, -1);
> @@ -432,6 +436,10 @@ void ni_release_ai_mite_channel(comedi_dev_t *dev)
>       }
>       comedi_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
>
> +#if 1 /* debug */
> +       printk("ni_release_ai_mite_channel: out\n");
> +#endif /* debug */
> +
>  }
>
>  void ni_release_ao_mite_channel(comedi_dev_t *dev)
>
>
Hy !
I've applied the debug patches and I think that the problem is in the
ni_release_ai_mite_channel function because it seems that
mite_release_channel is never called.
It is possible that comedi_lock_irqsave to cause the problem or
devpriv->ai_mite_chan is NULL ?


here's the output :

/usr/xenomai/sbin # ./comedi_config -v comedi0 comedi_pcimio
Comedi: comedi_pcimio: pcimio_attach: found pci-6024e board
Comedi: MITE: 0x90000000 mapped to c907a000 <6>Comedi: DAQ: 0x90001000
mapped to c907c000
Comedi: MITE: version = 2, type = 1, mite mode = 1, interface mode = 3
Comedi: MITE: num channels = 1, write post fifo depth = 1, wins = 0, iowins
= 2
Comedi: comedi_pcimio: pcimio_attach: found irq 48
*ni_release_ai_mite_channel: in*
Unable to handle kernel paging request for data at address 0x00012400
Faulting instruction address: 0xc023dd18
Oops: Kernel access of bad area, sig: 11 [#1]
MPC831x RDB
Modules linked in:
NIP: c023dd18 LR: c0246c24 CTR: c0033b54
REGS: c7a51c30 TRAP: 0300   Not tainted  (2.6.24.2)
MSR: 00001032 <ME,IR,DR>  CR: 24008422  XER: 00000000
DAR: 00012400, DSISR: 20000000
TASK = c7827430[894] 'comedi_config' THREAD: c7a50000
GPR00: c0246c24 c7a51ce0 c7827430 c033d078 00012400 0001306f 00000000
c03a2f10
GPR08: 00000070 c7900a00 c03d6144 c03a37e8 24008424 1004a5b8 c033e238
c03c0000
GPR16: c03ba578 c03d1a00 c02465a4 c03b4d60 c0244f04 c0245144 c0245404
c0245428
GPR24: c03da628 c024544c 20001040 00000000 00012400 c03a2e50 c03c0000
00000001
Call Trace:
[c7a51ce0] [c03f20a8]  (unreliable)
[c7a51d00] [c0246c24]
[c7a51d20] [c0246c9c]
[c7a51d40] [c024b94c]
[c7a51d90] [c024c75c]
[c7a51dc0] [c0238b2c]
[c7a51de0] [c0238c64]
[c7a51e20] [c0239094]
[c7a51e40] [c023ba00]
[c7a51e70] [c008b404]
[c7a51eb0] [c008d634]
[c7a51ec0] [c0059eb8]
[c7a51ee0] [c004ad5c]
[c7a51f30] [c0009644]
[c7a51f40] [c0010ca4]
--- Exception: c01Instruction dump:
900b00b0 90ff0010 4bffff9c 9421ffe0 7c0802a6 bf61000c 7c7c1b78 3c60c034
90010024 7f84e378 3863d078 3be00001 <83dc0000> 4bde279d 3c60c034 809c0004
---[ end trace 0304077a12ed39c2 ]---


> Regards.
>
> Alexis.
>

--0016364d2a31736f140473ad7c94
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Sep 16, 2009 at 1:42 AM, Alexis =
Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:berlemont.hauw@domain.hid">b=
erlemont.hauw@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
Hi,<br>
<div class=3D"im"><br>
&gt; I&#39;ve took a snapshot of the xenomai-abe (Comedi port related) git =
repos<br>
&gt; pointing to the last update and tried it up and it seems that are some=
<br>
&gt; errors.<br>
<br>
</div><div class=3D"im">That is very nice of you to test the driver on your=
 board. I had read<br>
your former mail and was about to ask you to test the code on your<br>
configuration.<br>
<br>
&gt;<br>
</div><div><div></div><div class=3D"h5">&gt; /usr/xenomai/sbin # ./comedi_c=
onfig -v comedi0 comedi_pcimio<br>
&gt; Comedi: comedi_pcimio: pcimio_attach: found pci-6024e board<br>
&gt; Comedi: MITE: 0x90000000 mapped to c907a000 &lt;6&gt;Comedi: DAQ: 0x90=
001000<br>
&gt; mapped to c907c000<br>
&gt; Comedi: MITE: version =3D 2, type =3D 1, mite mode =3D 1, interface mo=
de =3D 3<br>
&gt; Comedi: MITE: num channels =3D 1, write post fifo depth =3D 1, wins =
=3D 0, iowins<br>
&gt; =3D 2<br>
&gt; Comedi: comedi_pcimio: pcimio_attach: found irq 48<br>
&gt; Unable to handle kernel paging request for data at address 0x00012400<=
br>
&gt; Faulting instruction address: 0xc023dd08<br>
&gt; Oops: Kernel access of bad area, sig: 11 [#1]<br>
&gt; MPC831x RDB<br>
&gt; Modules linked in:<br>
&gt; NIP: c023dd08 LR: c0246b70 CTR: 00000000<br>
&gt; REGS: c7a51c30 TRAP: 0300 =A0 Not tainted =A0(2.6.24.2)<br>
&gt; MSR: 00001032 &lt;ME,IR,DR&gt; =A0CR: 84008422 =A0XER: 00000000<br>
&gt; DAR: 00012400, DSISR: 20000000<br>
&gt; TASK =3D c7864430[898] &#39;comedi_config&#39; THREAD: c7a50000<br>
&gt; GPR00: c0246b70 c7a51ce0 c7864430 00012400 00000001 00000000 c79062c0<=
br>
&gt; c03c0000<br>
&gt; GPR08: 00000000 c7900a00 c03d6144 c03a37e8 c7906200 1004a5b8 c033e0b8<=
br>
&gt; c03c0000<br>
&gt; GPR16: c03ba578 c03d1a00 c02464fc c03b4d60 c0244e5c c024509c c024535c<=
br>
&gt; c0245380<br>
&gt; GPR24: c03da628 c02453a4 20001040 00000000 00000000 c03a2e50 c03c0000<=
br>
&gt; 00012400<br>
&gt; Call Trace:<br>
&gt; [c7a51ce0] [c024bae0] =A0(unreliable)<br>
&gt; [c7a51d00] [c0246b70]<br>
&gt; [c7a51d20] [c0246bdc]<br>
&gt; [c7a51d40] [c024b88c]<br>
&gt; [c7a51d90] [c024c69c]<br>
&gt; [c7a51dc0] [c0238b2c]<br>
&gt; [c7a51de0] [c0238c64]<br>
&gt; [c7a51e20] [c0239094]<br>
&gt; [c7a51e40] [c023ba00]<br>
&gt; [c7a51e70] [c008b404]<br>
&gt; [c7a51eb0] [c008d634]<br>
&gt; [c7a51ec0] [c0059eb8]<br>
&gt; [c7a51ee0] [c004ad5c]<br>
&gt; [c7a51f30] [c0009644]<br>
&gt; [c7a51f40] [c0010ca4]<br>
&gt; --- Exception: c01Instruction dump:<br>
&gt; 7d6b1a14 39290010 38000001 7fe34a14 900b00b0 90ff0010 4bffff9c 9421ffe=
0<br>
&gt; 7c0802a6 bf61000c 7c7f1b78 90010024 &lt;83c30000&gt; 7c0000a6 5400045e=
 7c000124<br>
&gt; ---[ end trace f35e90f95f5de008 ]---<br>
&gt;<br>
&gt;<br>
&gt; A quick disassembly shows that the error is generated in the mite driv=
er as<br>
&gt; pointed next,<br>
&gt;<br>
&gt; c023dcf4 &lt;mite_release_channel&gt;:<br>
&gt; mite_release_channel():<br>
&gt; /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/driver=
s/xenomai/comedi/national_instruments/mite.c:308<br>
&gt; c023dcf4: =A0 =A094 21 ff e0 =A0 =A0 stwu =A0 =A0r1,-32(r1)<br>
&gt; c023dcf8: =A0 =A07c 08 02 a6 =A0 =A0 mflr =A0 =A0r0<br>
&gt; c023dcfc: =A0 =A0bf 61 00 0c =A0 =A0 stmw =A0 =A0r27,12(r1)<br>
&gt; c023dd00: =A0 =A07c 7f 1b 78 =A0 =A0 mr =A0 =A0 =A0r31,r3<br>
&gt; c023dd04: =A0 =A090 01 00 24 =A0 =A0 stw =A0 =A0 r0,36(r1)<br>
&gt; /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/driver=
s/xenomai/comedi/national_instruments/mite.c:309<br>
&gt; c023dd08: =A0 =A083 c3 00 00 =A0 =A0 lwz =A0 =A0 r30,0(r3)<br>
&gt;<br>
<br>
</div></div><div><div></div><div class=3D"h5">Without any access on you boa=
rd, I have no other solution but to ask<br>
you to add some debug traces in the driver so as to locate the<br>
problem:<br>
<br>
Could you try these two patches and send me the results. On my side,<br>
this driver (partly) works on the NI 6221 board plugged into some x86<br>
motherboard. Your configuration (6024e + PPC) is not that close but it<br>
is just a segfault, we will figure this out quite quickly with ugly<br>
printks.<br>
<br>
<br>
diff --git a/ksrc/drivers/comedi/national_instruments/mite.c<br>
b/ksrc/drivers/comedi/national_instruments/mite.c<br>
index 8f1ccd7..56013d0 100644<br>
--- a/ksrc/drivers/comedi/national_instruments/mite.c<br>
+++ b/ksrc/drivers/comedi/national_instruments/mite.c<br>
@@ -309,6 +309,22 @@ void mite_release_channel(struct mite_channel *mite_ch=
an)<br>
 =A0 =A0 =A0 struct mite_struct *mite =3D mite_chan-&gt;mite;<br>
 =A0 =A0 =A0 unsigned long flags;<br>
<br>
+#if 1 /* debug */<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 printk(&quot;mite_release_channel: mite_chan =3D %p\n&quot;, =
mite_chan);<br>
+ =A0 =A0 =A0 printk(&quot;mite_release_channel: mite_chan-&gt;channel =3D =
%p\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0mite_chan-&gt;channel);<br>
+ =A0 =A0 =A0 printk(&quot;mite_release_channel: mite =3D %p\n&quot;, mite)=
;<br>
+ =A0 =A0 =A0 printk(&quot;mite_release_channel: mite-&gt;mite_io_addr =3D =
%p\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0mite-&gt;mite_io_addr);<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; MAX_MITE_DMA_CHANNELS; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(&quot;mite_release_channel: \talloc[%d=
] =3D %u\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i, mite-&gt;channel_allocated[=
i]);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+#endif /* debug */<br>
+<br>
 =A0 =A0 =A0 // spin lock to prevent races with mite_request_channel<br>
 =A0 =A0 =A0 comedi_lock_irqsave(&amp;mite-&gt;lock, flags);<br>
 =A0 =A0 =A0 if (mite-&gt;channel_allocated[mite_chan-&gt;channel]) {<br>
@@ -318,13 +334,24 @@ void mite_release_channel(struct mite_channel *mite_c=
han)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CHCR_CLR_MRDY_IE | CHCR_CLR_DR=
DY_IE |<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CHCR_CLR_LC_IE | CHCR_CLR_CONT=
_RB_IE,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mite-&gt;mite_io_addr + MITE_C=
HCR(mite_chan-&gt;channel));<br>
+#if 1 /* debug */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(&quot;mite_release_channel: before dis=
arm\n&quot;);<br>
+#endif /* debug */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mite_dma_disarm(mite_chan);<br>
+#if 1 /* debug */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(&quot;mite_release_channel: before res=
et\n&quot;);<br>
+#endif /* debug */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mite_dma_reset(mite_chan);<br>
+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mite-&gt;channel_allocated[mite_chan-&gt;chann=
el] =3D 0;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mite_chan-&gt;ring =3D NULL;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmiowb();<br>
 =A0 =A0 =A0 }<br>
 =A0 =A0 =A0 comedi_unlock_irqrestore(&amp;mite-&gt;lock, flags);<br>
+<br>
+#if 1 /* debug */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(&quot;mite_release_channel: out\n&quot=
;);<br>
+#endif /* debug */<br>
=A0}<br>
<br>
=A0void mite_dma_arm(struct mite_channel *mite_chan)<br>
<br>
<br>
diff --git a/ksrc/drivers/comedi/national_instruments/mio_common.c<br>
b/ksrc/drivers/comedi/national_instruments/mio_common.c<br>
index 3f70c3e..e29c2c5 100644<br>
--- a/ksrc/drivers/comedi/national_instruments/mio_common.c<br>
+++ b/ksrc/drivers/comedi/national_instruments/mio_common.c<br>
@@ -424,6 +424,10 @@ void ni_release_ai_mite_channel(comedi_dev_t *dev)<br>
<br>
 =A0 =A0 =A0 unsigned long flags;<br>
<br>
+#if 1 /* debug */<br>
+ =A0 =A0 =A0 printk(&quot;ni_release_ai_mite_channel: in\n&quot;);<br>
+#endif /* debug */<br>
+<br>
 =A0 =A0 =A0 comedi_lock_irqsave(&amp;devpriv-&gt;mite_channel_lock, flags)=
;<br>
 =A0 =A0 =A0 if (devpriv-&gt;ai_mite_chan) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ni_set_ai_dma_channel(dev, -1);<br>
@@ -432,6 +436,10 @@ void ni_release_ai_mite_channel(comedi_dev_t *dev)<br>
 =A0 =A0 =A0 }<br>
 =A0 =A0 =A0 comedi_unlock_irqrestore(&amp;devpriv-&gt;mite_channel_lock, f=
lags);<br>
<br>
+#if 1 /* debug */<br>
+ =A0 =A0 =A0 printk(&quot;ni_release_ai_mite_channel: out\n&quot;);<br>
+#endif /* debug */<br>
+<br>
=A0}<br>
<br>
=A0void ni_release_ao_mite_channel(comedi_dev_t *dev)<br>
<br></div></div></blockquote><div>=A0</div><div>Hy !<br>I&#39;ve applied th=
e debug patches and I think that the problem is in the=A0 ni_release_ai_mit=
e_channel function because it seems that mite_release_channel is never call=
ed.<br>
It is possible that comedi_lock_irqsave to cause the problem or devpriv-&gt=
;ai_mite_chan is NULL ?<br><br><br>here&#39;s the output :<br><br>/usr/xeno=
mai/sbin # ./comedi_config -v comedi0 comedi_pcimio<br>Comedi: comedi_pcimi=
o: pcimio_attach: found pci-6024e board<br>
Comedi: MITE: 0x90000000 mapped to c907a000 &lt;6&gt;Comedi: DAQ: 0x9000100=
0 mapped to c907c000<br>Comedi: MITE: version =3D 2, type =3D 1, mite mode =
=3D 1, interface mode =3D 3<br>Comedi: MITE: num channels =3D 1, write post=
 fifo depth =3D 1, wins =3D 0, iowins =3D 2<br>
Comedi: comedi_pcimio: pcimio_attach: found irq 48<br><b>ni_release_ai_mite=
_channel: in</b><br>Unable to handle kernel paging request for data at addr=
ess 0x00012400<br>Faulting instruction address: 0xc023dd18<br>Oops: Kernel =
access of bad area, sig: 11 [#1]<br>
MPC831x RDB<br>Modules linked in:<br>NIP: c023dd18 LR: c0246c24 CTR: c0033b=
54<br>REGS: c7a51c30 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.24.2)<br>MSR: 000=
01032 &lt;ME,IR,DR&gt;=A0 CR: 24008422=A0 XER: 00000000<br>DAR: 00012400, D=
SISR: 20000000<br>
TASK =3D c7827430[894] &#39;comedi_config&#39; THREAD: c7a50000<br>GPR00: c=
0246c24 c7a51ce0 c7827430 c033d078 00012400 0001306f 00000000 c03a2f10 <br>=
GPR08: 00000070 c7900a00 c03d6144 c03a37e8 24008424 1004a5b8 c033e238 c03c0=
000 <br>
GPR16: c03ba578 c03d1a00 c02465a4 c03b4d60 c0244f04 c0245144 c0245404 c0245=
428 <br>GPR24: c03da628 c024544c 20001040 00000000 00012400 c03a2e50 c03c00=
00 00000001 <br>Call Trace:<br>[c7a51ce0] [c03f20a8]=A0 (unreliable)<br>[c7=
a51d00] [c0246c24] <br>
[c7a51d20] [c0246c9c] <br>[c7a51d40] [c024b94c] <br>[c7a51d90] [c024c75c] <=
br>[c7a51dc0] [c0238b2c] <br>[c7a51de0] [c0238c64] <br>[c7a51e20] [c0239094=
] <br>[c7a51e40] [c023ba00] <br>[c7a51e70] [c008b404] <br>[c7a51eb0] [c008d=
634] <br>
[c7a51ec0] [c0059eb8] <br>[c7a51ee0] [c004ad5c] <br>[c7a51f30] [c0009644] <=
br>[c7a51f40] [c0010ca4] <br>--- Exception: c01Instruction dump:<br>900b00b=
0 90ff0010 4bffff9c 9421ffe0 7c0802a6 bf61000c 7c7c1b78 3c60c034 <br>900100=
24 7f84e378 3863d078 3be00001 &lt;83dc0000&gt; 4bde279d 3c60c034 809c0004 <=
br>
---[ end trace 0304077a12ed39c2 ]---<br><br></div><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;"><div><div class=3D"h5">
<br>
Regards.<br>
<br>
Alexis.<br>
</div></div></blockquote></div><br>

--0016364d2a31736f140473ad7c94--

