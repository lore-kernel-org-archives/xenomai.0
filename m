Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA2165.B8E03590"
Date: Thu, 20 Aug 2009 09:13:31 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A9C2@domain.hid>
References: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
	<4A8C23BE.8050904@domain.hid>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] =?iso-8859-1?q?RE=A0=3A__Native_message_queue_and_?=
	=?iso-8859-1?q?synchronisation?=
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

------_=_NextPart_001_01CA2165.B8E03590
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

>> I include my code and hope you can point me out what I am doing =
wrong.
>> I'm running a kernel 2.6.28 with Xenomai 2.4.8 on an ARM architecture
>> (PXA255).
>
>Could you try Xenomai 2.4.9?



I did it yesterday with the version 2.4.9. But, I still issue the same =
problem with the same code.

I recently pointed out another problem: during the deletion of a task =
descriptor, I receive the error value -3 (-ESRCH). I quickly checked it =
and, that's right, she didn't appear in the /proc/registry.

May it be a registration problem for the queue, too?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien             |
| Trainee at Altran Ouest       |
| Centre d'Affaires Alphasis    |
| 35760 Saint-Gr=E9goire - FRANCE |
| Tel: 06-76-35-29-55           |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D







------_=_NextPart_001_01CA2165.B8E03590
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
<TITLE>RE=A0: [Xenomai-help] Native message queue and =
synchronisation</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
&gt;&gt; I include my code and hope you can point me out what I am doing =
wrong.<BR>
&gt;&gt; I'm running a kernel 2.6.28 with Xenomai 2.4.8 on an ARM =
architecture<BR>
&gt;&gt; (PXA255).<BR>
&gt;<BR>
&gt;Could you try Xenomai 2.4.9?<BR>
<BR>
<BR>
<BR>
I did it yesterday with the version 2.4.9. But, I still issue the same =
problem with the same code.<BR>
<BR>
I recently pointed out another problem: during the deletion of a task =
descriptor, I receive the error value -3 (-ESRCH). I quickly checked it =
and, that's right, she didn't appear in the /proc/registry.<BR>
<BR>
May it be a registration problem for the queue, too?<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
| BERRUER =
S=E9bastien&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |<BR>
| Trainee at Altran Ouest&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<BR>
| Centre d'Affaires Alphasis&nbsp;&nbsp;&nbsp; |<BR>
| 35760 Saint-Gr=E9goire - FRANCE |<BR>
| Tel: =
06-76-35-29-55&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
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
------_=_NextPart_001_01CA2165.B8E03590--

