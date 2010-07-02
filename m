MIME-Version: 1.0
In-Reply-To: <4C2BB5C0.3020407@domain.hid>
References: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>
	<4C289319.4050807@domain.hid>
	<AANLkTin9R46PUKwDQw_nXck_RkL9TH01Qqhuw-7YwmDT@mail.gmail.com>
	<4C2A1B0A.3000204@domain.hid>
	<AANLkTilr3TVOW5mLVTfIYW33TpkiIFuPStuO_TxgmMrS@mail.gmail.com>
	<4C2BB5C0.3020407@domain.hid>
Date: Fri, 2 Jul 2010 12:08:44 +0200
Message-ID: <AANLkTindg9Ctqhka7m_XsAirqOHThuEGbIHCNkKw_P15@domain.hid>
From: Nape Ibrahim Lentsoane <nape.lentsoane@domain.hid>
Content-Type: multipart/alternative; boundary=00163630f6d9abdf27048a64c556
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

--00163630f6d9abdf27048a64c556
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jun 30, 2010 at 11:23 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Nape Ibrahim Lentsoane wrote:
> > Okay, we updated the BIOS with a custom made version from Advantech. At
> > least we are able too boot now but
> > now  my usb mouse/port does not work. By the way I'm running on an
> > industrial SBC from Advantech model MIC-3390.
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
> >
> > I'll try to enable the APIC and local APIC and see what happens.
>
> Ok. Now we can see things more clearly. First: the APIC is already
> enabled in your kernel configuration, and seems not to be used, the ACPI
> is broken, I do not know if this is the problem, but it seems your APIC
> is not used. This is bad news. If that is possible, you should try and
> use a BIOS with ACPI. I mean, come on, this has been the standard for
> over 10 years now. See:
> http://en.wikipedia.org/wiki/ACPI
>
> Second, your kernel is not really well configured:
> - you have enabled multi-processor support whereas you have a single
> CPU, disable it
> - you probably use the generic IDE driver, whereas you should use the
> one for the hardware you really have, use lspci to find out what the
> hardware you use is.
> - you enabled Xenomai SMI workaround, at this stage, this is a bad idea,
> you should follow the guidelines in the "TROUBLESHOOTING" guide in order
> to enable it. But this is too early, please keep it disabled for now.
>
> And now, the really bad news: you have the IRQ shared between Xenomai
> driver and Linux driver issue. IRQ 12 is used both by the Xenomai CAN
> driver and by the Linux USB controller. This is probably the reason why
> the USB is not working. See the FAQ for suggestions on how you may solve
> this issue.
>
> Okay, I can work without the USB for now but I don't understand something
here.
We have have similar other SBCs with Arcnet cards installed and running
RTNet and
 some RTAI and they seem work well even if an IRQ is shared between RT and
non-RT.
For an example our real time Arcnet driver is sharing an IRQ with the SMBus
and there no issues there.
Just out of curiosity, why is this an problem with Xenomai?

> --
>                                             Gilles.
>

--00163630f6d9abdf27048a64c556
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jun 30, 2010 at 11:23 PM, Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">Nape Ibrahim Lentsoane wrote:<br>
&gt; Okay, we updated the BIOS with a custom made version from Advantech. A=
t<br>
&gt; least we are able too boot now but<br>
&gt; now =A0my usb mouse/port does not work. By the way I&#39;m running on =
an<br>
&gt; industrial SBC from Advantech model MIC-3390.<br>
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
&gt;<br>
&gt; I&#39;ll try to enable the APIC and local APIC and see what happens.<b=
r>
<br>
</div>Ok. Now we can see things more clearly. First: the APIC is already<br=
>
enabled in your kernel configuration, and seems not to be used, the ACPI<br=
>
is broken, I do not know if this is the problem, but it seems your APIC<br>
is not used. This is bad news. If that is possible, you should try and<br>
use a BIOS with ACPI. I mean, come on, this has been the standard for<br>
over 10 years now. See:<br>
<a href=3D"http://en.wikipedia.org/wiki/ACPI" target=3D"_blank">http://en.w=
ikipedia.org/wiki/ACPI</a><br>
<br>
Second, your kernel is not really well configured:<br>
- you have enabled multi-processor support whereas you have a single<br>
CPU, disable it<br>
- you probably use the generic IDE driver, whereas you should use the<br>
one for the hardware you really have, use lspci to find out what the<br>
hardware you use is.<br>
- you enabled Xenomai SMI workaround, at this stage, this is a bad idea,<br=
>
you should follow the guidelines in the &quot;TROUBLESHOOTING&quot; guide i=
n order<br>
to enable it. But this is too early, please keep it disabled for now.<br>
<br>
And now, the really bad news: you have the IRQ shared between Xenomai<br>
driver and Linux driver issue. IRQ 12 is used both by the Xenomai CAN<br>
driver and by the Linux USB controller. This is probably the reason why<br>
the USB is not working. See the FAQ for suggestions on how you may solve<br=
>
this issue.<br>
<br></blockquote><div>Okay, I can work without the USB for now but I don&#3=
9;t understand something here.<br>We have have similar other SBCs with Arcn=
et cards installed and running RTNet and<br>=A0some RTAI and they seem work=
 well even if an IRQ is shared between RT and non-RT. <br>
For an example our real time Arcnet driver is sharing an IRQ with the SMBus=
 and there no issues there.<br>Just out of curiosity, why is this an proble=
m with Xenomai?<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left=
: 1ex;">

--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--00163630f6d9abdf27048a64c556--

