Message-ID: <4773A1D8.4030509@domain.hid>
Date: Thu, 27 Dec 2007 14:00:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <25501221.1198142506055.JavaMail.ngmail@domain.hid>
In-Reply-To: <25501221.1198142506055.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC1E5AED6CD78AEF295D77138"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RTnet-users] /proc/xenomai/affinity and
	T_CPU(n) in
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1E5AED6CD78AEF295D77138
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> does this mean that the value of /proc/xenomai/affinity is only relevan=
t fo=3D
> r creation of a new task?
> I.e., once it is created I can modify it without "destroying" anything =
in t=3D
> he already created tasks?=3D20
> If this is the case I think I get everything up and running following y=
our =3D
> hint.

If your worries are that modifying /proc/xenomai/affinity would force
running tasks to new CPUs: no, there is no such side effect. The
affinity mask only "burns" the CPU affinity into the task structure when
they are created. Later states of that mask do not impact existing tasks.=


>=20
> Perhaps the word "affinity" does not exactly describe the behaviour her=
e as=3D
>  it is not only affinity but also=3D20
> "allowed CPUs for new tasks"....

Feel free to define the precise semantic of this feature e.g. in the
wiki :). In the end, expectations and associations always change the
meaning of terms in the eye of the user.

Jan


--------------enigC1E5AED6CD78AEF295D77138
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHc6HcniDOoMHTA+kRAjrxAJ9n2VgOF0jya677gwjAd+HbMQXE0wCfRj+Y
YJfrN3gLCMBDdWoDEyeMlgE=
=2EJZ
-----END PGP SIGNATURE-----

--------------enigC1E5AED6CD78AEF295D77138--

