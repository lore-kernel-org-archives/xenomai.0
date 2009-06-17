MIME-Version: 1.0
In-Reply-To: <9c789a000906161402y53c793f9n93635f9e044e358d@domain.hid>
References: <9c789a000906160810s77ceb784xb3a0d8320d210a7c@domain.hid>
	<72cf3fb0906160852v46b1602fwe39b135d8b11ba97@domain.hid>
	<9c789a000906161348g43721abdu42aa2e727fcfd0cf@domain.hid>
	<9c789a000906161349l45455a4cyc9e4f83525069a8d@domain.hid>
	<9c789a000906161402y53c793f9n93635f9e044e358d@domain.hid>
Date: Wed, 17 Jun 2009 15:51:22 +0300
Message-ID: <9c789a000906170551m7c925aeds50d46b574c8b4d93@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6db61ca9d1b75046c8abff1
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>, Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

--0016e6db61ca9d1b75046c8abff1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi !
If this helps , here's a dump of the PCI info!

/usr/xenomai/sbin # lspci -vvxxx
00:00.0 Power PC: Freescale Semiconductor Inc Unknown device 00b4 (rev 10)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
    Latency: 128, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 16
    Region 2: Memory at <unassigned> (64-bit, prefetchable)
    Region 4: Memory at <unassigned> (64-bit, non-prefetchable)
    Capabilities: [48] #06 [0000]
    Capabilities: [80] Power Management version 3
        Flags: PMEClk+ DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 57 19 b4 00 06 01 b0 20 10 00 20 0b 08 80 00 00
10: 00 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00
20: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 20 00 00 00 06 80 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 2b 7e 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:10.0 Class ff00: National Instruments PCI-6024E
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 128, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 48
    Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=4K]
    Region 1: Memory at 90001000 (32-bit, non-prefetchable) [size=4K]
00: 93 10 70 2a 06 00 80 02 00 00 00 ff 08 80 00 00
10: 00 00 00 90 00 10 00 90 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: ac ac 00 00 00 00 00 00 00 00 00 80 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Best !

On Wed, Jun 17, 2009 at 12:02 AM, Cristian Axenie <cristian.axenie@domain.hid
> wrote:

>
>
> ---------- Forwarded message ----------
> From: Cristian Axenie <cristian.axenie@domain.hid>
> Date: Tue, Jun 16, 2009 at 11:49 PM
> Subject: [Xenomai-help]Driver testing procedure ?!
> To: xenomai@xenomai.org
>
>
>
>
> Hi !
> Sorry for the latency in my response !
>
> Here the output after attaching the comedi_pcimio driver
>
> /usr/xenomai/sbin # cat /proc/iomem
> 80000000-8fffffff : /pci@domain.hid
> 90000000-9fffffff : /pci@domain.hid
>   90000000-90000fff : 0000:00:10.0
>     90000000-90000fff : mite
>   90001000-90001fff : 0000:00:10.0
>     90001000-90001fff : mite
> a0000000-afffffff : /pci@domain.hid
> c0000000-cfffffff : /pci@domain.hid
> e0000200-e00002ff : wdt
> e0004500-e0004507 : serial
> e0004600-e0004607 : serial
> e0007000-e0007fff : spi
> e0023000-e0023fff : usb
>   e0023000-e0023fff : ehci_hcd
> e0024000-e0024fff : ethernet
>   e0024520-e002453f : mdio
> e0025000-e0025fff : ethernet
> fe000000-fe7fffff : fe000000.nor
>
> It clears it out ?!
>
>
> On Tue, Jun 16, 2009 at 6:52 PM, Alexis Berlemont <
> alexis.berlemont@domain.hid> wrote:
>
>> Hi,
>>
>> On Tue, Jun 16, 2009 at 5:10 PM, Cristian
>> Axenie<cristian.axenie@domain.hid> wrote:
>> > Hi !
>> > I've got a snapshot of the current git update but I still receive some
>> > errors! Now the kernel is stable and doesn't crashes anymore but it
>> seems
>> > that there is a problem with attaching a driver !
>> >
>> > Here's the output !
>> >
>> > /usr/xenomai/sbin # ./comedi_config comedi0 comedi_pcimio
>> > PCI: Unable to reserve mem region #1:1000@domain.hid for device
>> 0000:00:10.0
>> > Comedi: comedi_pcimio: pcmio_attach: error setting up mite
>> > Comedi: comedi_assign_driver: call(drv->attach) failed (ret=-5)
>> > comedi_config: comedi_snd_attach failed ret=-5
>> >
>>
>> Thank you for the feedback. The error message is quite clear.
>>
>> Could you send a dump of the command "cat /proc/iomem" on your board?
>>
>> Alexis.
>>
>
>
>
>

