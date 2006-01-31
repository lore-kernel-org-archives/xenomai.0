Message-ID: <43DFB5F9.50406@domain.hid>
Date: Tue, 31 Jan 2006 20:09:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Shared irqs v.6
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>
In-Reply-To: <b647ffbd0601311053s2f9f77c3m@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC21863D10A849517E6293C98"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC21863D10A849517E6293C98
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hi,
>=20
> the previous version contained an ugly bug, namely the misuse of the
> test_and_set/clear_bit interface
> that led to a broken system from time to time.
>=20

What about the ISA/edge-triggered stuff? :D

My problem is that we cannot test here on real hardware because all our
shared IRQs reside on PC104 cards.

Jan


PS: I guess this one does not add much functionality: ;)

@@ -181,8 +235,7 @@ int xnintr_destroy (xnintr_t *intr)
  *
  * @param cookie A user-defined opaque value which is stored into the
  * interrupt object descriptor for further retrieval by the ISR/ISR
- * handlers.
- *
+ * handlers. *
  * @return 0 is returned on success. Otherwise, -EINVAL is returned if
  * a low-level error occurred while attaching the interrupt. -EBUSY is
  * specifically returned if the interrupt object was already attached.



--------------enigC21863D10A849517E6293C98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD37X5niDOoMHTA+kRAouKAJ41GapT4QdSIVYi0WI7bNIPblpGwQCeLFz3
spdu5nqPWwEW0Mja5oxhT+M=
=tf+e
-----END PGP SIGNATURE-----

--------------enigC21863D10A849517E6293C98--

