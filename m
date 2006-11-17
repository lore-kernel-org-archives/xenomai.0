Message-ID: <54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>
Date: Fri, 17 Nov 2006 08:57:13 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
In-Reply-To: <455CC9DE.6030601@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_106890_14605186.1163750233303"
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>
	<455C8B8A.80105@domain.hid> <455CBC4A.5010108@domain.hid>
	<54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>
	<455CC9DE.6030601@domain.hid>
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_106890_14605186.1163750233303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

to get back on my earlier question: IF the memory mapping might work for me=
,
how should I call it?
The PCI card has two CAN ports. Here's (a part of) the output of lspci -vv:

Interrupt: pin A routed to IRQ 11
Region 0: Memory at e1003000 (32-bit, non prefetchable) [size=3D128]
Region 2: I/O ports at d800 [size=3D128]
Region 3: I/O ports at dc00 [size=3D128]
Region 4: I/O ports at e000 [size=3D4]

What should the insmod command to try if it might work?

Thanks again.

Frits

On 11/16/06, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> Frits de Klark wrote:
> > Hi,
> >
> > there is indeed a driver for the 2.4.x kernel series (including source)=
,
> > but onfortunately also a BIG FAT copyright statement at the heading of
> > the sources. Something like:
> >
> #########################################################################=
####
> >
> > //
> >
> *************************************************************************=
****
> >
> > //                  Copyright ( c ) 2003, Advantech Automation Corp.
> > //      THIS IS AN UNPUBLISHED WORK CONTAINING CONFIDENTIAL AND
> PROPRIETARY
> > //               INFORMATION WHICH IS THE PROPERTY OF ADVANTECH
> > AUTOMATION CORP.
> > //
> > //    ANY DISCLOSURE, USE, OR REPRODUCTION, WITHOUT WRITTEN
> > AUTHORIZATION FROM
> > //               ADVANTECH AUTOMATION CORP., IS STRICTLY PROHIBITED.
> > //
> >
> *************************************************************************=
****
> >
> > //
> >
> #########################################################################=
####
> >
> > So, I'll have to inquire them first before I (and the company I work
> > for) take the risk of disclosure.
> > I'll get back on this as soon as I can. If I can be of any help in the
> > meantime, I'll be glad to hear from you.
>
> Well, it might be simpler to buy an already supported CAN PCI card.
>
> > Thank for your time and interest so far.
>
> Good luck.
>
> Wolfgang.
>
> > Frits
> >
> > On 11/16/06, *Wolfgang Grandegger* <wg@domain.hid
> > <mailto:wg@domain.hid>> wrote:
> >
> >     Jan Kiszka wrote:
> >      > Frits de Klark wrote:
> >      >> Hello everyone,
> >      >>
> >      >> I finally got my PCI CAN card today. It's an Advantech 1680 and
> >      >> provides, as
> >      >> far as I'm informed, a memory mapped SJA1000 controller.
> >      >> I=B4m trying to load the xeno_rtcan_mem module now, but I'm not
> >     sure what
> >      >> parameters I should pass. More specific: What value(s) should I
> >     give to the
> >      >> 'mem' parameter? Is this an I/O address I found in /proc/pci
> >     under the 1680
> >      >> device?
> >      >
> >      > I'm not sure that this will work, but you can give it a try in
> >     any case.
> >      > Do you have a reference driver for that board? Or some manual
> >     describing
> >      > the mapping of the SJA1000 into the PCI address space?
> >
> >     It was not working for the IXXAT PCI card, at least (but I have not
> yet
> >     understodd why). Check with "$ lspci -vv" how the device is mapped
> and
> >     what IRQ number is used. The right thing is to implement a PCI
> driver.
> >
> >      > AFAIK, Wolfgang is working on a generic SJA1000 PCI driver. So
> far we
> >      > only have a driver for the PEAK PCI adapter, but that one is
> >     going to be
> >      > generalised. So you could become a first-grade test candidate fo=
r
> >      > another piece of hardware supported by that driver. :)
> >      >
> >      > Wolfgang, what the status?
> >
> >     As already mention, I'm currently working on a driver for the IXXAT
> PCI
> >     card. As I see it, a generic driver is not feasible as the mapping,
> the
> >     recognition of the second channel and the IRQ handling is quite
> >     different.
> >
> >     Is there a Linux driver on the CRROM your got with your Advantech
> 1680
> >     PCI card? That would help a lot.
> >
> >     Wolfgang.
> >
> >     Wolfgang.
> >
> >
>
>

