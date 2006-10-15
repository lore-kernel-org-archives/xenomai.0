Message-ID: <45321C82.6040103@domain.hid>
Date: Sun, 15 Oct 2006 13:33:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] build fix for !CONFIG_IPIPE
References: <45321A93.2090608@domain.hid>
In-Reply-To: <45321A93.2090608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig04C2D7D78B07BB58C84F268E"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04C2D7D78B07BB58C84F268E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Just found this patch in my repository while switching to the latest.
>=20

Somehow the patch became an octet stream...

--- linux-2.6.17.13.orig/include/linux/ipipe.h
+++ linux-2.6.17.13/include/linux/ipipe.h
@@ -763,6 +763,7 @@ void fastcall *ipipe_get_ptd(int key);
 #define ipipe_irq_unlock(irq)		do { } while(0)

 #define ipipe_root_domain_p		1
+#define ipipe_safe_current()		current

 #endif	/* CONFIG_IPIPE */




--------------enig04C2D7D78B07BB58C84F268E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFMhyFniDOoMHTA+kRArrdAJ4lsW/a5FjIa1hLXWXW53UKtc1+4ACfYgU5
/K3V28Se7vSolBjqxub7BU4=
=CKkY
-----END PGP SIGNATURE-----

--------------enig04C2D7D78B07BB58C84F268E--

