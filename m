Message-ID: <47B0B1E0.7030701@domain.hid>
Date: Mon, 11 Feb 2008 21:36:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
	<47B0ADE8.5060504@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376B02@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376B02@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD94CC941BB975B7A8519719F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] irq0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD94CC941BB975B7A8519719F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> Jan, have patience my friend. I will be reporting bugs regarding LTT
> tonight. ;) I have a day job that unfortunately requires my expertise. =


You have many fires to fight, I understand. :)

> I have local APIC disabled in the kernel because we don't seem to have
> one. I see context switches like these whether or not I use idle=3Dpoll=
,
> and thus the TSC.
>=20
> Here's my /proc/xenomai/timer:
>=20
> status=3Don+watchdog:setup=3D3:clock=3D40035659193:timerdev=3Dpit:clock=
dev=3Dtsc
>=20
> It seems that idle=3Dpoll didn't prevent the tsc from being marked as
> unstable despite what the mailing lists say.

But Xenomai picks it independent of Linux' decision as its clockdev - so =

their might be glitches between the time bases of pit and tsc. You=20
should try to build your kernel with CONFIG_M586. That will make Xenomai =

pick the PIT for time keeping too.

If TSC is truly broken on your box, you cannot gain anything with=20
keeping it for Xenomai.

Jan


--------------enigD94CC941BB975B7A8519719F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHsLHgniDOoMHTA+kRAoAYAJ9l4IAtyVZojMWUNEhf4n41HvyoLACffeHr
EWla9teQWRa5zgs0cbmKSkM=
=6rz/
-----END PGP SIGNATURE-----

--------------enigD94CC941BB975B7A8519719F--

