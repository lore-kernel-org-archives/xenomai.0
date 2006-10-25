Message-ID: <453FCA64.9090402@domain.hid>
Date: Wed, 25 Oct 2006 22:34:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM/ALSA hybrid driver ?
References: <200610251610.36530.witzel.thomas@domain.hid>
In-Reply-To: <200610251610.36530.witzel.thomas@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCFDEB6918BEFFAA7E16281AF"
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
To: witzel.thomas@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCFDEB6918BEFFAA7E16281AF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Thomas Witzel wrote:
> Hello,
>=20
> I'm now trying to create a sound driver that will start and stop playba=
ck in=20
> real time. Is it better to implement a driver for RTDM from scratch, or=
 is it=20
> reasonable to just add a RTDM interface for the required functionality =
to an=20
> existing ALSA driver ? The advantage of the latter approach is of cours=
e,=20
> that everything that doesn't need to be done in realtime already exists=
=20
> through ALSA and I only would have to implement the pcm triggers throug=
h=20
> RTDM. Is that reasonable at all ?

Yes, this can be reasonable. You will fork the driver effectively, but
you should be able to reuse init/cleanup parts for this. Basically, this
is how most RTnet drivers were developed.

But how hard and how tight are your RT requirements? I'm asking because
I know that a lot of people are using unmodified ALSA drivers over the
PREEMPT_RT kernel for real-time recording, processing, and playback.
Maybe this can already provide you what you need. But I don't know the
internal design of ALSA, if there are any pitfalls hidden like dynamic
buffer management.

Jan


--------------enigCFDEB6918BEFFAA7E16281AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFP8pkniDOoMHTA+kRAlb9AJ4xpq8+Wuedqm/GTsQn2lhZLPvS8wCaAnEK
WapXV6Po11AzczzCiFyD90A=
=GAa0
-----END PGP SIGNATURE-----

--------------enigCFDEB6918BEFFAA7E16281AF--

