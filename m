Date: Sat, 9 Sep 2006 13:01:02 +0200
From: Bernhard Walle <bernhard.walle@domain.hid>
Subject: Re: [Xenomai-core] tdm_event_timedwait documentation
Message-ID: <20060909110102.GB4567@domain.hid>
References: <20060909011533.GE1192@domain.hid> <45029746.9060302@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <45029746.9060302@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Jan Kiszka <jan.kiszka@domain.hid> [2006-09-09 12:28]:
>=20
> This overwriting only takes place if timeout_seq is non-NULL. Otherwise,
> we are in "usual" timeout mode.

Yes, of course, you're right. It was too late when I wrote this mail.
I oversaw the NULL case.

> > Maybe
> >=20
> >  * @param[in] timeout Relative timeout, see
> >  * @ref RTDM_TIMEOUT_xxx for special values (any positive value
> >  * means the timeout specified in the timeout sequence)
> >=20
> > or something like that.
>=20
> No, that's wrong then. I guess we rather need something like this:
>=20
> "@param[in] timeout Relative timeout in nanoseconds, see @ref
> RTDM_TIMEOUT_xxx for special values; pass the overall timeout of the
> related series if timeout_seq is non-NULL"
>=20
> Does this help to clarify the situation? BTW, the same applies to
> rtdm_sem_timeddown and rtdm_mutex_timeddown, all of those could be
> combined in such a series.

Yes, that would make it clear.

> RTDM specification and development only take place over Xenomai, RTAI
> later adopts what we implement here. And this will quite likely remain
> so in the future. Therefore, the best place to discuss also abstract
> RTDM question is here, maybe later on a dedicated xenomai-drivers list
> when the traffic increases.
>=20
> For oddities of the RTAI implementation there is still the RTAI list
> where I'm subscribed as well and can jump in when required.

Ah, ok. Didn't know that you're subscribed, that's why I CC'd you.


Regards,
  Bernhard
--=20
OpenPGP Schl=FCssel-ID: B69454FD (kurz) / E8951E8FB69454FD (lang)
Fingerprint: F3BE B2A7 8161 2986 ABA4  9AB9 E895 1E8F B694 54FD

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBRQKe6uiVHo+2lFT9AQIW4QQAiaujThaZD2HC/rEeKQvp1M1UAJoBODQ5
g85RufIIvIzWSmKFfSx8MH/UfkEbJ8W0UZHE70LqgjIu0gfGPnLGTz4IBvQ98xr+
fehuWlllGIAeZtOUBZazdRUtmKuysG+JaHVxvdnbhexeGuI9ZPE9BVRLehLA1pnx
DlIWIUmRrNw=
=HQVt
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

