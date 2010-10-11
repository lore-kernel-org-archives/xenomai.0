MIME-Version: 1.0
In-Reply-To: <4CB367AA.6020403@domain.hid>
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>
	<1286611432.13186.200.camel@domain.hid>
	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>
	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>
	<4CB2B98A.8010605@domain.hid>
	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>
	<4CB36116.8090507@domain.hid> <4CB367AA.6020403@domain.hid>
Date: Mon, 11 Oct 2010 14:23:45 -0700
Message-ID: <AANLkTimpY=60yJbWBwnu7KWZMst5ajFvrRoFzVx092oN@mail.gmail.com>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016361e83f2aea02d04925df962
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

--0016361e83f2aea02d04925df962
Content-Type: text/plain; charset=ISO-8859-1

Hey Wolfgang,

we are using this card

http://www.gridconnect.com/pcicanin2ch.html

07:04.0 Network controller [0280]: PEAK-System Technik GmbH PCAN-PCI
CAN-Bus controller [001c:0001] (rev 02)
       Subsystem: PEAK-System Technik GmbH Device [001c:0005]
       Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
       Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Interrupt: pin A routed to IRQ 11
       Region 0: Memory at f3ae0000 (32-bit, non-prefetchable) [size=64K]
       Region 1: Memory at f3af0000 (32-bit, non-prefetchable) [size=64K]

I will let you know how it goes with the printks.

THANKS a lot,
 peter

On Mon, Oct 11, 2010 at 12:38 PM, Wolfgang Grandegger <wg@domain.hid>wrote:

> On 10/11/2010 09:10 PM, Gilles Chanteperdrix wrote:
> > Peter Pastor wrote:
> >> Hey Gilles,
> >>
> >> Thanks for the hint. I "fixed" this problem by loading the nvidia driver
> >> (instead of nv) as default. Now the graphic cards uses IRQ 24 which does
> not
> >> collide with IRQ 11 of the CAN bus card (see attached lspci.txt).
> >>
> >> The only other device that uses IRQ 11 is
> >> # 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port
> >> [8086:3406] (rev 13)
> >>
> >> But I guess that is ok, is it ? I checked the FAQs and went through the
> list
> >> but I feel I can't do much. I will try a few things and disable
> everything
> >> that is unneeded. The FAQ list also suggests to enable CONFIG_PCI_MSI
> which
> >> is disabled right now. What would now be a reasonable thing to do ?
> >
> > Keep PCI_MSI disabled. The FAQ is wrong and should be fixed.
> >
> >>
> >> How can I find out and about which device is causing the address space
> >> collision ?
> >>
> >> # address space collision: host bridge window [mem
> 0xd7f00000-0xe0000000]
> >> conflicts with PCI Bus 0000:00 [mem 0xe0000000-0xf7ffffff]
> >>
> >> I attached the syslog of the latest boot. I enabled some debugging infos
> >> which hopefully allow to trace down the problem. Interestingly, this
> time,
> >> the kernel spit out
> >>
> >> # RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
> >>
> >> right before it froze.
> >
> > You should try and put some printks in RTCan code to see how far it
> > goes. But I guess Wolfgang may be of more help.
>
> Well, normally messages like:
>
>  RTCAN SJA1000 driver initialized
>  PEAK-PCI-CAN: initializing device 001c:0001
>  PEAK-PCI-CAN: base_addr=c907c000 conf_addr=c907a000 irq=16
>  rtcan: registered rtcan0
>  PEAK-PCI-CAN: base_addr=c907e400 conf_addr=c907a000 irq=16
>  rtcan: registered rtcan1
>
> should follow. I would add printk's into peak_pci_init_one() and
> rtcan_peak_pci_add_chan() in ksrc/drivers/can/sja1000/rtcan_peak_pci.c.
> Did you compile the SJA1000 driver's into the kernel? Try building
> modules, which you then can load manually.
>
> BTW: what PEAK PCI card are you using?
>
> Wolfgang.
>

