From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01D8F93D@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A01D8F93D@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Nov 2009 14:37:25 +0100
Message-ID: <1258551445.2348.148.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] network stall
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2009-11-17 at 10:42 +0100, roderik.wildenburg@domain.hid
wrote:
> On one of our platforms (PPC 5200B Kernel 2.4, Xenomai 2.4.8, PCI-bus) =
we face rare network stalls (once a day).
> In this situation network communication seems to be completly dead, but=
 obviously only the receive direction is affected as receive-interrupts i=
n /proc/interrupts aren=C2=B4t incremented while transmit interrupts are =
incremented.
> Wireshark-protocoll (taken via port mirroring of the switch) says that =
packets are sent to the target, but tcpdump on the target does not show t=
hese packets (which is obvious, if receive-interrupt isn=C2=B4t operation=
al).
> In the send direction only arp-requests are monitored (on the target an=
d on the switch).
> Unfortunatelly this situation can=C2=B4t be reproduced in an laboratory=
 environment
>=20
> On our other platform, which is very similar (PPC 5200B Kernel 2.4, Xen=
omai 2.4.8) but without PCI we don=C2=B4t have this problem. Therefore I =
am thinking whether Ipipe (in combination with PCI) could be responsible =
for the interrupt lock?
>=20
> Does anybody have an idea/suggestion how we can track down the reason f=
or interrupt blockade?
> Are there some helpful /proc entries (/proc/ipipe wasn=C2=B4t very usef=
ul for me)?
> Unfortunatelly, as far as I know, Ipipe-tacer is only available for Ker=
nel 2.6. Am I right?

Yes.

>=20
>=20
> I would appreciate any suggestion very much!
>=20

Make sure to disable CONFIG_XENO_OPT_ISHIELD. This option was reported
to introduce interrupt propagation issues at least once, certainly adds
some overhead, and won't buy you anything with your configuration. It
has been removed from 2.5.

> Roderik
>=20
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Ral=
l, Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.



