Message-ID: <45C06EE9.3020501@domain.hid>
Date: Wed, 31 Jan 2007 11:26:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: Antwort: Re: [Xenomai-core] Questions about pSOS task mode and
	task priority
References: <OF5910DE28.1586BCD6-ONC125726F.005E4D75@domain.hid>		<1169832375.3346.67.camel@domain.hid>
	<45BDF5D8.4020607@domain.hid>		<1170204016.21219.49.camel@domain.hid>
	<45C05975.3060900@domain.hid>	<1170234649.25426.4.camel@domain.hid>
	<45C0615B.5060909@domain.hid>
In-Reply-To: <45C0615B.5060909@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig20526C83BE7934B1DD5D0216"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Markus Osterried <Markus.Osterried@domain.hid>, xenomai@xenomai.org, Thomas Necker <Thomas.Necker@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20526C83BE7934B1DD5D0216
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>>>> In short, the following patch against 2.3.0 stock fixes the issue,
>>>> allowing threads to block while holding the scheduler lock.=20
>>> Ok, but this means that the skins which use XNLOCK with the previous
>>> meaning need fixing.
>>>
>>
>> Only those which really wanted - i.e. by design - to return an error
>> flag (or the board to lockup or panic) in case of a thread going to
>> sleep while holding the schedlock. This change does not affect the
>> schedlock semantics otherwise.
>>
>=20
> I do not understand how it works, I mean, how do you know, in
> xnpod_schedule, if xnpod_schedule was voluntarily called by the current=

> thread, or was called upon reception of an interruption ?

sched->inesting manages the scheduler lock in interrupt context (and
XNLOCK requires Xenomai thread context anyway - something an interrupt
handler cannot expect). So that part is not affected by the XNLOCK change=
s.

Jan


--------------enig20526C83BE7934B1DD5D0216
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwG7pniDOoMHTA+kRAssdAJ9cLCZApUYmo3XT8mfrbg7AJ4jOAACePOIl
P//X0K2iEAEcx53FzZDaIEk=
=QxnA
-----END PGP SIGNATURE-----

--------------enig20526C83BE7934B1DD5D0216--

