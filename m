Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2009 10:42:26 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01D8F93D@ARVMAIL1.mra.roland-man.biz>
From: <roderik.wildenburg@domain.hid>
Subject: [Xenomai-help] network stall
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

On one of our platforms (PPC 5200B Kernel 2.4, Xenomai 2.4.8, PCI-bus) =
we face rare network stalls (once a day).
In this situation network communication seems to be completly dead, but =
obviously only the receive direction is affected as receive-interrupts =
in /proc/interrupts aren=B4t incremented while transmit interrupts are =
incremented.
Wireshark-protocoll (taken via port mirroring of the switch) says that =
packets are sent to the target, but tcpdump on the target does not show =
these packets (which is obvious, if receive-interrupt isn=B4t =
operational).
In the send direction only arp-requests are monitored (on the target and =
on the switch).
Unfortunatelly this situation can=B4t be reproduced in an laboratory =
environment

On our other platform, which is very similar (PPC 5200B Kernel 2.4, =
Xenomai 2.4.8) but without PCI we don=B4t have this problem. Therefore I =
am thinking whether Ipipe (in combination with PCI) could be responsible =
for the interrupt lock?

Does anybody have an idea/suggestion how we can track down the reason =
for interrupt blockade?
Are there some helpful /proc entries (/proc/ipipe wasn=B4t very useful =
for me)?
Unfortunatelly, as far as I know, Ipipe-tacer is only available for =
Kernel 2.6. Am I right?


I would appreciate any suggestion very much!

Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

