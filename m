Message-ID: <BLU166-W191D2D0ED4DB5D1AC8B0C5C4820@domain.hid>
Content-Type: multipart/alternative;
	boundary="_068309e1-0f17-4a46-91bd-f203bdff3dd1_"
From: Jan-Erik Lange <jan0385@domain.hid>
Date: Sun, 15 Jan 2012 19:55:44 +0100
In-Reply-To: <BLU166-W8A6F8615612DBB382F22FC4820@domain.hid>
References: <BLU166-W49F600F976B754BCA60E03C4820@domain.hid>,
	<4F130ED3.3030902@domain.hid>,
	<BLU166-W8A6F8615612DBB382F22FC4820@domain.hid>
MIME-Version: 1.0
Subject: [Xenomai-core] FW:  realtime pipes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--_068309e1-0f17-4a46-91bd-f203bdff3dd1_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



=20



From: jan0385@domain.hid
To: gilles.chanteperdrix@xenomai.org
Subject: RE: [Xenomai-core] realtime pipes
Date: Sun=2C 15 Jan 2012 19:38:01 +0100






=20


> Date: Sun=2C 15 Jan 2012 18:37:23 +0100
> From: gilles.chanteperdrix@xenomai.org
> To: jan0385@domain.hid
> CC: xenomai@xenomai.org
> Subject: Re: [Xenomai-core] realtime pipes
>=20
> On 01/15/2012 01:36 PM=2C Jan-Erik Lange wrote:
> >=20
> > Hello=2C
> >=20
> > it is possible to access a real-time pipe /dev/rtpx within the kernel
> > space of Linux? Since there is no open function?
>=20
> Real-time pipes are deprecated.
>=20
=20
=20
Are realtime pipes deprecated at all or only in kernel space?
 And why is the documentation so obsolete? I didn't heard this information =
since yet..
=20

> >=20
> > Is it therefore possible to communicate between the Xenomai Kernel
> > space and the Linux Kernel space?
>=20
> As mentioned several time=2C using anything else in kernel-space than the
> RTDM API is deprecated. If you are interested in the services the RTDM
> api offers=2C see:
>=20
> http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__driverap=
i.html
>=20
> For instance=2C you can see a section named "non-real-time signalling
> services"=2C which probably answers your question.
>=20
> --=20
> Gilles.
 		 	   		  =

--_068309e1-0f17-4a46-91bd-f203bdff3dd1_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
<BR>&nbsp=3B<BR>
<DIV>
<DIV id=3DSkyDrivePlaceholder></DIV>
<HR id=3DstopSpelling>
From: jan0385@domain.hid<BR>To: gilles.chanteperdrix@xenomai.org<BR>Subject=
: RE: [Xenomai-core] realtime pipes<BR>Date: Sun=2C 15 Jan 2012 19:38:01 +0=
100<BR><BR>
<META name=3DGenerator content=3D"Microsoft SafeHTML">
<STYLE>
.ExternalClass .ecxhmmessage P
{padding:0px=3B}
.ExternalClass body.ecxhmmessage
{font-size:10pt=3Bfont-family:Tahoma=3B}

</STYLE>

<DIV dir=3Dltr><BR>&nbsp=3B<BR>
<DIV id=3DecxSkyDrivePlaceholder></DIV>
<DIV>&gt=3B Date: Sun=2C 15 Jan 2012 18:37:23 +0100<BR>&gt=3B From: gilles.=
chanteperdrix@domain.hid<BR>&gt=3B To: jan0385@domain.hid<BR>&gt=3B CC: xe=
nomai-core@domain.hid<BR>&gt=3B Subject: Re: [Xenomai-core] realtime pipes<BR>=
&gt=3B <BR>&gt=3B On 01/15/2012 01:36 PM=2C Jan-Erik Lange wrote:<BR>&gt=3B=
 &gt=3B <BR>&gt=3B &gt=3B Hello=2C<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B it is=
 possible to access a real-time pipe /dev/rtpx within the kernel<BR>&gt=3B =
&gt=3B space of Linux? Since there is no open function?<BR>&gt=3B <BR>&gt=
=3B Real-time pipes are deprecated.<BR>&gt=3B </DIV>
<DIV>&nbsp=3B</DIV>
<DIV>&nbsp=3B</DIV>
<DIV>Are realtime pipes deprecated at all or only in kernel space?</DIV>
<DIV>&nbsp=3BAnd why is the documentation so obsolete? I didn't heard this =
information since yet..</DIV>
<DIV>&nbsp=3B</DIV>
<DIV><BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Is it therefore possible to commun=
icate between the Xenomai Kernel<BR>&gt=3B &gt=3B space and the Linux Kerne=
l space?<BR>&gt=3B <BR>&gt=3B As mentioned several time=2C using anything e=
lse in kernel-space than the<BR>&gt=3B RTDM API is deprecated. If you are i=
nterested in the services the RTDM<BR>&gt=3B api offers=2C see:<BR>&gt=3B <=
BR>&gt=3B http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__=
driverapi.html<BR>&gt=3B <BR>&gt=3B For instance=2C you can see a section n=
amed "non-real-time signalling<BR>&gt=3B services"=2C which probably answer=
s your question.<BR>&gt=3B <BR>&gt=3B -- <BR>&gt=3B Gilles.<BR></DIV></DIV>=
</DIV> 		 	   		  </div></body>
</html>=

--_068309e1-0f17-4a46-91bd-f203bdff3dd1_--

