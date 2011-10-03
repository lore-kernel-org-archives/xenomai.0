MIME-Version: 1.0
In-Reply-To: <CAMesUR5oL33XfP_BienmYeabgmL_0sea8UFnLFxJC5yZ-igEKw@domain.hid>
References: <CAMwkeZzYbE8DKnmDNMbU58Qi0HC4YWNKJRjxs-8n8Q75tY1j8w@domain.hid>
	<CAMesUR5oL33XfP_BienmYeabgmL_0sea8UFnLFxJC5yZ-igEKw@domain.hid>
Date: Mon, 3 Oct 2011 23:31:29 +0200
Message-ID: <CAMwkeZysbyrySRQuBLtXeH0cccX-ab6w8_P2YV3S5w50F=x0yw@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec531487fb14ee904ae6bb283
Subject: Re: [Xenomai-help] Module unloading and reloading does not work
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--bcaec531487fb14ee904ae6bb283
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 3 de octubre de 2011 23:09, Alexis Berlemont
<alexis.berlemont@domain.hid>escribi=C3=B3:

> Hi,
>
> 2011/9/30 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
> > Dear list,
> >
> > I am testing Xenomai 2.6.0-rc4 on a 2.6.38.8 linux kernel. I have two
> cards,
> > one NI 6713 for AO and one NI 6143 for AI. I use the analogy_ni_pcimio
> for
> > both, and it loads well. I can run the config program succesfully too.
> >
> > If I remove the devices using 'analogy_config -r ...', then unload the
> > modules with:
> >
> > rmmod analogy_ni_pcimio analogy_ni_mio analogy_ni_tio analogy_8255
> > analogy_ni_mite xeno_analogy
> >
> > then load them again and try to reconfigure, I get the following error =
on
> > dmesg (I include the boot messages and the execution of a "cmd_read"):
> >
> > [   55.735198] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-671=
3
> > board
> > [   55.735246] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 21
> > [   60.143227] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-614=
3
> > board
> > [   60.143274] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 20
> > [   79.772511] Analogy: a4l_ioctl_cancel: no acquisition to cancel on
> this
> > context
> > [   79.772517] Analogy: analogy_ni_pcimio: ni_ai_cmd: start
> > [   79.772525] Analogy: analogy_ni_pcimio: ni_ai_cmd:
> > Interrupt_A_Enable_Register =3D 0x0021
> > [   79.772531] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit
> > [   80.572613] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
> > a_status=3D90f0 ai_mite_status=3D00200000
> > [   80.572616] Analogy: analogy_ni_pcimio: ni_mio_common: SC_TC interru=
pt
> > [  236.290044] Analogy: MITE: Available NI device IDs: 0x1870 0x70c0
> > [  246.113821] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-614=
3
> > board
> > [  246.113872] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 20
> > [  246.113876] Analogy: analogy_ni_pcimio: pcimio_attach: irq not
> available
> > [  246.113879] Analogy: a4l_request_irq: IRQ registration failed
> > [  251.563782] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-671=
3
> > board
> > [  251.563824] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 21
> > [  251.563828] Analogy: analogy_ni_pcimio: pcimio_attach: irq not
> available
> > [  251.563830] Analogy: a4l_request_irq: IRQ registration failed
> >
> > BTW, the analogy_config program does not report those errors.
> >
> > This is bothering because I'm fiddling with the drivers and everytime I
> > change something I have to reboot. Anyone experiencing the same problem=
?
>
> Sorry. I will try to fix that as soon as possible.


Ok, thanks!
Fernando

--bcaec531487fb14ee904ae6bb283
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">El 3 de octubre de 2011 23:09, Alexis Be=
rlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid"=
>alexis.berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex;">
Hi,<br>
<br>
2011/9/30 Fernando Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elferdo@domain.hid.=
com">elferdo@domain.hid</a>&gt;:<br>
<div><div></div><div class=3D"h5">&gt; Dear list,<br>
&gt;<br>
&gt; I am testing Xenomai 2.6.0-rc4 on a 2.6.38.8 linux kernel. I have two =
cards,<br>
&gt; one NI 6713 for AO and one NI 6143 for AI. I use the analogy_ni_pcimio=
 for<br>
