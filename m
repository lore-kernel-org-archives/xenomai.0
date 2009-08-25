Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA2593.D7DC3810"
Date: Tue, 25 Aug 2009 16:53:44 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A9C8@domain.hid>
References: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
	<4A8C23BE.8050904@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C2@domain.hid>
	<4A8E628C.8010001@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C4@domain.hid>
	<4A8F1E70.6090608@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C6@domain.hid>
	<4A925F27.4070104@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C7@domain.hid>
	<4A939CE2.3080006@domain.hid>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] =?iso-8859-1?q?RE=A0=3A_RE_=3A__Native_message_que?=
	=?iso-8859-1?q?ue_and_synchronisation?=
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

------_=_NextPart_001_01CA2593.D7DC3810
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

>
>Could you try something: with the patch still applied, could you try to
>compile Xenomai user-space without the -msoft-float option?

I've done the compilation of the kernel support with both previous =
patches applied.


I've done the compilation of the user space support once with =
CFLAGS=3D-msoft-float, and once without.


I've run almost all the applications from the testsuite. However, some =
noticed points;
 - I can't run irqbench. I've got the following error:

root@domain.hid:$ ./irqbench/run=20
*
*
* Type ^C to stop this application.
*
*
irqloop: error starting test: Inappropriate ioctl for device

Must I used the serial RT driver from Xenomai for this test?

 - When I run swithtest without any argument, I receive the message:

root@domain.hid:$ ./switchtest/run=20
*
*
* Type ^C to stop this application.
*
*
=3D=3D Testing FPU check routines...
=3D=3D FPU check routines: unimplemented, skipping FPU switches tests.
=3D=3D Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 =
rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|         900|         900
RTD|         891|        1791
RTD|         909|        2700
RTD|         909|        3609
RTD|         900|        4509
RTD|         909|        5418
RTD|         909|        6327
RTD|         909|        7236
RTD|         900|        8136
RTD|         909|        9045
RTD|         909|        9954

But nothing appear when I explicitly run:

root@domain.hid:$ ./switchtest/run rtup_ufpp
*
*
* Type ^C to stop this application.
*
*
=3D=3D Threads: sleeper_ufps-0 rtup_ufpp-1
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|         200|         200
RTD|         198|         398
RTD|         202|         600
RTD|         202|         802
RTD|         202|        1004
RTD|         202|        1206
RTD|         200|        1406
RTD|         202|        1608
RTD|         200|        1808


Maybe some of this already have a solution. I report the results and try =
to find some ideas on mail archive.

Thanks a lot,

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien
| Trainee at Altran Ouest
| Centre d'Affaires Alphasis
| 35760 Saint-Gr=E9goire - FRANCE
| Tel: 06-76-35-29-55
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D









------_=_NextPart_001_01CA2593.D7DC3810
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
<TITLE>RE=A0: RE : [Xenomai-help] Native message queue and =
synchronisation</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
&gt;<BR>
&gt;Could you try something: with the patch still applied, could you try =
to<BR>
&gt;compile Xenomai user-space without the -msoft-float option?<BR>
<BR>
I've done the compilation of the kernel support with both previous =
patches applied.<BR>
<BR>
<BR>
I've done the compilation of the user space support once with =
CFLAGS=3D-msoft-float, and once without.<BR>
<BR>
<BR>
I've run almost all the applications from the testsuite. However, some =
noticed points;<BR>
&nbsp;- I can't run irqbench. I've got the following error:<BR>
<BR>
root@domain.hid:$ ./irqbench/run<BR>
*<BR>
*<BR>
* Type ^C to stop this application.<BR>
*<BR>
*<BR>
irqloop: error starting test: Inappropriate ioctl for device<BR>
<BR>
Must I used the serial RT driver from Xenomai for this test?<BR>
<BR>
&nbsp;- When I run swithtest without any argument, I receive the =
message:<BR>
<BR>
root@domain.hid:$ ./switchtest/run<BR>
*<BR>
*<BR>
* Type ^C to stop this application.<BR>
*<BR>
*<BR>
=3D=3D Testing FPU check routines...<BR>
=3D=3D FPU check routines: unimplemented, skipping FPU switches =
tests.<BR>
=3D=3D Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 =
rtuo-8<BR>
RTT|&nbsp; 00:00:01<BR>
RTH|ctx switches|-------total<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
900|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 900<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
891|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1791<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
909|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2700<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
909|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3609<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
900|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4509<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
909|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5418<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
909|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6327<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
909|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7236<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
900|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8136<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
909|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9045<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
909|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9954<BR>
<BR>
But nothing appear when I explicitly run:<BR>
<BR>
root@domain.hid:$ ./switchtest/run rtup_ufpp<BR>
*<BR>
*<BR>
* Type ^C to stop this application.<BR>
*<BR>
*<BR>
=3D=3D Threads: sleeper_ufps-0 rtup_ufpp-1<BR>
RTT|&nbsp; 00:00:01<BR>
RTH|ctx switches|-------total<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
200|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 200<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
198|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 398<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
202|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 600<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
202|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 802<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
202|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1004<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
202|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1206<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
200|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1406<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
202|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1608<BR>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
200|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1808<BR>
<BR>
<BR>
Maybe some of this already have a solution. I report the results and try =
to find some ideas on mail archive.<BR>
<BR>
Thanks a lot,<BR>
<BR>
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
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA2593.D7DC3810--

