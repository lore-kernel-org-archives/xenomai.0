Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2009 10:37:55 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01A87EA5@domain.hid>
In-Reply-To: <1245248375.9280.3.camel@domain.hid>
From: <roderik.wildenburg@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi,

>=20
> The EXPORT directives were wrong, actually copied&pasted as=20
> is from 2.6.
> Try this patch instead:
>=20
> http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4
.25-ppc-DENX-2.0-01.patch
>=20
>=20

Great! This patch applies and compiles fine and solves my "stall" =
problem.
Thanks a lot !!

Best regards
Roderik


(Just as a hint for all those, whose kernel isn=B4t Head of the 2.4.25 =
Denx git-repository:
The new adeos-patch tries to patch a file named .gitignore. If this does =
not exist, xenomai prepare-kernel fails.=20
I simply deleted the hunk concerning .gitignore which is, at least from =
my point of view, sustainable, as this file isn=B4t needed for =
compilation.)

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

