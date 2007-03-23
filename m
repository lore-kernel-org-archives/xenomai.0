Message-ID: <4603E999.8090206@domain.hid>
Date: Fri, 23 Mar 2007 15:52:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
References: <032320071430.15600.4603E49C000EB7BC00003CF02216557996070E0301020A98@domain.hid>
In-Reply-To: <032320071430.15600.4603E49C000EB7BC00003CF02216557996070E0301020A98@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16F58580FAFD9132A7F00B04"
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
To: xenomai@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16F58580FAFD9132A7F00B04
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[Please don't top-post, cite only what you comment on.]

xenomai@domain.hid wrote:
> I disabled CONFIG_ACPI_AC and I got the same hang with ACPI_BATTERY. I =
am using 2.31.  Any other suggestions?  I will remove all that hang
but I feer that that is not the right way to go.

Regarding "nothing gets scheduled on" CPU #2: Do you mean no Linux job
or no Xenomai task? The bug that was (/should be) fixed in 2.3.1 was
concerning Linux, Xenomai requires explicit scheduling.

But you are right, something is fishy here. I never heard of hanging
modules like that before.

Jan


--------------enig16F58580FAFD9132A7F00B04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGA+mZniDOoMHTA+kRApGMAJ4n4gpvw2071EA4U9VOZxzYIkNbuwCfY8KQ
vCujG27aMbAtMrf+7jBlZPk=
=QnFX
-----END PGP SIGNATURE-----

--------------enig16F58580FAFD9132A7F00B04--

