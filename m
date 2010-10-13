MIME-Version: 1.0
In-Reply-To: <4CB49A14.3050400@domain.hid>
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>
	<1286611432.13186.200.camel@domain.hid>
	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>
	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>
	<4CB2B98A.8010605@domain.hid>
	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>
	<4CB36116.8090507@domain.hid> <4CB367AA.6020403@domain.hid>
	<AANLkTimpY=60yJbWBwnu7KWZMst5ajFvrRoFzVx092oN@mail.gmail.com>
	<AANLkTimTRK9RG6md3vVoohx7KFw2uwczZGGaXvajnPxq@domain.hid>
	<4CB4103E.80009@domain.hid>
	<AANLkTikwqboZGsSC99yMOQZTm48QoT8C6j+RPi3Wcs=k@domain.hid>
	<4CB49A14.3050400@domain.hid>
Date: Tue, 12 Oct 2010 23:14:30 -0700
Message-ID: <AANLkTik2jiYm58JQkqv_f9E6KTZiyUb4B+kP27xezP2G@mail.gmail.com>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016363b7996a481cc04927981b7
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--0016363b7996a481cc04927981b7
Content-Type: text/plain; charset=ISO-8859-1

Hey Jan, Wolfgang, Gilles,

After actually trying to reroute the interrupt by cutting and jumping the
pins on the PCI card we figured that there was actually a 64bit PCI slot
free. Also, according to wikipedia...  "PCI-X 1.0b and PCI-X 2.0 are
backward compatible with some PCI standards." Thus, we simply stuck the card
in that slot and got assigned an interrupt that is not shared by other
devices. Well, after rerouting things back to the initial configuration on
the card, we were able to load the rtcan modules and communicate on the CAN
bus !!

THANKS again for all the help and please let me know if you want me to run
some tests. We are running xenomai 2.6.31 with xenomai 2.5.5.1 and
thelinux_2.6.31-14.48.diff.gz ubuntu patch and the
adeos-ipipe-2.6.31.8-x86-2.4-09.patch on a 64bit dell precision workstation
T7500.

The only problem remaining is the fact that we get latency problems the
moment we start an opengl window but as mentioned in another thread, there
is nothing Xenomai can do about. Also, the MSI workaround is enabled but
fails. I hope that this does not cause problems for our purposes of using
Xenomai.

Thanks,
 peter



On Tue, Oct 12, 2010 at 10:25 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Am 12.10.2010 17:28, Peter Pastor wrote:
> > Hey Jan, Wolfgang,
> >
> >> You can't change reality (physical wiring) this way.
> > Well, I guess you are right !
> >
> >> If you do not need the USB interface, unbind the driver so that the
> >> Linux IRQ usage ends:
> >
> > I might not need the USB interface. At least there are 6 USB ports on the
> > back, so I hope I do not disable all of them.
> > However, besides the USB controller
> >
> > 00:1a.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)
> USB
> > UHCI Controller #4 [8086:3a37]
> >
> > the IRQ 16 is also shared by
> >
> > 05:00.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic
> SAS1068E
> > PCI-Express Fusion-MPT SAS [1000:0058] (rev 08)
>
> Then you might be lost if you can't live without that controller as well
> or flip PCI slots (see FAQ link below).
>
> >
> > which I guess I cannot simply unbind from the PCI bus... (check lspci.txt
> > attached)
> >
> > Also, I did a
> >
> > # echo 0000:00:1a.0 > /sys/bus/pci/drivers/ehci_hcd/unbind
> >
> > but it does work for me... --> bash: echo: write error: No such device
> > Do I have to have PCI hot-plugging enabled or some such ?
>
> No. Check what /sys/bus/pci/devices contains, which directory points to
> your USB controller.
>
> >
> > Also, I have seen in
> > /usr/src/xenomai-2.5.5.1/doc/generated/html/life-with-adeos that there
> > methods to share interrupts even between domains. So my question is, is
> > there an option that allows me to do so ? Is that recommended ?
> > Unfortunately, I am stuck to use this particular motherboard.
>
> Please see
>
> http://www.xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_devices_share_the_same_IRQ.3F
> and recent discussions on this list (or xenomai-devel, google will help).
>
> Jan
>
>