&gt; both, and it loads well. I can run the config program succesfully too.=
<br>
&gt;<br>
&gt; If I remove the devices using &#39;analogy_config -r ...&#39;, then un=
load the<br>
&gt; modules with:<br>
&gt;<br>
&gt; rmmod analogy_ni_pcimio analogy_ni_mio analogy_ni_tio analogy_8255<br>
&gt; analogy_ni_mite xeno_analogy<br>
&gt;<br>
&gt; then load them again and try to reconfigure, I get the following error=
 on<br>
&gt; dmesg (I include the boot messages and the execution of a &quot;cmd_re=
ad&quot;):<br>
&gt;<br>
&gt; [=C2=A0=C2=A0 55.735198] Analogy: analogy_ni_pcimio: pcimio_attach: fo=
und pci-6713<br>
&gt; board<br>
&gt; [=C2=A0=C2=A0 55.735246] Analogy: analogy_ni_pcimio: pcimio_attach: fo=
und irq 21<br>
&gt; [=C2=A0=C2=A0 60.143227] Analogy: analogy_ni_pcimio: pcimio_attach: fo=
und pci-6143<br>
&gt; board<br>
&gt; [=C2=A0=C2=A0 60.143274] Analogy: analogy_ni_pcimio: pcimio_attach: fo=
und irq 20<br>
&gt; [=C2=A0=C2=A0 79.772511] Analogy: a4l_ioctl_cancel: no acquisition to =
cancel on this<br>
&gt; context<br>
&gt; [=C2=A0=C2=A0 79.772517] Analogy: analogy_ni_pcimio: ni_ai_cmd: start<=
br>
&gt; [=C2=A0=C2=A0 79.772525] Analogy: analogy_ni_pcimio: ni_ai_cmd:<br>
&gt; Interrupt_A_Enable_Register =3D 0x0021<br>
&gt; [=C2=A0=C2=A0 79.772531] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit<b=
r>
&gt; [=C2=A0=C2=A0 80.572613] Analogy: analogy_ni_pcimio: ni_mio_common: in=
terrupt:<br>
&gt; a_status=3D90f0 ai_mite_status=3D00200000<br>
&gt; [=C2=A0=C2=A0 80.572616] Analogy: analogy_ni_pcimio: ni_mio_common: SC=
_TC interrupt<br>
&gt; [=C2=A0 236.290044] Analogy: MITE: Available NI device IDs: 0x1870 0x7=
0c0<br>
&gt; [=C2=A0 246.113821] Analogy: analogy_ni_pcimio: pcimio_attach: found p=
ci-6143<br>
&gt; board<br>
&gt; [=C2=A0 246.113872] Analogy: analogy_ni_pcimio: pcimio_attach: found i=
rq 20<br>
&gt; [=C2=A0 246.113876] Analogy: analogy_ni_pcimio: pcimio_attach: irq not=
 available<br>
&gt; [=C2=A0 246.113879] Analogy: a4l_request_irq: IRQ registration failed<=
br>
&gt; [=C2=A0 251.563782] Analogy: analogy_ni_pcimio: pcimio_attach: found p=
ci-6713<br>
&gt; board<br>
&gt; [=C2=A0 251.563824] Analogy: analogy_ni_pcimio: pcimio_attach: found i=
rq 21<br>
&gt; [=C2=A0 251.563828] Analogy: analogy_ni_pcimio: pcimio_attach: irq not=
 available<br>
&gt; [=C2=A0 251.563830] Analogy: a4l_request_irq: IRQ registration failed<=
br>
&gt;<br>
&gt; BTW, the analogy_config program does not report those errors.<br>
&gt;<br>
&gt; This is bothering because I&#39;m fiddling with the drivers and everyt=
ime I<br>
&gt; change something I have to reboot. Anyone experiencing the same proble=
m?<br>
<br>
</div></div>Sorry. I will try to fix that as soon as possible.</blockquote>=
<div><br></div><div>Ok, thanks!</div><div>Fernando=C2=A0</div></div><br>

--bcaec531487fb14ee904ae6bb283--

