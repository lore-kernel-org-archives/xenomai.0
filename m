Message-ID: <4A490144.8050300@domain.hid>
Date: Mon, 29 Jun 2009 20:00:36 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <1245669529.7250.3.camel@domain.hid>
In-Reply-To: <1245669529.7250.3.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2A2ADD9E02519C0039D3E211"
Subject: Re: [Xenomai-core] Problem running klatency test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A2ADD9E02519C0039D3E211
Content-Type: multipart/mixed;
 boundary="------------010806040008000601020005"

This is a multi-part message in MIME format.
--------------010806040008000601020005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Shashank Bhatia schrieb:
> [...]
> open(/proc/xenomai/registry/native/pipes/klat_pipe): No such file or
> directory
> modprobe klat_mod or try the -P option?

the module ist called xeno_klat. patch attached.


--------------010806040008000601020005
Content-Type: text/plain;
 name="xeno_klat.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno_klat.patch"

diff --git a/src/testsuite/klatency/klatency.c b/src/testsuite/klatency/k=
latency.c
index a22cd59..c419402 100644
--- a/src/testsuite/klatency/klatency.c
+++ b/src/testsuite/klatency/klatency.c
@@ -187,7 +187,7 @@ int main(int argc, char **argv)
 		if (benchdev =3D=3D -1) {
 			perror("open(/proc/xenomai/registry/native/pipes/klat_pipe)");
 			fprintf(stderr,
-				"modprobe klat_mod or try the -P option?\n");
+				"modprobe xeno_klat or try the -P option?\n");
 			exit(EXIT_FAILURE);
 		}
 	} else {

--------------010806040008000601020005--

--------------enig2A2ADD9E02519C0039D3E211
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKSQFJIPTw9rIdn6oRAqHfAJ9h8qo8u8l1bHl9klJ7onokYJreogCfeFOA
vsG9idfRqO01p1ylriAcNhg=
=3z2u
-----END PGP SIGNATURE-----

--------------enig2A2ADD9E02519C0039D3E211--