--0016361e83f2aea02d04925df962
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Wolfgang,<br>
<br>
we are using this card<br>
<br>
<a href=3D"http://www.gridconnect.com/pcicanin2ch.html" target=3D"_blank">h=
ttp://www.gridconnect.com/pcicanin2ch.html</a><br>
<br>
07:04.0 Network controller [0280]: PEAK-System Technik GmbH PCAN-PCI<br>
CAN-Bus controller [001c:0001] (rev 02)<br>
 =A0 =A0 =A0 =A0Subsystem: PEAK-System Technik GmbH Device [001c:0005]<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr-<br>
Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort-<br>
&lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 11<br>
 =A0 =A0 =A0 =A0Region 0: Memory at f3ae0000 (32-bit, non-prefetchable) [si=
ze=3D64K]<br>
 =A0 =A0 =A0 =A0Region 1: Memory at f3af0000 (32-bit, non-prefetchable) [si=
ze=3D64K]<br>
<br>
I will let you know how it goes with the printks.<br>
<br>
THANKS a lot,<br>
<font color=3D"#888888">=A0peter</font><br><br><div class=3D"gmail_quote">O=
n Mon, Oct 11, 2010 at 12:38 PM, Wolfgang Grandegger <span dir=3D"ltr">&lt;=
<a href=3D"mailto:wg@domain.hid">wg@domain.hid</a>&gt;</span> wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On 10/11/2010 09:10 PM, Gilles Chanteperdrix wrote:<br>
&gt; Peter Pastor wrote:<br>
&gt;&gt; Hey Gilles,<br>
&gt;&gt;<br>
&gt;&gt; Thanks for the hint. I &quot;fixed&quot; this problem by loading t=
he nvidia driver<br>
&gt;&gt; (instead of nv) as default. Now the graphic cards uses IRQ 24 whic=
h does not<br>
&gt;&gt; collide with IRQ 11 of the CAN bus card (see attached lspci.txt).<=
br>
&gt;&gt;<br>
&gt;&gt; The only other device that uses IRQ 11 is<br>
&gt;&gt; # 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ES=
I Port<br>
&gt;&gt; [8086:3406] (rev 13)<br>
&gt;&gt;<br>
&gt;&gt; But I guess that is ok, is it ? I checked the FAQs and went throug=
h the list<br>
&gt;&gt; but I feel I can&#39;t do much. I will try a few things and disabl=
e everything<br>
&gt;&gt; that is unneeded. The FAQ list also suggests to enable CONFIG_PCI_=
MSI which<br>
&gt;&gt; is disabled right now. What would now be a reasonable thing to do =
?<br>
&gt;<br>
&gt; Keep PCI_MSI disabled. The FAQ is wrong and should be fixed.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; How can I find out and about which device is causing the address s=
pace<br>
&gt;&gt; collision ?<br>
&gt;&gt;<br>
&gt;&gt; # address space collision: host bridge window [mem 0xd7f00000-0xe0=
000000]<br>
&gt;&gt; conflicts with PCI Bus 0000:00 [mem 0xe0000000-0xf7ffffff]<br>
&gt;&gt;<br>
&gt;&gt; I attached the syslog of the latest boot. I enabled some debugging=
 infos<br>
&gt;&gt; which hopefully allow to trace down the problem. Interestingly, th=
is time,<br>
&gt;&gt; the kernel spit out<br>
&gt;&gt;<br>
&gt;&gt; # RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team<b=
r>
&gt;&gt;<br>
&gt;&gt; right before it froze.<br>
&gt;<br>
&gt; You should try and put some printks in RTCan code to see how far it<br=
>
&gt; goes. But I guess Wolfgang may be of more help.<br>
<br>
</div></div>Well, normally messages like:<br>
<br>
 =A0RTCAN SJA1000 driver initialized<br>
 =A0PEAK-PCI-CAN: initializing device 001c:0001<br>
 =A0PEAK-PCI-CAN: base_addr=3Dc907c000 conf_addr=3Dc907a000 irq=3D16<br>
 =A0rtcan: registered rtcan0<br>
 =A0PEAK-PCI-CAN: base_addr=3Dc907e400 conf_addr=3Dc907a000 irq=3D16<br>
 =A0rtcan: registered rtcan1<br>
<br>
should follow. I would add printk&#39;s into peak_pci_init_one() and<br>
rtcan_peak_pci_add_chan() in ksrc/drivers/can/sja1000/rtcan_peak_pci.c.<br>
Did you compile the SJA1000 driver&#39;s into the kernel? Try building<br>
modules, which you then can load manually.<br>
<br>
BTW: what PEAK PCI card are you using?<br>
<font color=3D"#888888"><br>
Wolfgang.<br>
</font></blockquote></div><br>

--0016361e83f2aea02d04925df962--

