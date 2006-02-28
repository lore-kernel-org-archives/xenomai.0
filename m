Message-ID: <44046F8E.9010309@domain.hid>
Date: Tue, 28 Feb 2006 16:43:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
References: <C029AC72.257D%steve@domain.hid>
In-Reply-To: <C029AC72.257D%steve@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF54421237EB4F091DED6FF41"
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
--------------enigF54421237EB4F091DED6FF41
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> How is this an unusual design?
>=20
> I have a sound driver in my system that updates a DAC every 125 us. Sho=
uld I
> not suspend the thread after it's done playing? What should the thread =
do,
> call rt_task_wait_period() every 125us, and contribute to unnecessary
> overhead?=20

Simply stop the related timer when the job is done
(rt_task_setperiodic...). What should be the reason to keep *this*
particular timeline for the next output job? Does the DAC has its own
timer? Then you would have to synchronise on that one anyway. Otherwise,
you should better restart the periodic output as soon as the next job
arrives - with a new timeline. And it might be cleaner to use a real
synchronisation mechanism for the wakeup, something like an event or a
semaphore (suspend/resume is evil - mostly).

Jan



--------------enigF54421237EB4F091DED6FF41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBG+OniDOoMHTA+kRAuy7AJ4szb5I/hAhPruHPCM7rBCbzfDfegCdFqgK
tIeMMI35KWYd6FwRaReQNsA=
=xc7W
-----END PGP SIGNATURE-----

--------------enigF54421237EB4F091DED6FF41--

