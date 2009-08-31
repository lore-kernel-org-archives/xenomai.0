Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA2A22.6142D5D4"
Date: Mon, 31 Aug 2009 12:04:08 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A9D0@domain.hid>
References: <EB48F2CADC239E44A8598CC0B0571102E4A9CC@XVS-DCFR-21.europe.corp.altran.com>	<4A979E12.6070508@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9CE@XVS-DCFR-21.europe.corp.altran.com>
	<4A9B8EF4.9050607@domain.hid>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] =?iso-8859-1?q?RE=A0=3A__RE_=3A__Error_compiling_X?=
	=?iso-8859-1?q?enomai_2=2E4=2E8_with_I-pipe_tracer?=
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

------_=_NextPart_001_01CA2A22.6142D5D4
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
=20
>>> I can't achieve the compilation process when I enable the I-pipe =
tracer.
>>> I've tried some mixed configurations but it always fails with an =
error.
>>
>> So, either downgrade your toolchain (I bet 2007q3 works, since it is =
the
>> one I have been using for a long time), when you want to use the =
tracer.
>> Or apply the patches which have been published on the =
linux-arm-kernel
>> mailing list.
> =20
> Using the 2007q3 toolchain, I get the same error than in the mailing =
list
> thread: "at91sam9263 and user-space support compile fails". The use of =
this
> toolchain doesn't solve the problem for me.

I'm refering to:
https://mail.gna.org/public/xenomai-help/2008-05/msg00123.html

This person had the same problem that I have. The use of the 2007q3 =
toolchain
solved his problem.
=20
>> When I checked the toolchain I get from CodeSourcery, I saw that it =
doesn't
>> come with a cross-compile libc. If the package doesn't provide a =
complete
>> library, I suppose it doesn't come with header files either.
>
> What are you talking about? Codesourcery toolchain comes with several
> cross-compiled libcs (armv4, armv6) and all the necessary headers. Are
> you sure you have not downloaded the "free-standing" version?

I downloaded the toolchain from:
http://www.codesourcery.com/sgpp/lite/arm/portal/release316

It's the free version but it's supposed to have a Newlib library. Why =
can't I
find any *.so? I only have *.a files. Must I only statically compile my =
software?


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


------_=_NextPart_001_01CA2A22.6142D5D4
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
<TITLE>RE=A0: [Xenomai-help] RE :  Error compiling Xenomai 2.4.8 with =
I-pipe tracer</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
&gt;&gt;&gt; I can't achieve the compilation process when I enable the =
I-pipe tracer.<BR>
&gt;&gt;&gt; I've tried some mixed configurations but it always fails =
with an error.<BR>
&gt;&gt;<BR>
&gt;&gt; So, either downgrade your toolchain (I bet 2007q3 works, since =
it is the<BR>
&gt;&gt; one I have been using for a long time), when you want to use =
the tracer.<BR>
&gt;&gt; Or apply the patches which have been published on the =
linux-arm-kernel<BR>
&gt;&gt; mailing list.<BR>
&gt;&nbsp;<BR>
&gt; Using the 2007q3 toolchain, I get the same error than in the =
mailing list<BR>
&gt; thread: &quot;at91sam9263 and user-space support compile =
fails&quot;. The use of this<BR>
&gt; toolchain doesn't solve the problem for me.<BR>
<BR>
I'm refering to:<BR>
<A =
HREF=3D"https://mail.gna.org/public/xenomai-help/2008-05/msg00123.html">h=
ttps://mail.gna.org/public/xenomai-help/2008-05/msg00123.html</A><BR>
<BR>
This person had the same problem that I have. The use of the 2007q3 =
toolchain<BR>
solved his problem.<BR>
<BR>
&gt;&gt; When I checked the toolchain I get from CodeSourcery, I saw =
that it doesn't<BR>
&gt;&gt; come with a cross-compile libc. If the package doesn't provide =
a complete<BR>
&gt;&gt; library, I suppose it doesn't come with header files =
either.<BR>
&gt;<BR>
&gt; What are you talking about? Codesourcery toolchain comes with =
several<BR>
&gt; cross-compiled libcs (armv4, armv6) and all the necessary headers. =
Are<BR>
&gt; you sure you have not downloaded the &quot;free-standing&quot; =
version?<BR>
<BR>
I downloaded the toolchain from:<BR>
<A =
HREF=3D"http://www.codesourcery.com/sgpp/lite/arm/portal/release316">http=
://www.codesourcery.com/sgpp/lite/arm/portal/release316</A><BR>
<BR>
It's the free version but it's supposed to have a Newlib library. Why =
can't I<BR>
find any *.so? I only have *.a files. Must I only statically compile my =
software?<BR>
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
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA2A22.6142D5D4--

