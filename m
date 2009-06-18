From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01A87EA5@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A01A87EA5@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Jun 2009 10:51:29 +0200
Message-Id: <1245315089.3951.1.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
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

On Thu, 2009-06-18 at 10:37 +0200, roderik.wildenburg@domain.hid
wrote:
> Hi,
>=20
> >=20
> > The EXPORT directives were wrong, actually copied&pasted as=20
> > is from 2.6.
> > Try this patch instead:
> >=20
> > http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4
> .25-ppc-DENX-2.0-01.patch
> >=20
> >=20
>=20
> Great! This patch applies and compiles fine and solves my "stall" probl=
em.
> Thanks a lot !!
>=20
> Best regards
> Roderik
>=20
>=20
> (Just as a hint for all those, whose kernel isn=C2=B4t Head of the 2.4.=
25 Denx git-repository:
> The new adeos-patch tries to patch a file named .gitignore. If this doe=
s not exist, xenomai prepare-kernel fails.=20
> I simply deleted the hunk concerning .gitignore which is, at least from=
 my point of view, sustainable, as this file isn=C2=B4t needed for compil=
ation.)
>=20

This extraneous hunk has just been removed from the patch in the dl and
Xenomai repo. Thanks.

> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Ral=
l, Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
--=20
Philippe.



