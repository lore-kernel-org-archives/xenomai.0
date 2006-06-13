Message-ID: <448EF56D.1030101@domain.hid>
Date: Tue, 13 Jun 2006 19:27:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Interrupt handler assistance
References: <1150219056.10703.1.camel@domain.hid>
In-Reply-To: <1150219056.10703.1.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAD9B34F015C8BA6FA34129D9"
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
To: Marcelo Coelho <mjcoelho@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD9B34F015C8BA6FA34129D9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marcelo Coelho wrote:
> Hi!
>=20
> I'm porting a driver to RTAI, using RTDM. The original driver uses
> Workqueues to process the data received by the interrupt handler. What
> method does RTDM in a this situation?
>=20

RTDM doesn't provide an explicit queuing API, you may design a specific
one for your scenario (or keep the original one if it was not
RTAI-specific). What RTDM offers is locking (rtdm_lock_xxx) and
signalling (rtdm_event_xxx or rtdm_sem_xxx).

Patterns can be found e.g. in the serial driver (ring buffer with
rtdm_event) or in RTnet (packet queue with rtdm_event or rtdm_sem).

Jan


--------------enigAD9B34F015C8BA6FA34129D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjvVtniDOoMHTA+kRAglVAJ9d9ic5HVOzWcBm1jgUpmjomdz8/QCdFO/q
utWp2JnxFFsYDfei+I1L1ZM=
=ztjZ
-----END PGP SIGNATURE-----

--------------enigAD9B34F015C8BA6FA34129D9--

