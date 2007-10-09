Message-ID: <470BDE45.80700@domain.hid>
Date: Tue, 09 Oct 2007 22:02:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>	<470BC537.8010200@domain.hid>	<305035a40710091207j4038c62s5fb81903ce843910@domain.hid>
	<305035a40710091207l185a8fcm8baf715e0a0ef2b3@domain.hid>
In-Reply-To: <305035a40710091207l185a8fcm8baf715e0a0ef2b3@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE2A120C5510941B5459EFB7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Fwd: RTAI and Xenomai latency in kernel mode on
 AT91SAM9261-EK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gregory CLEMENT <gclement00@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE2A120C5510941B5459EFB7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gregory CLEMENT wrote:
>>> first Xenomai:
>>>
>>> #insmod /lib/modules/2.6.20.13/kernel/drivers/xenomai/testing/xeno_ti=
merbench.ko
>>> #cd /usr/xenomai/bin/
>> Which versions were you using for both tests? Do you still have the
>> involved .configs?
>=20
> Both version are 2.6.20.13
> I join the config files.

BTW, the attached Xenomai config is obviously not the one that was used
for the test:

#
# Testing drivers
#
# CONFIG_XENO_DRIVERS_TIMERBENCH is not set

Jan


--------------enigAE2A120C5510941B5459EFB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHC95IniDOoMHTA+kRAksMAJ9Z6ofmMSuKlKWkSoeqKtZl1RgpPACaA5b4
ql1AhhocOJvWIYKddI0vqxM=
=YfCf
-----END PGP SIGNATURE-----

--------------enigAE2A120C5510941B5459EFB7--

