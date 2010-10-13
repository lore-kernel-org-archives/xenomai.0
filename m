MIME-Version: 1.0
In-Reply-To: <4CB54F93.4000102@domain.hid>
Message-ID: <000e0cd181a2825670049279be3a@domain.hid>
Date: Wed, 13 Oct 2010 06:31:31 +0000
From: peter.pastor@domain.hid
Content-Type: multipart/alternative; boundary=000e0cd181a2825653049279be37
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

--000e0cd181a2825653049279be37
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes

Hey Gilles,

Trying a different PCI slot is indeed one of the first things I considered.  
The problem was simply that I was looking for another 32bit PCI slot. I was  
not aware of the fact that the 32bit card works in a 64bit PCI slot.

We haven't tried setting NoAccl in the xorg.conf. But thanks for reminding.  
We will give it a try and let you know how it goes. The problem is somewhat  
that besides some real-time control loops we also would like to visualize  
some graphics that visualize some sensor information in non-real-time. Are  
there any other known issues with this setting besides latency ??

THANKS,
peter




On Oct 12, 2010 11:20pm, Gilles Chanteperdrix  
<gilles.chanteperdrix@xenomai.org> wrote:
> Peter Pastor wrote:

> > Hey Jan, Wolfgang, Gilles,

> >

> > After actually trying to reroute the interrupt by cutting and jumping

> > the pins on the PCI card we figured that there was actually a 64bit PCI

> > slot free. Also, according to wikipedia... "PCI-X 1.0b and PCI-X 2.0

> > are backward compatible with some PCI standards." Thus, we simply stuck

> > the card in that slot and got assigned an interrupt that is not shared

> > by other devices. Well, after rerouting things back to the initial

> > configuration on the card, we were able to load the rtcan modules and

> > communicate on the CAN bus !!

> >

> > THANKS again for all the help and please let me know if you want me to

> > run some tests. We are running xenomai 2.6.31 with xenomai 2.5.5.1 and

> > thelinux_2.6.31-14.48.diff.gz ubuntu patch and the

> > adeos-ipipe-2.6.31.8-x86-2.4-09.patch on a 64bit dell precision

> > workstation T7500.

> >

> > The only problem remaining is the fact that we get latency problems the

> > moment we start an opengl window but as mentioned in another thread,

> > there is nothing Xenomai can do about. Also, the MSI workaround is

> > enabled but fails. I hope that this does not cause problems for our

> > purposes of using Xenomai.



> Hi Peter,



> good news. Moving the card in the slot was what I was among the things I

> was thinking about when I suggested you to look at the FAQ. So,

> apparently, I was not precise enough. The same goes for the X issue,

> when I told you to look at the TROUBLESHOOTING guide, the

> TROUBLESHOOTING guide suggests to use "NoAccel" in the X server

> configuration. Did you try that?



> Regards.



> --

> Gilles.


--000e0cd181a2825653049279be37
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Gilles,<br /><br />Trying a different PCI slot is indeed one of the fir=
st things I considered. The problem was simply that I was looking for anoth=
er 32bit PCI slot. I was not aware of the fact that the 32bit card works in=
 a 64bit PCI slot.<br /><br />We haven&#39;t tried setting NoAccl in the xo=
rg.conf. But thanks for reminding. We will give it a try and let you know h=
ow it goes. The problem is somewhat that besides some real-time control loo=
ps we also would like to visualize some graphics that visualize some sensor=
 information in non-real-time. Are there any other known issues with this s=
etting besides latency ?? <br /><br />THANKS,<br /> peter<br /><br /><br />=
<br /><br />On Oct 12, 2010 11:20pm, Gilles Chanteperdrix &lt;gilles.chante=
perdrix@domain.hid&gt; wrote:<br />&gt; Peter Pastor wrote:<br />&gt; <br =
/>&gt; &gt; Hey Jan, Wolfgang, Gilles,<br />&gt; <br />&gt; &gt;<br />&gt; =
<br />&gt; &gt; After actually trying to reroute the interrupt by cutting a=
nd jumping<br />&gt; <br />&gt; &gt; the pins on the PCI card we figured th=
at there was actually a 64bit PCI<br />&gt; <br />&gt; &gt; slot free. Also=
, according to wikipedia... =A0&quot;PCI-X 1.0b and PCI-X 2.0<br />&gt; <br=
 />&gt; &gt; are backward compatible with some PCI standards.&quot; Thus, w=
e simply stuck<br />&gt; <br />&gt; &gt; the card in that slot and got assi=
gned an interrupt that is not shared<br />&gt; <br />&gt; &gt; by other dev=
ices. Well, after rerouting things back to the initial<br />&gt; <br />&gt;=
 &gt; configuration on the card, we were able to load the rtcan modules and=
<br />&gt; <br />&gt; &gt; communicate on the CAN bus !!<br />&gt; <br />&g=
t; &gt;<br />&gt; <br />&gt; &gt; THANKS again for all the help and please =
let me know if you want me to<br />&gt; <br />&gt; &gt; run some tests. We =
are running xenomai 2.6.31 with xenomai 2.5.5.1 and<br />&gt; <br />&gt; &g=
t; thelinux_2.6.31-14.48.diff.gz ubuntu patch and the<br />&gt; <br />&gt; =
&gt; adeos-ipipe-2.6.31.8-x86-2.4-09.patch on a 64bit dell precision<br />&=
gt; <br />&gt; &gt; workstation T7500.<br />&gt; <br />&gt; &gt;<br />&gt; =
<br />&gt; &gt; The only problem remaining is the fact that we get latency =
problems the<br />&gt; <br />&gt; &gt; moment we start an opengl window but=
 as mentioned in another thread,<br />&gt; <br />&gt; &gt; there is nothing=
 Xenomai can do about. Also, the MSI workaround is<br />&gt; <br />&gt; &gt=
; enabled but fails. I hope that this does not cause problems for our<br />=
&gt; <br />&gt; &gt; purposes of using Xenomai.<br />&gt; <br />&gt; <br />=
&gt; <br />&gt; Hi Peter,<br />&gt; <br />&gt; <br />&gt; <br />&gt; good n=
ews. Moving the card in the slot was what I was among the things I<br />&gt=
; <br />&gt; was thinking about when I suggested you to look at the FAQ. So=
,<br />&gt; <br />&gt; apparently, I was not precise enough. The same goes =
for the X issue,<br />&gt; <br />&gt; when I told you to look at the TROUBL=
ESHOOTING guide, the<br />&gt; <br />&gt; TROUBLESHOOTING guide suggests to=
 use &quot;NoAccel&quot; in the X server<br />&gt; <br />&gt; configuration=
. Did you try that?<br />&gt; <br />&gt; <br />&gt; <br />&gt; Regards.<br =
/>&gt; <br />&gt; <br />&gt; <br />&gt; --<br />&gt; <br />&gt;  =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br />&gt;
--000e0cd181a2825653049279be37--

