Message-ID: <49A1DEBE.6020002@domain.hid>
Date: Mon, 23 Feb 2009 00:24:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BAY135-W5F4633CFE181E5E1DFB22C6B20@domain.hid>
In-Reply-To: <BAY135-W5F4633CFE181E5E1DFB22C6B20@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E4D45DA2BF53D060E02D9B3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rt_task_create with mode T_CPU(1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E4D45DA2BF53D060E02D9B3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thomas Schaefer wrote:
> Hi,
>=20
> I did some testing with the very latest Xenomai svn repository and kern=
el 2.6.28.2 on a quad core xeon arch X86_64.
>=20
> Until a few days ago everything seemed to work just fine.
> Now a task created with T_CPU( anything but 0) doesn't start after rt_t=
ask_start is called.
> I modified the trivial-periodic example and changed the mode to T_CPU(1=
).
> Now the example doesn't work anymore. It works unmodified or with T_CPU=
(0).
>=20
> I was wondering if I missed a change that would explain this behavior o=
r if this is a bug?

Just tested with

diff --git a/examples/native/trivial-periodic.c b/examples/native/trivial=
-periodic.c
index c0422db..b8198f0 100644
--- a/examples/native/trivial-periodic.c
+++ b/examples/native/trivial-periodic.c
@@ -57,7 +57,7 @@ int main(int argc, char* argv[])
 	 *            priority,
 	 *            mode (FPU, start suspended, ...)
 	 */
-	rt_task_create(&demo_task, "trivial", 0, 99, 0);
+	rt_task_create(&demo_task, "trivial", 0, 99, T_CPU(1));
=20
 	/*
 	 * Arguments: &task,

on a dual core system using latest trunk on 2.6.28.7. Works fine, and
the same is true for "latency -c 1". Can you provide more details about
your setup?

Jan


--------------enig3E4D45DA2BF53D060E02D9B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmh3sIACgkQniDOoMHTA+nxhACfdgojn619BnUUNPLpGOOl/dul
rA8AoIO451Z8XOJ+sPfzyhy3/iTxRpeM
=hniV
-----END PGP SIGNATURE-----

--------------enig3E4D45DA2BF53D060E02D9B3--

