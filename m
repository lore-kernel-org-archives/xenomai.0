MIME-Version: 1.0
In-Reply-To: <9c789a000906161348g43721abdu42aa2e727fcfd0cf@domain.hid>
References: <9c789a000906160810s77ceb784xb3a0d8320d210a7c@domain.hid>
	<72cf3fb0906160852v46b1602fwe39b135d8b11ba97@domain.hid>
	<9c789a000906161348g43721abdu42aa2e727fcfd0cf@domain.hid>
Date: Tue, 16 Jun 2009 23:49:25 +0300
Message-ID: <9c789a000906161349l45455a4cyc9e4f83525069a8d@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0016364d2c996a7fdc046c7d4f35
Subject: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016364d2c996a7fdc046c7d4f35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi !
Sorry for the latency in my response !

Here the output after attaching the comedi_pcimio driver

/usr/xenomai/sbin # cat /proc/iomem
80000000-8fffffff : /pci@domain.hid
90000000-9fffffff : /pci@domain.hid
  90000000-90000fff : 0000:00:10.0
    90000000-90000fff : mite
  90001000-90001fff : 0000:00:10.0
    90001000-90001fff : mite
a0000000-afffffff : /pci@domain.hid
c0000000-cfffffff : /pci@domain.hid
e0000200-e00002ff : wdt
e0004500-e0004507 : serial
e0004600-e0004607 : serial
e0007000-e0007fff : spi
e0023000-e0023fff : usb
  e0023000-e0023fff : ehci_hcd
e0024000-e0024fff : ethernet
  e0024520-e002453f : mdio
e0025000-e0025fff : ethernet
fe000000-fe7fffff : fe000000.nor

It clears it out ?!


On Tue, Jun 16, 2009 at 6:52 PM, Alexis Berlemont <
alexis.berlemont@domain.hid> wrote:

> Hi,
>
> On Tue, Jun 16, 2009 at 5:10 PM, Cristian
> Axenie<cristian.axenie@domain.hid> wrote:
> > Hi !
> > I've got a snapshot of the current git update but I still receive some
> > errors! Now the kernel is stable and doesn't crashes anymore but it seems
> > that there is a problem with attaching a driver !
> >
> > Here's the output !
> >
> > /usr/xenomai/sbin # ./comedi_config comedi0 comedi_pcimio
> > PCI: Unable to reserve mem region #1:1000@domain.hid for device
> 0000:00:10.0
> > Comedi: comedi_pcimio: pcmio_attach: error setting up mite
> > Comedi: comedi_assign_driver: call(drv->attach) failed (ret=-5)
> > comedi_config: comedi_snd_attach failed ret=-5
> >
>
> Thank you for the feedback. The error message is quite clear.
>
> Could you send a dump of the command "cat /proc/iomem" on your board?
>
> Alexis.
>

--0016364d2c996a7fdc046c7d4f35
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><br>Hi !<br>Sorry for the latency in my resp=
onse !<br><br>Here the output after attaching the comedi_pcimio driver<br><=
br>/usr/xenomai/sbin # cat /proc/iomem <br>80000000-8fffffff : /pci@domain.hid=
0<br>
90000000-9fffffff : /pci@domain.hid<br>
=A0 90000000-90000fff : 0000:00:10.0<br>=A0=A0=A0 90000000-90000fff : mite<=
br>=A0 90001000-90001fff : 0000:00:10.0<br>=A0=A0=A0 90001000-90001fff : mi=
te<br>a0000000-afffffff : /pci@domain.hid<br>c0000000-cfffffff : /pci@domain.hid=
0<br>e0000200-e00002ff : wdt<br>

e0004500-e0004507 : serial<br>e0004600-e0004607 : serial<br>e0007000-e0007f=
ff : spi<br>e0023000-e0023fff : usb<br>=A0 e0023000-e0023fff : ehci_hcd<br>=
e0024000-e0024fff : ethernet<br>=A0 e0024520-e002453f : mdio<br>e0025000-e0=
025fff : ethernet<br>

fe000000-fe7fffff : fe000000.nor<br><br>It clears it out ?!<div><div></div>=
<div class=3D"h5"><br><br><div class=3D"gmail_quote">On Tue, Jun 16, 2009 a=
t 6:52 PM, Alexis Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.=
berlemont@domain.hid" target=3D"_blank">alexis.berlemont@domain.hid</a>&gt;</=
span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<div><br>
On Tue, Jun 16, 2009 at 5:10 PM, Cristian<br>
Axenie&lt;<a href=3D"mailto:cristian.axenie@domain.hid" target=3D"_blank">cr=
istian.axenie@domain.hid</a>&gt; wrote:<br>
&gt; Hi !<br>
&gt; I&#39;ve got a snapshot of the current git update but I still receive =
some<br>
&gt; errors! Now the kernel is stable and doesn&#39;t crashes anymore but i=
t seems<br>
&gt; that there is a problem with attaching a driver !<br>
&gt;<br>
&gt; Here&#39;s the output !<br>
&gt;<br>
&gt; /usr/xenomai/sbin # ./comedi_config comedi0 comedi_pcimio<br>
&gt; PCI: Unable to reserve mem region #1:1000@domain.hid for device 0000:00:=
10.0<br>
&gt; Comedi: comedi_pcimio: pcmio_attach: error setting up mite<br>
&gt; Comedi: comedi_assign_driver: call(drv-&gt;attach) failed (ret=3D-5)<b=
r>
&gt; comedi_config: comedi_snd_attach failed ret=3D-5<br>
&gt;<br>
<br>
</div>Thank you for the feedback. The error message is quite clear.<br>
<br>
Could you send a dump of the command &quot;cat /proc/iomem&quot; on your bo=
ard?<br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div><br>
</div></div></div><br>

--0016364d2c996a7fdc046c7d4f35--

