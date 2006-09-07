Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: AW: [Xenomai-help] resubmission : memset of heap
	crashes	Xenomai-Task
Date: Thu, 7 Sep 2006 12:13:48 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A4E9E80@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org, wg@domain.hid
Cc: xenomai@xenomai.org

Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] :
>=20
> Ok. Now the question remains: does this problem still exist=20
> with version
> 2.2.2 ? The heaps overhead computations have changed recently.
>=20

Good news. I can=B4t reproduce the "seg. fault" with 2.2.2 although I =
tried hard (restarted at least 20 times). Obviously the new "heap =
overhead computations" eliminated the problem.=20
Wolgang could you be so nice to try to reproduce the problem with 2.2.2, =
just to be sure ?

Many thanks to everybody who spend his precious time=20
Roderik

P.s.: with 2.2.2 I noticed, that in /proc/xenomai/interfaces vxWorks is =
not listed although I compiled the kernel with support for vxworks. Is =
this o.K. ?

