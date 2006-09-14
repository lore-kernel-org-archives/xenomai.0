Message-ID: <450931B9.1040703@domain.hid>
Date: Thu, 14 Sep 2006 12:40:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] driver migration
References: <9D98C51005D80D43A19A3DF329A61D69515626@domain.hid>
In-Reply-To: <9D98C51005D80D43A19A3DF329A61D69515626@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDD00D19FA3C0967EBC9309A5"
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
To: Nilanjan Roychowdhury <Nilanjan.Roychowdhury@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDD00D19FA3C0967EBC9309A5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nilanjan Roychowdhury wrote:
> Jan,
> I have a question on RTDM. Lets say I have chosen Xenomai as the FIRST
> platform to develop my driver with a plan to move my driver to an RTOS
> in future. And lets say this RTOS does not have an IO system. Does not
> understand any /dev/XXX entry.

Neither had original Xenomai or RTAI in hard-RT mode. To define such
basic I/O system, RTDM was invented. It can (and does under those two
systems) provide a simple self-contained hard-RT I/O subsystem to build
drivers upon, but it would also work on systems where this is already
available (PREEMPT_RT will likely be such a candidate).

> In that RTOS you have tasks waiting for
> events and you post the events from an ISR ( lets say by a message
> queue).
>=20
> In that case, do you suggest I go for RTDM. Or I just try to mimic the
> same RTOS behavior by RT interrupts and rt tasks ??

It's hard to say without knowing that RTOS, likely also its degree of
extensibility. But I could imagine that porting RTDM (or the parts you
actually use) over your RTOS would simplify your life when having to
maintain drivers for both systems. RTDM first of all defines abstract
RTOS services for drivers and a communication interface between drivers
and applications, both should be mappable on other systems as well.
Again, that's speculation, the devil can always be in the detail.

Jan



--------------enigDD00D19FA3C0967EBC9309A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFCTG5niDOoMHTA+kRAmYOAJ4vYEifvSg4tIzPkI1MGKC1qnkPogCeO+QQ
nvSstO6MCPBgB3kvatPHrQ4=
=yomF
-----END PGP SIGNATURE-----

--------------enigDD00D19FA3C0967EBC9309A5--