------=_Part_106890_14605186.1163750233303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
to get back on my earlier question: IF the memory mapping might work for me=
, how should I call it?<br>
The PCI card has two CAN ports. Here's (a part of) the output of lspci -vv:=
<br>
<br>
Interrupt: pin A routed to IRQ 11<br>
Region 0: Memory at e1003000 (32-bit, non prefetchable) [size=3D128]<br>
Region 2: I/O ports at d800 [size=3D128]<br>
Region 3: I/O ports at dc00 [size=3D128]<br>
Region 4: I/O ports at e000 [size=3D4]<br>
<br>
What should the insmod command to try if it might work?<br>
<br>
Thanks again.<br>
<br>
Frits<br><br><div><span class=3D"gmail_quote">On 11/16/06, <b class=3D"gmai=
l_sendername">Wolfgang Grandegger</b> &lt;<a href=3D"mailto:wg@domain.hid=
om">wg@domain.hid</a>&gt; wrote:</span><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
Frits de Klark wrote:<br>&gt; Hi,<br>&gt;<br>&gt; there is indeed a driver =
for the 2.4.x kernel series (including source),<br>&gt; but onfortunately a=
lso a BIG FAT copyright statement at the heading of<br>&gt; the sources. So=
mething like:
<br>&gt; ##################################################################=
###########<br>&gt;<br>&gt; //<br>&gt; ************************************=
*****************************************<br>&gt;<br>&gt;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copyright
( c ) 2003, Advantech Automation Corp.<br>&gt; //&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;THIS IS AN UNPUBLISHED WORK CONTAINING CONFIDENTIAL AND PROPRIETA=
RY<br>&gt;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
INFORMATION WHICH IS THE PROPERTY OF ADVANTECH<br>&gt; AUTOMATION CORP.<br>=
&gt; //<br>&gt; //&nbsp;&nbsp;&nbsp;&nbsp;ANY DISCLOSURE, USE, OR REPRODUCT=
ION, WITHOUT WRITTEN<br>&gt; AUTHORIZATION FROM<br>&gt;
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
ADVANTECH AUTOMATION CORP., IS STRICTLY PROHIBITED.<br>&gt; //<br>&gt; ****=
*************************************************************************<b=
r>&gt;<br>&gt; //<br>&gt; #################################################=
############################
<br>&gt;<br>&gt; So, I'll have to inquire them first before I (and the comp=
any I work<br>&gt; for) take the risk of disclosure.<br>&gt; I'll get back =
on this as soon as I can. If I can be of any help in the<br>&gt; meantime, =
I'll be glad to hear from you.
<br><br>Well, it might be simpler to buy an already supported CAN PCI card.=
<br><br>&gt; Thank for your time and interest so far.<br><br>Good luck.<br>=
<br>Wolfgang.<br><br>&gt; Frits<br>&gt;<br>&gt; On 11/16/06, *Wolfgang Gran=
degger* &lt;
<a href=3D"mailto:wg@domain.hid">wg@domain.hid</a><br>&gt; &lt;mail=
to:<a href=3D"mailto:wg@domain.hid">wg@domain.hid</a>&gt;&gt; wrote=
:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Jan Kiszka wrote:<br>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; Frits de Klark wrote:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt; Hello everyone,<br>&gt=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&gt;&gt; I finally got my PCI CAN card today. It's an Advante=
ch 1680 and<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt; provides, a=
s<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt; far as I'm informed, =
a memory mapped SJA1000 controller.
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt; I=B4m trying to load t=
he xeno_rtcan_mem module now, but I'm not<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; s=
ure what<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt; parameters I s=
hould pass. More specific: What value(s) should I<br>&gt;&nbsp;&nbsp;&nbsp;=
&nbsp; give to the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt; 'mem=
' parameter? Is this an I/O address I found in /proc/pci
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; under the 1680<br>&gt;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&gt;&gt; device?<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; I'm not sure that thi=
s will work, but you can give it a try in<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; a=
ny case.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; Do you have a refe=
rence driver for that board? Or some manual
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; describing<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&gt; the mapping of the SJA1000 into the PCI address space?<br>=
&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; It was not working for the IXXAT PCI c=
ard, at least (but I have not yet<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; understod=
d why). Check with &quot;$ lspci -vv&quot; how the device is mapped and
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; what IRQ number is used. The right thing i=
s to implement a PCI driver.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&gt; AFAIK, Wolfgang is working on a generic SJA1000 PCI driver. So fa=
r we<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; only have a driver for=
 the PEAK PCI adapter, but that one is
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; going to be<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&gt; generalised. So you could become a first-grade test candi=
date for<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; another piece of h=
ardware supported by that driver. :)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; Wolfgang, what th=
e status?
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; As already mention, I'm currently =
working on a driver for the IXXAT PCI<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; card.=
 As I see it, a generic driver is not feasible as the mapping, the<br>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp; recognition of the second channel and the IRQ handl=
ing is quite
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; different.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbs=
p;&nbsp; Is there a Linux driver on the CRROM your got with your Advantech =
1680<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; PCI card? That would help a lot.<br>&g=
t;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Wolfgang.<br>&gt;<br>&gt;&nbsp;&nbsp;&nb=
sp;&nbsp; Wolfgang.<br>
&gt;<br>&gt;<br><br></blockquote></div><br>

------=_Part_106890_14605186.1163750233303--

