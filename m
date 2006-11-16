Message-ID: <54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>
Date: Thu, 16 Nov 2006 21:00:19 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
In-Reply-To: <455CBC4A.5010108@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_98548_6337022.1163707219827"
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>
	<455C8B8A.80105@domain.hid> <455CBC4A.5010108@domain.hid>
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

------=_Part_98548_6337022.1163707219827
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

there is indeed a driver for the 2.4.x kernel series (including source), bu=
t
onfortunately also a BIG FAT copyright statement at the heading of the
sources. Something like:
###########################################################################=
##

//
***************************************************************************=
**

//                  Copyright ( c ) 2003, Advantech Automation Corp.
//      THIS IS AN UNPUBLISHED WORK CONTAINING CONFIDENTIAL AND PROPRIETARY
//               INFORMATION WHICH IS THE PROPERTY OF ADVANTECH AUTOMATION
CORP.
//
//    ANY DISCLOSURE, USE, OR REPRODUCTION, WITHOUT WRITTEN AUTHORIZATION
FROM
//               ADVANTECH AUTOMATION CORP., IS STRICTLY PROHIBITED.
//
***************************************************************************=
**

//
###########################################################################=
##

So, I'll have to inquire them first before I (and the company I work for)
take the risk of disclosure.
I'll get back on this as soon as I can. If I can be of any help in the
meantime, I'll be glad to hear from you.

Thank for your time and interest so far.

Frits

On 11/16/06, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> Jan Kiszka wrote:
> > Frits de Klark wrote:
> >> Hello everyone,
> >>
> >> I finally got my PCI CAN card today. It's an Advantech 1680 and
> >> provides, as
> >> far as I'm informed, a memory mapped SJA1000 controller.
> >> I=B4m trying to load the xeno_rtcan_mem module now, but I'm not sure w=
hat
> >> parameters I should pass. More specific: What value(s) should I give t=
o
> the
> >> 'mem' parameter? Is this an I/O address I found in /proc/pci under the
> 1680
> >> device?
> >
> > I'm not sure that this will work, but you can give it a try in any case=
.
> > Do you have a reference driver for that board? Or some manual describin=
g
> > the mapping of the SJA1000 into the PCI address space?
>
> It was not working for the IXXAT PCI card, at least (but I have not yet
> understodd why). Check with "$ lspci -vv" how the device is mapped and
> what IRQ number is used. The right thing is to implement a PCI driver.
>
> > AFAIK, Wolfgang is working on a generic SJA1000 PCI driver. So far we
> > only have a driver for the PEAK PCI adapter, but that one is going to b=
e
> > generalised. So you could become a first-grade test candidate for
> > another piece of hardware supported by that driver. :)
> >
> > Wolfgang, what the status?
>
> As already mention, I'm currently working on a driver for the IXXAT PCI
> card. As I see it, a generic driver is not feasible as the mapping, the
> recognition of the second channel and the IRQ handling is quite different=
.
>
> Is there a Linux driver on the CRROM your got with your Advantech 1680
> PCI card? That would help a lot.
>
> Wolfgang.
>
> Wolfgang.
>
>

------=_Part_98548_6337022.1163707219827
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
there is indeed a driver for the 2.4.x kernel series (including
source), but onfortunately also a BIG FAT copyright statement at the
heading of the sources. Something like: <br>
###########################################################################=
##
<br>
// ************************************************************************=
*****
<br>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Copyright ( c ) 2003, Advantech Automation Corp.
<br>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; THIS IS AN UNPUBLISHED WORK CONTAINING CON=
FIDENTIAL AND PROPRIETARY
<br>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
INFORMATION WHICH IS THE PROPERTY OF ADVANTECH AUTOMATION CORP.
<br>
//
<br>
//&nbsp;&nbsp;&nbsp; ANY DISCLOSURE, USE, OR REPRODUCTION, WITHOUT WRITTEN =
AUTHORIZATION FROM
<br>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
ADVANTECH AUTOMATION CORP., IS STRICTLY PROHIBITED.
<br>
// ************************************************************************=
*****
<br>
// ########################################################################=
#####<br><br>
So, I'll have to inquire them first before I (and the company I work for) t=
ake the risk of disclosure.<br>
I'll get back on this as soon as I can. If I can be of any help in the mean=
time, I'll be glad to hear from you.<br>
<br>
Thank for your time and interest so far.<br>
<br>
Frits<br>
<br><div><span class=3D"gmail_quote">On 11/16/06, <b class=3D"gmail_sendern=
ame">Wolfgang Grandegger</b> &lt;<a href=3D"mailto:wg@domain.hid">wg@domain.hid=
andegger.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Jan Kiszka wrote:<br>&gt; Frits de Klark wrote:<br>&gt;&gt; Hello everyone,=
<br>&gt;&gt;<br>&gt;&gt; I finally got my PCI CAN card today. It's an Advan=
tech 1680 and<br>&gt;&gt; provides, as<br>&gt;&gt; far as I'm informed, a m=
emory mapped SJA1000 controller.
<br>&gt;&gt; I=B4m trying to load the xeno_rtcan_mem module now, but I'm no=
t sure what<br>&gt;&gt; parameters I should pass. More specific: What value=
(s) should I give to the<br>&gt;&gt; 'mem' parameter? Is this an I/O addres=
s I found in /proc/pci under the 1680
<br>&gt;&gt; device?<br>&gt;<br>&gt; I'm not sure that this will work, but =
you can give it a try in any case.<br>&gt; Do you have a reference driver f=
or that board? Or some manual describing<br>&gt; the mapping of the SJA1000=
 into the PCI address space?
<br><br>It was not working for the IXXAT PCI card, at least (but I have not=
 yet<br>understodd why). Check with &quot;$ lspci -vv&quot; how the device =
is mapped and<br>what IRQ number is used. The right thing is to implement a=
 PCI driver.
<br><br>&gt; AFAIK, Wolfgang is working on a generic SJA1000 PCI driver. So=
 far we<br>&gt; only have a driver for the PEAK PCI adapter, but that one i=
s going to be<br>&gt; generalised. So you could become a first-grade test c=
andidate for
<br>&gt; another piece of hardware supported by that driver. :)<br>&gt;<br>=
&gt; Wolfgang, what the status?<br><br>As already mention, I'm currently wo=
rking on a driver for the IXXAT PCI<br>card. As I see it, a generic driver =
is not feasible as the mapping, the
<br>recognition of the second channel and the IRQ handling is quite differe=
nt.<br><br>Is there a Linux driver on the CRROM your got with your Advantec=
h 1680<br>PCI card? That would help a lot.<br><br>Wolfgang.<br><br>Wolfgang=
.
<br><br></blockquote></div><br>

------=_Part_98548_6337022.1163707219827--

