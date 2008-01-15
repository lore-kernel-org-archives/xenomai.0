Message-ID: <478D31B8.4000307@domain.hid>
Date: Tue, 15 Jan 2008 23:20:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <db67beef0801151413sc078e51k1e14f76b3cdf6319@domain.hid>
In-Reply-To: <db67beef0801151413sc078e51k1e14f76b3cdf6319@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C62F0226D9BD11CE72E5616"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtpipe problem not solved by 2.4.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: bite <anonimo.passante@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C62F0226D9BD11CE72E5616
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

bite wrote:
> Hi,
>=20
> working with 2.3.4 I have an occasional problem with rtpipe.
>=20
> Writing several integers from the rt side with rt_pipe_write (..., P_NO=
RMAL)
> sometimes it happens that only the first integer can be read from non-r=
t.
>=20
> The problem seems to be triggered by (moderately) heavy socket traffic,=
 not
> clear why.
>=20
> Reading from the 2.4.1 log: "Close SMP race window in message pipe's
> read-side", I decided to give it a try even if I'm not working with SMP=
, but
> my problem persists.
>=20
> It is not urgent for me, I found my way out by polling ring buffers ins=
tead
> of using rtps, but I think it is worth raising the suspect that there _=
is_
> even a non-SMP race condition.

Do you have a simple test case that can trigger the issue? That would=20
help a lot to nail the problem down.

Jan


--------------enig6C62F0226D9BD11CE72E5616
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHjTG4niDOoMHTA+kRAjjOAJ4mw2laIL41viIY1J7MyphlJ4uyGACfc//J
At6qTKfvQ/hdfQ5GtCni950=
=YFbx
-----END PGP SIGNATURE-----

--------------enig6C62F0226D9BD11CE72E5616--

