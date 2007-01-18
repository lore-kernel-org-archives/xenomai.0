Message-ID: <45AF5E27.9040600@domain.hid>
Date: Thu, 18 Jan 2007 12:46:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Compiling Linux+Xenomai 32bits kernel
	on	FC6	x86_64?
References: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>
	<45AE3ED4.7040506@domain.hid> <45AE68CF.5080200@domain.hid>
	<200701181118.27226.paul_c@domain.hid>
In-Reply-To: <200701181118.27226.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3B31C22954A180FFDE1EF51A"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B31C22954A180FFDE1EF51A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> Hi Jan
>=20
> On Wednesday 17 January 2007 18:19, Jan Kiszka wrote:
>>>> But the best is a Xenomai which supports 64-bit AMD processors :)
>=20
> I've made a tentative stab at a couple of the kernel sources, but must =
admit=20
> the assembly code scares the heck out of me....

I think the assembly part should be a smaller issue, certainly a
solvable one. You are invited to post your questions regarding this here
(or better on xenomai-core) so that we all can try to look at it. /me
has no x86-64 assembly experience yet, but I think to remember that it's
very similar to well-know i386.

The bigger issue with such ports are the testing/debugging cycles which
can cost quite some time if you are unlucky (or blind, or both ;)).

>=20
>> [Really, it depends on someone feeling enough need to work on this (or=

>> sponsor the work). A few pieces are already there from previous RTAI
>> efforts towards x86-64 support. But now it takes a clean implementatio=
n
>> over recent Linux/I-pipe/Xenomai.]
>=20
> How much value is the 2.6.10 x86_64 patch from RTAI when it comes to wo=
rking=20
> on an I-pipe port for 2.6.19 ?

I would consider it as an inspiration for certain detail problems, also
regarding the assembly stuff. But the overall design is of no use
because it's old-style Adeos and likely has RTAI hacks included.

>=20
> (I may well have an AMD64 socket 939 processor available for loan next =
week if=20
> that would help).

Thanks, but for me this wouldn't change the situation.

Jan


--------------enig3B31C22954A180FFDE1EF51A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFr14nniDOoMHTA+kRAmZWAJsGo9pDEni+GFgEvWC3MSPO4t9NHgCZAXOy
GrtWFxeaMGOJGNr3wUFQabs=
=Ac0G
-----END PGP SIGNATURE-----

--------------enig3B31C22954A180FFDE1EF51A--