--0016e6db61ca9d1b75046c8abff1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi !<br>If this helps , here&#39;s a dump of the PCI info!<br><br>/usr/xeno=
mai/sbin # lspci -vvxxx<br>00:00.0 Power PC: Freescale Semiconductor Inc Un=
known device 00b4 (rev 10)<br>=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecC=
ycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-<br>
=A0=A0=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast &gt;TAbor=
t- &lt;TAbort- &lt;MAbort+ &gt;SERR- &lt;PERR-<br>=A0=A0=A0 Latency: 128, C=
ache Line Size: 32 bytes<br>=A0=A0=A0 Interrupt: pin A routed to IRQ 16<br>=
=A0=A0=A0 Region 2: Memory at &lt;unassigned&gt; (64-bit, prefetchable)<br>
=A0=A0=A0 Region 4: Memory at &lt;unassigned&gt; (64-bit, non-prefetchable)=
<br>=A0=A0=A0 Capabilities: [48] #06 [0000]<br>=A0=A0=A0 Capabilities: [80]=
 Power Management version 3<br>=A0=A0=A0 =A0=A0=A0 Flags: PMEClk+ DSI+ D1+ =
D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)<br>
=A0=A0=A0 =A0=A0=A0 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-<br>00: =
57 19 b4 00 06 01 b0 20 10 00 20 0b 08 80 00 00<br>10: 00 00 00 00 00 00 00=
 00 0c 00 00 00 00 00 00 00<br>20: 04 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00<br>30: 00 00 00 00 48 00 00 00 00 00 00 00 00 01 00 00<br>
40: 00 00 00 00 20 00 00 00 06 80 00 00 00 00 00 00<br>50: 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00<br>60: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00<br>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>80: 0=
1 00 2b 7e 00 00 00 00 00 00 00 00 00 00 00 00<br>
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>a0: 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00<br>b0: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00<br>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>d0: 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>f0: 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00<br><br>00:10.0 Class ff00: National Instrum=
ents PCI-6024E<br>=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWIN=
V- VGASnoop- ParErr- Stepping- SERR- FastB2B-<br>
=A0=A0=A0 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &gt;TAb=
ort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR-<br>=A0=A0=A0 Latency: 128,=
 Cache Line Size: 32 bytes<br>=A0=A0=A0 Interrupt: pin A routed to IRQ 48<b=
r>=A0=A0=A0 Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=
=3D4K]<br>
=A0=A0=A0 Region 1: Memory at 90001000 (32-bit, non-prefetchable) [size=3D4=
K]<br>00: 93 10 70 2a 06 00 80 02 00 00 00 ff 08 80 00 00<br>10: 00 00 00 9=
0 00 10 00 90 00 00 00 00 00 00 00 00<br>20: 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00<br>
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00<br>40: ac ac 00 00 00 0=
0 00 00 00 00 00 80 00 00 00 00<br>50: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00<br>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>70: 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>90: 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00<br>a0: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00<br>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>c0: 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>e0: 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00<br>f0: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00<br><br>Best !<br><br><div class=3D"gmail_quote">On Wed, Jun 17,=
 2009 at 12:02 AM, Cristian Axenie <span dir=3D"ltr">&lt;<a href=3D"mailto:=
cristian.axenie@domain.hid">cristian.axenie@domain.hid</a>&gt;</span> wrote:<=
br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5"><br><br><div class=3D"gmail_quote">---------- Forwarded me=
ssage ----------<br>
From: <b class=3D"gmail_sendername">Cristian Axenie</b> <span dir=3D"ltr">&=
lt;<a href=3D"mailto:cristian.axenie@domain.hid" target=3D"_blank">cristian.=
axenie@domain.hid</a>&gt;</span><br>
Date: Tue, Jun 16, 2009 at 11:49 PM<br>Subject: [Xenomai-help]Driver testin=
g procedure ?!<br>To: <a href=3D"mailto:xenomai@xenomai.org" target=3D"_bl=
ank">xenomai@xenomai.org</a><br><br><br><div><div></div><div><br><div clas=
s=3D"gmail_quote">

<br>Hi !<br>Sorry for the latency in my response !<br><br>Here the output a=
fter attaching the comedi_pcimio driver<br><br>/usr/xenomai/sbin # cat /pro=
c/iomem <br>80000000-8fffffff : /pci@domain.hid<br>
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
<div><br><br><div class=3D"gmail_quote">On Tue, Jun 16, 2009 at 6:52 PM, Al=
exis Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid=
il.com" target=3D"_blank">alexis.berlemont@domain.hid</a>&gt;</span> wrote:<=
br>



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
</div></div></div><br>
</div></div></blockquote></div><br>

--0016e6db61ca9d1b75046c8abff1--

