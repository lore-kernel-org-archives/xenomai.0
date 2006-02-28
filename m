Message-ID: <440473CA.6000205@domain.hid>
Date: Tue, 28 Feb 2006 17:01:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
References: <C029B04C.2587%steve@domain.hid>
In-Reply-To: <C029B04C.2587%steve@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4FF5CED441EEB8D7355ADE66"
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4FF5CED441EEB8D7355ADE66
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> Well, the thread suspends when it's done playing, and when new data arr=
ives
> in the buffer via /dev/dsp, the thread is then resumed. I just wonder w=
hat
> the point of suspend/resume is, then, if we're supposed to just use
> rt_task_set_periodic to create a new timeline. Right now I am doing thi=
s,
> and then suspending, and then before I resume, I make another timeline.=

>=20

Well, and this is racy in case the resume - for what reason ever - takes
place before the suspend. It will get lost then, and your player will
miss a job. One should better model this via an event (don't count
multiple wakeups) or a semaphore (each wakeup counts and is paired with
a wait in the player task).

Jan


--------------enig4FF5CED441EEB8D7355ADE66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBHPKniDOoMHTA+kRAp2/AJ4hYdJDiZzqSyv4vLuD4w2aMrXGZgCeLzhV
U2BxIderPipovKPiH6oHoE4=
=Zcc4
-----END PGP SIGNATURE-----

--------------enig4FF5CED441EEB8D7355ADE66--

