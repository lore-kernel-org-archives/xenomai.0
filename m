MIME-Version: 1.0
In-Reply-To: <4C2B2E60.9090101@domain.hid>
References: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>
	<4C289319.4050807@domain.hid>
	<AANLkTin9R46PUKwDQw_nXck_RkL9TH01Qqhuw-7YwmDT@mail.gmail.com>
	<4C2A1B0A.3000204@domain.hid>
	<AANLkTilr3TVOW5mLVTfIYW33TpkiIFuPStuO_TxgmMrS@mail.gmail.com>
	<4C2B2E60.9090101@domain.hid>
Date: Wed, 30 Jun 2010 14:31:44 +0200
Message-ID: <AANLkTiliwFI3R-J7nk5PEuqGjQUIR_cNLVuqzsXSF4WF@mail.gmail.com>
From: Nape Ibrahim Lentsoane <nape.lentsoane@domain.hid>
Content-Type: multipart/alternative; boundary=00c09f88d1395fa0e6048a3e89e7
Subject: Re: [Xenomai-help] IRQ conflict issues with and ESD PMC card.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--00c09f88d1395fa0e6048a3e89e7
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jun 30, 2010 at 1:45 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Nape Ibrahim Lentsoane wrote:
> > Okay, we updated the BIOS with a custom made version from Advantech. At
> > least we are able too boot now but
> > now  my usb mouse/port does not work.
>
> So it is not really better, is it? Unless you do not intend to use USB.
>

correct

>
> By the way I'm running on an
> > industrial SBC from Advantech model MIC-3390.
>
> My real question was what processor you are running. I guess it is a
> pentium M?
>

Yes Pentium M

>
> > The contents of /proc/interrupts and /proc/xenomai/irq are in
> > "pro_interrupts.txt" and "xenomai_irq_2.txt" respectively
> > as attached.
> >
> > Something strange which I do not understand is that ran the '# lsmod |
> grep
> > xeno_can' and look at the results in the
> > attached file "lsmod_grep_xeno_can.txt". What is puzzling is that I
> > configured the Xenomai CAN stuff to load as modules
> > but here they are automatically loaded, how's that?
>
> The linux kernel or the root file system did this, Xenomai is not
> involved. Xenomai CAN drivers are simply declared as drivers for PCI
> boards and handled by whatever does that for the version of the kernel
> you are using. I think it is udev, but I could not be sure, these things
> have changed many times over time, I lost track.
>
> How can I stop it from doing that. I'm not sure how (newbie).

> >
> > I'll try to enable the APIC and local APIC and see what happens.
>
> I meant local APIC and/or IO/APIC. Yes, you should definitely try that,
> as mentioned in the FAQ, using the APIC improves latencies.
>
>
> --
>                                             Gilles.
>

--00c09f88d1395fa0e6048a3e89e7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jun 30, 2010 at 1:45 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-le=
ft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">Nape Ibrahim Lentsoane wrote:<br>
&gt; Okay, we updated the BIOS with a custom made version from Advantech. A=
t<br>
&gt; least we are able too boot now but<br>
&gt; now =A0my usb mouse/port does not work.<br>
<br>
</div>So it is not really better, is it? Unless you do not intend to use US=
B.<br></blockquote><div><br>correct <br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 20=
4, 204); padding-left: 1ex;">

<div class=3D"im"><br>
By the way I&#39;m running on an<br>
&gt; industrial SBC from Advantech model MIC-3390.<br>
<br>
</div>My real question was what processor you are running. I guess it is a<=
br>
pentium M?<br></blockquote><div>=A0</div><div>Yes Pentium M <br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im"><br>
&gt; The contents of /proc/interrupts and /proc/xenomai/irq are in<br>
&gt; &quot;pro_interrupts.txt&quot; and &quot;xenomai_irq_2.txt&quot; respe=
ctively<br>
&gt; as attached.<br>
&gt;<br>
&gt; Something strange which I do not understand is that ran the &#39;# lsm=
od | grep<br>
&gt; xeno_can&#39; and look at the results in the<br>
&gt; attached file &quot;lsmod_grep_xeno_can.txt&quot;. What is puzzling is=
 that I<br>
&gt; configured the Xenomai CAN stuff to load as modules<br>
&gt; but here they are automatically loaded, how&#39;s that?<br>
<br>
</div>The linux kernel or the root file system did this, Xenomai is not<br>
involved. Xenomai CAN drivers are simply declared as drivers for PCI<br>
boards and handled by whatever does that for the version of the kernel<br>
you are using. I think it is udev, but I could not be sure, these things<br=
>
have changed many times over time, I lost track.<br>
<div class=3D"im"><br></div></blockquote><div>How can I stop it from doing =
that. I&#39;m not sure how (newbie).<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 20=
4, 204); padding-left: 1ex;">
<div class=3D"im">
&gt;<br>
&gt; I&#39;ll try to enable the APIC and local APIC and see what happens.<b=
r>
<br>
</div>I meant local APIC and/or IO/APIC. Yes, you should definitely try tha=
t,<br>
as mentioned in the FAQ, using the APIC improves latencies.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--00c09f88d1395fa0e6048a3e89e7--

