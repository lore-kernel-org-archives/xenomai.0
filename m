Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] resubmission : memset of heap crashes Xenomai-Task
Date: Wed, 6 Sep 2006 14:56:47 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A4E9D0A@ARVMAIL1.mra.roland-man.biz>
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
To: danielsch@domain.hid, xenomai@xenomai.org

> Daniel Schnell [mailto:danielsch@domain.hid] wrote :

> Hi,
>=20
> I have tried your program on my mpc5200 (Kernel 2.4.25,=20
> Xenomai 2.2.1, 256 MB RAM). Besides it doesn't do much and=20
> also the heap allocation seems not to work, I had no crashes.
>=20

Thank you for testing Daniel !
The idea was, to test Xenomai with very low memory available (especially =
network performance tests). Therefore I implemented a algorithm (I =
admit, not a very sophisticated one), which allocates nearly all memory =
available. To make sure, that memory is not available for Xenomai, the =
kernel or other applications,I touche the allocated memory (memset). So, =
the program realy does not do very much, beside allocating and touching =
as much memory as possible. Unfortunatelly this crashes the programm =
(segmentation fault) without doing any "illegal".
What do you mean with "the heap allocation seems not to work" ? Is this =
a Xenomai  or a program malfunction ?
Perhaps your test didn=B4t crash as this allocation does not work ?
With my target it takes a while (approx 1min.) till the programm =
crashes. Did you wait a while ?
Perhaps the problem is already solved in 2.2.1.

Thank you for your support
Roderik


