Message-ID: <441F3BE9.5010409@domain.hid>
Date: Tue, 21 Mar 2006 00:34:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] CONFIG_XENO_OPT_DEBUG_LEVEL
References: <441EFB6D.8000507@domain.hid> <441F1675.1010703@domain.hid>
In-Reply-To: <441F1675.1010703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig77DFED08F4B4DD34AE4CB063"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77DFED08F4B4DD34AE4CB063
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> as I started to actually use XENO_ASSERT, I noticed that there is no
>> infrastructure yet to enable it. CONFIG_XENO_OPT_DEBUG_LEVEL is nowher=
e
>> defined. Add this as integer to Kconfig? Or better convert
>> nucleus/assert.h to CONFIG_OPT_DEBUG for now until we really feel like=

>> we need more than on/off for this? I would vote for the latter ATM.
>=20
> Actually, we already need more than a simple switch: I'd really like th=
e
> queue debugging option to become a level on its own (say, 4294967295?).=

> I'll add this tomorrow.

Hmm, raises my old concern again: this "vertical" debugging implies to
switch everything on when you only want queue debugging. I still think
we rather need "horizontal" control: switch on queues, asserts, ...

This level "4294967295" indicates for me where we may end with: dozens
of debug levels no one can tell apart, and you have to switch them all
on to gain the relevant pieces or to be sure that you didn't missed
anything. I always have the mess in mind we once had in ndiswrapper: for
serious debugging of the USB layer you had to raise the debug level
which dragged in bulks of (in this case) useless reports from other
subsystems.

A student (Marc Kleine-Budde) once ported some nice debug subsystem into
an internal project that requested a subsystem ID for every debug
statement (I think it came from kaffe). At compilation time or even
later during runtime you could easily select which subsystem should
start babbling and checking and which one is not that interesting for a
specific test. I think this is far more useful than debug levels. Queues
could become such a subsystem, RTDM (with its asserts) another, and so
forth. Of course, this means maintaining those subsystem IDs at a
central place, but it's clearer than deciding which level to pick for a
new debug code.

Jan


--------------enig77DFED08F4B4DD34AE4CB063
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHzvpniDOoMHTA+kRAkEfAJ44N3qlf4A+VrM9T+OKk8XDMn72XwCfcjdf
dd48k5QWGxbXlDkU+85RwRA=
=CO2/
-----END PGP SIGNATURE-----

--------------enig77DFED08F4B4DD34AE4CB063--

