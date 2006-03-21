Message-ID: <44204374.8010808@domain.hid>
Date: Tue, 21 Mar 2006 19:18:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up - SOLVED
References: 00603201434.15258@domain.hid>
	<200603201434.15258@domain.hid>	<441ED657.1080405@domain.hid>
	<200603201901.3123@domain.hid>	<441F3476.1080003@domain.hid>
	<200603211503.22918@domain.hid> <442018FE.3020906@domain.hid>
	<442029CF.8030709@domain.hid> <44203051.4080400@domain.hid>
	<4420391B.7000309@domain.hid>
In-Reply-To: <4420391B.7000309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7FD5806D6DA2BA63CBF6855F"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7FD5806D6DA2BA63CBF6855F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> ...
> I'm worried by the fact that mode switching needs to be exposed to the
> application layer in this case. Actually, it has always been seen as an=

> internal request, but never as part of the recommended API, because one=

> might just do utterly wrong things with this syscall (useless eager
> switch when none is due etc). My worst nightmare waking me up in cold
> sweat is seeing Xenomai-based applications litterally stuffed with
> rt_task_set_mode(...T_PRIMARY...) calls, breaking the lazy switch schem=
e
> without any upside, but additional latencies. Actually, a lot of work
> has been done to make those mode switches as transparent/invisible as
> possible. My fear is that people having problems with their application=

> would start adding mode switches everywhere "just in case", without
> really understanding the logic behind it. Gah...! cold sweat again...
>=20
> The other issue which bothers me is that applications would need to kno=
w
> the actual implementation of the syscall to pick the right mode, i.e.
> whether rtdm_socket wants to get memory from the Linux pool, or from a
> predefined local pool, and so on. Sounds ok for a low-level library
> which must know about RTDM's internals, but might be error-prone for
> writing regular apps.

That's no RTDM issue, that's up to the driver. And this is also the
place where to document the special feature of selecting the determinism
of service per device. But I'm open to a discussion on this (you may
remember my opinion on non-legacy RT-application design and mode
switching... ;) ), I just have my concerns if this thread is the right
place anymore.

Jan


--------------enig7FD5806D6DA2BA63CBF6855F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIEN0niDOoMHTA+kRAlNCAJ0fRNAbpYRab6J2sUnezr3jvsxOlgCbB5Dn
gkqZdc6HyvqHPdX5P+P6DWE=
=QtWd
-----END PGP SIGNATURE-----

--------------enig7FD5806D6DA2BA63CBF6855F--

