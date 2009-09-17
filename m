MIME-Version: 1.0
In-Reply-To: <72cf3fb0909161526i5eb3178cnc2e9c7e154f624ef@domain.hid>
References: <9c789a000909130535j4dc046a1h3af2976ab504a000@domain.hid>
	<72cf3fb0909151542h163e7c03h1a393a969caf0c58@domain.hid>
	<9c789a000909160114h4a3b5ebbj46e1abfeed07f61c@domain.hid>
	<72cf3fb0909161526i5eb3178cnc2e9c7e154f624ef@domain.hid>
Date: Thu, 17 Sep 2009 19:01:50 +0300
Message-ID: <9c789a000909170901k72ad0475sd8b01ecb8556b58a@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0016364d1b632c86a80473c822ad
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

--0016364d1b632c86a80473c822ad
Content-Type: text/plain; charset=ISO-8859-1

Hy!
I've added some printks and took out the comedi_lock_irqsave / restore calls
from ni_release_ai_mite_channel and it seems that the call of
mite_release_channel
from ni_release_ai_mite_channel doesn't return

here's a short log :

~ # /usr/xenomai/sbin/comedi_config -v comedi0 comedi_pcimio
Comedi: comedi_pcimio: pcimio_attach: found pci-6024e board
Comedi: MITE: 0x90000000 mapped to c907a000 <6>Comedi: DAQ: 0x90001000
mapped to c907c000
Comedi: MITE: version = 2, type = 1, mite mode = 1, interface mode = 3
Comedi: MITE: num channels = 1, write post fifo depth = 1, wins = 0, iowins
= 2
Comedi: comedi_pcimio: pcimio_attach: found irq 48
*ni_release_ai_mite_channel: in
ni_release_ai_mite_channel: ai_mite_chan is not NULL
ni_release_ai_mite_channel: the dma channel was set*
Unable to handle kernel paging request for data at address 0x00012400
Faulting instruction address: 0xc023b35c
Oops: Kernel access of bad area, sig: 11 [#1]
MPC831x RDB
Modules linked in:
NIP: c023b35c LR: c0244254 CTR: c0029f44
REGS: c7adbc40 TRAP: 0300   Not tainted  (2.6.24.2)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22008422  XER: 00000000
DAR: 00012400, DSISR: 20000000
TASK = c7861bd0[888] 'comedi_config' THREAD: c7ada000

I seems that when it calls mite_release_channel none of the specific debug
messages appears !

I shall test further the mite_release_channel !

Best ,
Cristian !

On Thu, Sep 17, 2009 at 1:26 AM, Alexis Berlemont <berlemont.hauw@domain.hid>wrote:

> Hi,
>
> >
> > I've applied the debug patches and I think that the problem is in the
> > ni_release_ai_mite_channel function because it seems that
> > mite_release_channel is never called.
> > It is possible that comedi_lock_irqsave to cause the problem or
> > devpriv->ai_mite_chan is NULL ?
> >
>
> You can remove comedi_lock_irqsave/restore, they are not critical. And
> you can proceed on adding some debug traces so as to check
> ai_mite_chan.
>
> I will double check, the mite "init" function.
>
> Alexis.
>

--0016364d1b632c86a80473c822ad
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hy!<br>I&#39;ve added some printks and took out the comedi_lock_irqsave / r=
estore calls from ni_release_ai_mite_channel and it seems that the call of =
mite_release_channel<br>from ni_release_ai_mite_channel doesn&#39;t return<=
br>
<br>here&#39;s a short log :<br><br>~ # /usr/xenomai/sbin/comedi_config -v =
comedi0 comedi_pcimio<br>Comedi: comedi_pcimio: pcimio_attach: found pci-60=
24e board<br>Comedi: MITE: 0x90000000 mapped to c907a000 &lt;6&gt;Comedi: D=
AQ: 0x90001000 mapped to c907c000<br>
Comedi: MITE: version =3D 2, type =3D 1, mite mode =3D 1, interface mode =
=3D 3<br>Comedi: MITE: num channels =3D 1, write post fifo depth =3D 1, win=
s =3D 0, iowins =3D 2<br>Comedi: comedi_pcimio: pcimio_attach: found irq 48=
<br><b>ni_release_ai_mite_channel: in<br>
ni_release_ai_mite_channel: ai_mite_chan is not NULL<br>ni_release_ai_mite_=
channel: the dma channel was set</b><br>Unable to handle kernel paging requ=
est for data at address 0x00012400<br>Faulting instruction address: 0xc023b=
35c<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>MPC831x RDB<br>Modules lin=
ked in:<br>NIP: c023b35c LR: c0244254 CTR: c0029f44<br>REGS: c7adbc40 TRAP:=
 0300=A0=A0 Not tainted=A0 (2.6.24.2)<br>MSR: 00009032 &lt;EE,ME,IR,DR&gt;=
=A0 CR: 22008422=A0 XER: 00000000<br>
DAR: 00012400, DSISR: 20000000<br>TASK =3D c7861bd0[888] &#39;comedi_config=
&#39; THREAD: c7ada000<br><br>I seems that when it calls mite_release_chann=
el none of the specific debug messages appears !<br><br>I shall test furthe=
r the mite_release_channel !<br>
<br>Best ,<br>Cristian !<br><br><div class=3D"gmail_quote">On Thu, Sep 17, =
2009 at 1:26 AM, Alexis Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:b=
erlemont.hauw@domain.hid" target=3D"_blank">berlemont.hauw@domain.hid</a>&gt;</sp=
an> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<div><br>
&gt;<br>
&gt; I&#39;ve applied the debug patches and I think that the problem is in =
the<br>
&gt; ni_release_ai_mite_channel function because it seems that<br>
&gt; mite_release_channel is never called.<br>
&gt; It is possible that comedi_lock_irqsave to cause the problem or<br>
&gt; devpriv-&gt;ai_mite_chan is NULL ?<br>
&gt;<br>
<br>
</div>You can remove comedi_lock_irqsave/restore, they are not critical. An=
d<br>
you can proceed on adding some debug traces so as to check<br>
ai_mite_chan.<br>
<br>
I will double check, the mite &quot;init&quot; function.<br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div><br>

--0016364d1b632c86a80473c822ad--

