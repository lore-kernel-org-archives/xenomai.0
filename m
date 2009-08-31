Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA2A30.C8DA2148"
Date: Mon, 31 Aug 2009 13:47:15 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A9D1@domain.hid>
References: <EB48F2CADC239E44A8598CC0B0571102E4A9CC@XVS-DCFR-21.europe.corp.altran.com>	<4A979E12.6070508@domain.hid>	<EB48F2CADC239E44A8598CC0B0571102E4A9CE@XVS-DCFR-21.europe.corp.altran.com>	<4A9B8EF4.9050607@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9D0@domain.hid>
	<4A9BABC9.1030506@domain.hid>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] =?iso-8859-1?q?RE=A0=3A__RE_=3A__RE_=3A__Error_com?=
	=?iso-8859-1?q?piling_Xenomai_2=2E4=2E8_with_I-pipe_tracer?=
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

------_=_NextPart_001_01CA2A30.C8DA2148
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

>> I downloaded the toolchain from:
>> http://www.codesourcery.com/sgpp/lite/arm/portal/release316
>>=20
>> It's the free version but it's supposed to have a Newlib library. Why
>> can't I
>> find any *.so? I only have *.a files. Must I only statically compile =
my
>> software?
>
> No. This version is the free-standing version, made to compile code
> without an OS. This is sufficient for compiling the Linux kernel, not
> for compiling any Linux user-space applications. What you should
> download is:
>=20
> http://www.codesourcery.com/sgpp/lite/arm/portal/release313

Thank you for the link. I'll try this.

NOTE: for anyone who's interested
I applied the patch found in:
http://marc.info/?l=3Dlinux-arm-kernel&m=3D124946219616111&w=3D2

And try to compile the kernel with the 2008q1 toolchain but it fails =
with:
[...]
  LD      .tmp_vmlinux1
init/built-in.o: In function `do_one_initcall':
calibrate.c:(.text+0x14): undefined reference to `__gnu_mcount_nc'
init/built-in.o: In function `run_init_process':
calibrate.c:(.text+0x1b0): undefined reference to `__gnu_mcount_nc'
init/built-in.o: In function `init_post':
calibrate.c:(.text+0x1e0): undefined reference to `__gnu_mcount_nc'
init/built-in.o: In function `name_to_dev_t':
calibrate.c:(.text+0x2e0): undefined reference to `__gnu_mcount_nc'
init/built-in.o: In function `rest_init':
calibrate.c:(.ref.text+0x10): undefined reference to `__gnu_mcount_nc'
init/built-in.o:calibrate.c:(.cpuinit.text+0x10): more undefined =
references to `__gnu_mcount_nc' follow
make[3]: *** [.tmp_vmlinux1] Erreur 1
make[2]: *** [sub-make] Erreur 2
make[1]: *** [zImage] Erreur 2
make: *** [sub-make] Erreur 2

Even if the patch permits the export of both symbols.


Thank you for help,
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien
| Trainee at Altran Ouest
| Centre d'Affaires Alphasis
| 35760 Saint-Gr=E9goire - FRANCE
| Tel: 06-76-35-29-55
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

------_=_NextPart_001_01CA2A30.C8DA2148
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
<TITLE>RE=A0: [Xenomai-help] RE :  RE :  Error compiling Xenomai 2.4.8 =
with I-pipe tracer</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
&gt;&gt; I downloaded the toolchain from:<BR>
&gt;&gt; <A =
HREF=3D"http://www.codesourcery.com/sgpp/lite/arm/portal/release316">http=
://www.codesourcery.com/sgpp/lite/arm/portal/release316</A><BR>
&gt;&gt;<BR>
&gt;&gt; It's the free version but it's supposed to have a Newlib =
library. Why<BR>
&gt;&gt; can't I<BR>
&gt;&gt; find any *.so? I only have *.a files. Must I only statically =
compile my<BR>
&gt;&gt; software?<BR>
&gt;<BR>
&gt; No. This version is the free-standing version, made to compile =
code<BR>
&gt; without an OS. This is sufficient for compiling the Linux kernel, =
not<BR>
&gt; for compiling any Linux user-space applications. What you =
should<BR>
&gt; download is:<BR>
&gt;<BR>
&gt; <A =
HREF=3D"http://www.codesourcery.com/sgpp/lite/arm/portal/release313">http=
://www.codesourcery.com/sgpp/lite/arm/portal/release313</A><BR>
<BR>
Thank you for the link. I'll try this.<BR>
<BR>
NOTE: for anyone who's interested<BR>
I applied the patch found in:<BR>
<A =
HREF=3D"http://marc.info/?l=3Dlinux-arm-kernel&m=3D124946219616111&w=3D2"=
>http://marc.info/?l=3Dlinux-arm-kernel&m=3D124946219616111&w=3D2</A><BR>=

<BR>
And try to compile the kernel with the 2008q1 toolchain but it fails =
with:<BR>
[...]<BR>
&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tmp_vmlinux1<BR>
init/built-in.o: In function `do_one_initcall':<BR>
calibrate.c:(.text+0x14): undefined reference to `__gnu_mcount_nc'<BR>
init/built-in.o: In function `run_init_process':<BR>
calibrate.c:(.text+0x1b0): undefined reference to `__gnu_mcount_nc'<BR>
init/built-in.o: In function `init_post':<BR>
calibrate.c:(.text+0x1e0): undefined reference to `__gnu_mcount_nc'<BR>
init/built-in.o: In function `name_to_dev_t':<BR>
calibrate.c:(.text+0x2e0): undefined reference to `__gnu_mcount_nc'<BR>
init/built-in.o: In function `rest_init':<BR>
calibrate.c:(.ref.text+0x10): undefined reference to =
`__gnu_mcount_nc'<BR>
init/built-in.o:calibrate.c:(.cpuinit.text+0x10): more undefined =
references to `__gnu_mcount_nc' follow<BR>
make[3]: *** [.tmp_vmlinux1] Erreur 1<BR>
make[2]: *** [sub-make] Erreur 2<BR>
make[1]: *** [zImage] Erreur 2<BR>
make: *** [sub-make] Erreur 2<BR>
<BR>
Even if the patch permits the export of both symbols.<BR>
<BR>
<BR>
Thank you for help,<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
| BERRUER S=E9bastien<BR>
| Trainee at Altran Ouest<BR>
| Centre d'Affaires Alphasis<BR>
| 35760 Saint-Gr=E9goire - FRANCE<BR>
| Tel: 06-76-35-29-55<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA2A30.C8DA2148--

