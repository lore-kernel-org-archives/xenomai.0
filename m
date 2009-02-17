MIME-Version: 1.0
In-Reply-To: <200902170000.00900.berlemont.hauw@domain.hid>
References: <9c789a000902160455k7dcae1d2tc151b12df6140ec0@domain.hid>
	<200902170000.00900.berlemont.hauw@domain.hid>
Date: Tue, 17 Feb 2009 10:10:51 +0200
Message-ID: <9c789a000902170010p11c889esb7a01ff8b862b5a0@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d77c9d6b0c29046318d785
Subject: Re: [Xenomai-core] Comedi drivers in Xenomai porting/integration
	status ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

--0016e6d77c9d6b0c29046318d785
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello

On Tue, Feb 17, 2009 at 1:00 AM, Alexis Berlemont <berlemont.hauw@domain.hid>wrote:

> Hi,
>
> > Hello all! I would like to know what is the current status of the Comedi
> > port to Xenomai.
> >
> > Should all the specific Comedi drivers (ni_pcimio, ni_mite) be available
> > for testing (by me or someone with a supported DAQ card) and (if ok) for
> > futher integration ?
>
> I am still working on that port. It is a long work and I am wondering at
> each
> line whether I should rewrite any part of code which does not comply with
> common coding constraints. Unfortunately, I currently do not have a lot of
> spare time. Anyway, most of the ni subdevices drivers have been ported
> (mite,
> tio, mio, 8255). I am trying to finalize the global driver port.


So shall we have a first version to test into the trunk?

>
>
> By the way, in the middle of january, I noticed that the legacy Comedi
> branch
> found its way into the mainline (through the staging tree). I do not know
> what will be the future of such a package in mainstream. I assume the main
> goal is the definition of a global framework for acquisition boards like
> V4L2
> is for video cards.


I'm not sure of this due to the fact that are still more users in the
industry area that are
using Comedi for their DAQ cards.


>
>
> Starting from here, I have been thinking on some alternatives so as to
> benefit
> from the kernel code. But I am a bit perplexed as the code does not seem to
> evolve a lot (the 2.6.29-rc5 patch still contains some rtlinux/rtai/fusion
> related code). I was unable to notice any significant work on the framework
> to reach main kernel standards.
>
> Since the beginning of January, there was only one mail thread which dealt
> with Comedi on the lkml (which is, by the way, interesting):
> http://lkml.org/lkml/2009/2/9/335


I was aware of that article but I think that before starting optimizing the
code for certain needs it is necessary to
have just a ported version that fulfilled the needs for most users using
RTAI. Indeed some modifications are needed (memory mapping for low level DIO
!!) but they are local, so
patching will be available for the interested part of the Xenomai community
in upgrading the drivers. Due to the importance of integrating these drivers
into Xenomai you should consider
that the improvement of the code will be progressive as the users experience
new challenges with their hardware in RT apps.

>
> I would be very interested in opening a discussion on that issue so as to
> define Comedi's next steps in Xenomai.


good idea !



>
> Alexis.


Best,

Cristian

>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>

--0016e6d77c9d6b0c29046318d785
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br><div class=3D"gmail_quote">On Tue, Feb 17, 2009 at 1:00 AM, Al=
exis Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:berlemont.hauw@domain.hid.=
fr">berlemont.hauw@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br>
<div><div></div><div class=3D"Wj3C7c"><br>
&gt; Hello all! I would like to know what is the current status of the Come=
di<br>
&gt; port to Xenomai.<br>
&gt;<br>
&gt; Should all the specific Comedi drivers (ni_pcimio, ni_mite) be availab=
le<br>
&gt; for testing (by me or someone with a supported DAQ card) and (if ok) f=
or<br>
&gt; futher integration ?<br>
<br>
</div></div>I am still working on that port. It is a long work and I am won=
dering at each<br>
line whether I should rewrite any part of code which does not comply with<b=
r>
common coding constraints. Unfortunately, I currently do not have a lot of<=
br>
spare time. Anyway, most of the ni subdevices drivers have been ported (mit=
e,<br>
tio, mio, 8255). I am trying to finalize the global driver port.</blockquot=
e><div><br>So shall we have a first version to test into the trunk? <br></d=
iv><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(20=
4, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<br>
By the way, in the middle of january, I noticed that the legacy Comedi bran=
ch<br>
found its way into the mainline (through the staging tree). I do not know<b=
r>
what will be the future of such a package in mainstream. I assume the main<=
br>
goal is the definition of a global framework for acquisition boards like V4=
L2<br>
is for video cards.</blockquote><div><br>I&#39;m not sure of this due to th=
e fact that are still more users in the industry area that are <br>using Co=
medi for their DAQ cards.<br>&nbsp;<br></div><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
<br>
<br>
Starting from here, I have been thinking on some alternatives so as to bene=
fit<br>
from the kernel code. But I am a bit perplexed as the code does not seem to=
<br>
evolve a lot (the 2.6.29-rc5 patch still contains some rtlinux/rtai/fusion<=
br>
related code). I was unable to notice any significant work on the framework=
<br>
to reach main kernel standards.<br>
<br>
Since the beginning of January, there was only one mail thread which dealt<=
br>
with Comedi on the lkml (which is, by the way, interesting):<br>
<a href=3D"http://lkml.org/lkml/2009/2/9/335" target=3D"_blank">http://lkml=
.org/lkml/2009/2/9/335</a></blockquote><div>&nbsp;</div><div>I was aware of=
 that article but I think that before starting optimizing the code for cert=
ain needs it is necessary to<br>

have just a ported version that fulfilled the needs for most users
using RTAI. Indeed some modifications are needed (memory mapping for
low level DIO !!) but they are local, so <br>
patching will be available for the interested part of the Xenomai
community in upgrading the drivers. Due to the importance of
integrating these drivers into Xenomai you should consider<br>
that the improvement of the code will be progressive as the users experienc=
e new challenges with their hardware in RT apps. <br></div><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
I would be very interested in opening a discussion on that issue so as to<b=
r>
define Comedi&#39;s next steps in Xenomai.</blockquote><div><br>good idea !=
<br><br><br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1=
px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"=
>
<br>
<br>
Alexis.</blockquote><div><br>Best,<br><br>Cristian <br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); mar=
gin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
_______________________________________________<br>
Xenomai-core mailing list<br>
<a href=3D"mailto:Xenomai-core@domain.hid">Xenomai-core@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-core" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-core</a><br>
</blockquote></div><br>

--0016e6d77c9d6b0c29046318d785--

