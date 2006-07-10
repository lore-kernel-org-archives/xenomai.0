Message-ID: <44B1FDBD.4060600@domain.hid>
Date: Mon, 10 Jul 2006 09:11:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
In-Reply-To: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9A22E095D855BED3D7706C11"
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
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A22E095D855BED3D7706C11
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Hi,
>=20
> Xenomai provides synchronize objects like semaphore and mutex and relat=
ed
> APIs, e.g: rt_sem_p(), rt_sem_v().
> I think they can only synchonze between Xenomai tasks (e.g, tasks creat=
ed
> with rt_task_create()).
>=20
> Is there any way to synchonize between a "normal" Linux task and a Xeno=
mai
> task?

Either by simply calling a standard sync-mechanism from the RT task so
that it switches over to secondary mode, or by mapping the Linux task to
a Xenomai task as well. The latter is simple too, and you can even leave
its Linux scheduling policy at SCHED_OTHER with latest Xenomai (upcoming
2.2).

> Is there way to synchronize between Linux and Xenomai domain in Kernel
> space? (e.g, a Linux driver and a Xenomai driver)?

Depends on what you have to protect. The easiest way for short code
passages are still spinlocks with hard IRQ protection (under RTDM:
rtdm_lock_xxx). If it's a more complex scenario, please describe it.
There are several patterns available that may fit. They reach from
polling in the non-RT context over virtual IRQs to Linux
(rtdm_nrtsig_xxx) up to RT helper tasks.

Jan


--------------enig9A22E095D855BED3D7706C11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEsf3AniDOoMHTA+kRArzEAJ9xPxJI0MqPW0nreqXwkD2rgFEYowCeKw7U
8vrDzSbnjot/liwY7XOqfnY=
=XPNr
-----END PGP SIGNATURE-----

--------------enig9A22E095D855BED3D7706C11--

