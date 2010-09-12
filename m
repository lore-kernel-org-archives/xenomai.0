Message-ID: <4C8CDA1D.3070703@domain.hid>
Date: Sun, 12 Sep 2010 15:48:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7301cc886b22b37fcbc8cda61c515d07.squirrel@domain.hid>
	<4C8C9525.1060101@domain.hid>
	<aab9b54738103bc69a5b95bab1eb1627.squirrel@domain.hid>
In-Reply-To: <aab9b54738103bc69a5b95bab1eb1627.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig54D6AD0251F08DF2C700F39C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Bottom half task scheduling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: tstratman@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig54D6AD0251F08DF2C700F39C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 12.09.2010 15:42, Travis Stratman wrote:
>=20
>> Simply create the RTDM task(s) in advance. Creating tasks on demand an=
d
>> in IRQ context would be crazy.
>=20
> This is what I have confusion about. After creating a non-cyclic task w=
ith rtdm_task_init(), how
> do I restart the task in the interrupt handler? Is there a way to do th=
is using
> rtdm_task_set_period() or some other task function or do I need to have=
 the task wait on an event
> and wake it back up by signaling the event from the ISR?

The latter is the pattern you are looking for. Just loop over
rtdm_event_event and the work it has to perform on wakeup.

Jan


--------------enig54D6AD0251F08DF2C700F39C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkyM2iEACgkQitSsb3rl5xRKLgCdHPu07g3eRvZhDdA1ZqtDG90e
4MsAnAzyTlVED0epsiBNUqZ07pMzf0vP
=am/O
-----END PGP SIGNATURE-----

--------------enig54D6AD0251F08DF2C700F39C--

