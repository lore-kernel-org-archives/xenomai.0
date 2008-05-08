Message-ID: <4823620F.3020904@domain.hid>
Date: Thu, 08 May 2008 22:26:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA892BC66996FB6D3ECDFC6D1"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [BUG] ipipe_sync_stage deadlock
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA892BC66996FB6D3ECDFC6D1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I love KVM - not only because I'm heavily hacking on it now, also
because it is so easy to trigger various kinds of guest issues with
it (SMP host + threaded virtual CPUs =3D> true SMP guest - and if you
want to watch fancy things happen, just load one host core).

Here is one I found that way:

void fastcall __ipipe_sync_stage(unsigned long syncmask)
{
[ ... ]
	while ((mask =3D (ipipe_this_cpudom_var(irqpend_himask) & syncmask)) !=3D=
 0) {
		level =3D __ipipe_ffnz(mask);

		while ((submask =3D ipipe_this_cpudom_var(irqpend_lomask)[level]) !=3D =
0) {
			rank =3D __ipipe_ffnz(submask);
			irq =3D (level << IPIPE_IRQ_ISHIFT) + rank;

			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
				__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);
				continue;
			}

			__clear_bit(rank, &ipipe_this_cpudom_var(irqpend_lomask)[level]);

			if (ipipe_this_cpudom_var(irqpend_lomask)[level] =3D=3D 0)
				__clear_bit(level, &ipipe_this_cpudom_var(irqpend_himask));
[ ... ]

Who sees the deadlock? 100 points for the right answer! But be quick,
I'm already hacking on a fix. :)

Jan


--------------enigA892BC66996FB6D3ECDFC6D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFII2ITniDOoMHTA+kRAtEVAJsHulRAlHtitxGA2lZNfYAoMd5NRwCcCLOA
/DuW9joU5VnTNrhjLZ+0VVs=
=0ieW
-----END PGP SIGNATURE-----

--------------enigA892BC66996FB6D3ECDFC6D1--

