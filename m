Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA2A14.E4A45364"
Date: Mon, 31 Aug 2009 10:27:35 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A9CE@XVS-DCFR-21.europe.corp.altran.com>
References: <EB48F2CADC239E44A8598CC0B0571102E4A9CC@XVS-DCFR-21.europe.corp.altran.com>
	<4A979E12.6070508@domain.hid>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] =?iso-8859-1?q?RE=A0=3A__Error_compiling_Xenomai_2?=
	=?iso-8859-1?q?=2E4=2E8_with_I-pipe_tracer?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA2A14.E4A45364
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

>> I can't achieve the compilation process when I enable the I-pipe =
tracer.
>> I've tried some mixed configurations but it always fails with an =
error.
>> I use :
>>=20
>>  - gcc version 4.2.3 (Sourcery G++ Lite 2008q1-126)
>>  - GNU C Library stable release version 2.5, by Roland McGrath et al.
>=20
>
> It is a known toolchain issue, you are using a toolchain too recent =
for
> this kernel version. This is a mainline bug, there is a fix, but I do
> not know if it has been merged yet. Though according to the fix, this
> gnu_mcount stuff comes with gcc 4.4, so I am not sure you use the
> compiler you think you are using.


As I wrote, it's the version 2008q1 from CodeSourcery. I only type this
command:
arm-none-linux-gnueabi-gcc --version

We can suppose that they applied a patch on their own version.


> So, either downgrade your toolchain (I bet 2007q3 works, since it is =
the
> one I have been using for a long time), when you want to use the =
tracer.
> Or apply the patches which have been published on the linux-arm-kernel
> mailing list.


Using the 2007q3 toolchain, I get the same error than in the mailing =
list
thread: "at91sam9263 and user-space support compile fails". The use of =
this
toolchain doesn't solve the problem for me.

When I checked the toolchain I get from CodeSourcery, I saw that it =
doesn't
come with a cross-compile libc. If the package doesn't provide a =
complete
library, I suppose it doesn't come with header files either.


Best regards,
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien
| Trainee at Altran Ouest
| Centre d'Affaires Alphasis
| 35760 Saint-Gr=E9goire - FRANCE
| Tel: 06-76-35-29-55
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

------_=_NextPart_001_01CA2A14.E4A45364
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE=A0: [Xenomai-help] Error compiling Xenomai 2.4.8 with I-pipe =
tracer</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
&gt;&gt; I can't achieve the compilation process when I enable the =
I-pipe tracer.<BR>
&gt;&gt; I've tried some mixed configurations but it always fails with =
an error.<BR>
&gt;&gt; I use :<BR>
&gt;&gt;<BR>
&gt;&gt;&nbsp; - gcc version 4.2.3 (Sourcery G++ Lite 2008q1-126)<BR>
&gt;&gt;&nbsp; - GNU C Library stable release version 2.5, by Roland =
McGrath et al.<BR>
&gt;<BR>
&gt;<BR>
&gt; It is a known toolchain issue, you are using a toolchain too recent =
for<BR>
&gt; this kernel version. This is a mainline bug, there is a fix, but I =
do<BR>
&gt; not know if it has been merged yet. Though according to the fix, =
this<BR>
&gt; gnu_mcount stuff comes with gcc 4.4, so I am not sure you use =
the<BR>
&gt; compiler you think you are using.<BR>
<BR>
<BR>
As I wrote, it's the version 2008q1 from CodeSourcery. I only type =
this<BR>
command:<BR>
arm-none-linux-gnueabi-gcc --version<BR>
<BR>
We can suppose that they applied a patch on their own version.<BR>
<BR>
<BR>
&gt; So, either downgrade your toolchain (I bet 2007q3 works, since it =
is the<BR>
&gt; one I have been using for a long time), when you want to use the =
tracer.<BR>
&gt; Or apply the patches which have been published on the =
linux-arm-kernel<BR>
&gt; mailing list.<BR>
<BR>
<BR>
Using the 2007q3 toolchain, I get the same error than in the mailing =
list<BR>
thread: &quot;at91sam9263 and user-space support compile fails&quot;. =
The use of this<BR>
toolchain doesn't solve the problem for me.<BR>
<BR>
When I checked the toolchain I get from CodeSourcery, I saw that it =
doesn't<BR>
come with a cross-compile libc. If the package doesn't provide a =
complete<BR>
library, I suppose it doesn't come with header files either.<BR>
<BR>
<BR>
Best regards,<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
| BERRUER S=E9bastien<BR>
| Trainee at Altran Ouest<BR>
| Centre d'Affaires Alphasis<BR>
| 35760 Saint-Gr=E9goire - FRANCE<BR>
| Tel: 06-76-35-29-55<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA2A14.E4A45364--