--0016363b7996a481cc04927981b7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Jan, Wolfgang, Gilles,<br><br>After actually trying to reroute the inte=
rrupt by cutting and jumping the pins on the PCI card we figured that there=
 was actually a 64bit PCI slot free. Also, according to wikipedia...=A0 &qu=
ot;PCI-X=A01.0b and PCI-X=A02.0 are backward compatible with some PCI stand=
ards.&quot; Thus, we simply stuck the card in that slot and got assigned an=
 interrupt that is not shared by other devices. Well, after rerouting thing=
s back to the initial configuration on the card, we were able to load the r=
tcan modules and communicate on the CAN bus !!<br>
<br>THANKS again for all the help and please let me know if you want me to =
run some tests. We are running xenomai 2.6.31 with xenomai 2.5.5.1 and thel=
inux_2.6.31-14.48.diff.gz ubuntu patch and the adeos-ipipe-2.6.31.8-x86-2.4=
-09.patch on a 64bit dell precision workstation T7500.<br>
<br>The only problem remaining is the fact that we get latency problems the=
 moment we start an opengl window but as mentioned in another thread, there=
 is nothing Xenomai can do about. Also, the MSI workaround is enabled but f=
ails. I hope that this does not cause problems for our purposes of using Xe=
nomai.<br>
<br>Thanks,<br>=A0peter<br><br><br><br><div class=3D"gmail_quote">On Tue, O=
ct 12, 2010 at 10:25 AM, Jan Kiszka <span dir=3D"ltr">&lt;<a href=3D"mailto=
:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px =
solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">Am 12.10.2010 17:28, Peter Pastor wrote:<br>
&gt; Hey Jan, Wolfgang,<br>
&gt;<br>
&gt;&gt; You can&#39;t change reality (physical wiring) this way.<br>
&gt; Well, I guess you are right !<br>
&gt;<br>
&gt;&gt; If you do not need the USB interface, unbind the driver so that th=
e<br>
&gt;&gt; Linux IRQ usage ends:<br>
&gt;<br>
&gt; I might not need the USB interface. At least there are 6 USB ports on =
the<br>
&gt; back, so I hope I do not disable all of them.<br>
&gt; However, besides the USB controller<br>
&gt;<br>
&gt; 00:1a.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family=
) USB<br>
&gt; UHCI Controller #4 [8086:3a37]<br>
&gt;<br>
&gt; the IRQ 16 is also shared by<br>
&gt;<br>
&gt; 05:00.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic SAS1=
068E<br>
&gt; PCI-Express Fusion-MPT SAS [1000:0058] (rev 08)<br>
<br>
</div>Then you might be lost if you can&#39;t live without that controller =
as well<br>
or flip PCI slots (see FAQ link below).<br>
<div class=3D"im"><br>
&gt;<br>
&gt; which I guess I cannot simply unbind from the PCI bus... (check lspci.=
txt<br>
&gt; attached)<br>
&gt;<br>
&gt; Also, I did a<br>
&gt;<br>
&gt; # echo 0000:00:1a.0 &gt; /sys/bus/pci/drivers/ehci_hcd/unbind<br>
&gt;<br>
&gt; but it does work for me... --&gt; bash: echo: write error: No such dev=
ice<br>
&gt; Do I have to have PCI hot-plugging enabled or some such ?<br>
<br>
</div>No. Check what /sys/bus/pci/devices contains, which directory points =
to<br>
your USB controller.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; Also, I have seen in<br>
&gt; /usr/src/xenomai-2.5.5.1/doc/generated/html/life-with-adeos that there=
<br>
&gt; methods to share interrupts even between domains. So my question is, i=
s<br>
&gt; there an option that allows me to do so ? Is that recommended ?<br>
&gt; Unfortunately, I am stuck to use this particular motherboard.<br>
<br>
</div>Please see<br>
<a href=3D"http://www.xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_a=
nd_Linux_devices_share_the_same_IRQ.3F" target=3D"_blank">http://www.xenoma=
i.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_devices_share_the_s=
ame_IRQ.3F</a><br>

and recent discussions on this list (or xenomai-devel, google will help).<b=
r>
<font color=3D"#888888"><br>
Jan<br>
<br>
</font></blockquote></div><br>

--0016363b7996a481cc04927981b7--

