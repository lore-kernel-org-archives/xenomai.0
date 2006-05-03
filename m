Message-ID: <4458625C.5020808@domain.hid>
Date: Wed, 03 May 2006 09:57:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Have condition variables Priority Inheritance
	Protection (PIP)?
References: <200604281736.28169.lbocseg@domain.hid> <44527E39.7090501@domain.hid>
	<200605020936.00576.lbocseg@domain.hid>
In-Reply-To: <200605020936.00576.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D03A4966B5369F910C0AB16"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D03A4966B5369F910C0AB16
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Sexta 28 Abril 2006 17:42, Jan Kiszka escreveu:
>=20
>> ...
>>> Could someone please point me the reason?
>> Just as with semaphores: there is no ownership concept for condition
>> variables. Thus, who should be boosted to your priority in case you
>> decide to wait on such a resource?
>=20
> Sorry, you are right. Xenomai has no way of knowing which tasks could s=
ignal=20
> the condition variable. If I wanted to wait on some resource using prio=
rity=20
> inheritance I guess I would have to raise the priority of the task owni=
ng the=20
> resource manually when only one task can signal the condition variable =
(or=20
> semaphore). Do you know other better approaches? I mean if a task A of =

> priority 50, shares a resource with task B and C, both priority 10 thro=
ugh=20
> semaphores. Suppose B and C are using the semaphore when A requests it.=
 How=20
> could they be boosted to A's priority, so that A is protected with prio=
rity=20
> inheritance and then go back to their original priorities? Or should I =
use=20
> other IPC mechanism for sharing resource with PIP?

Mutexes were invented for such resource access control :). They have a
strict ownership concept, thus allowing to apply PIP as well.

Jan


--------------enig6D03A4966B5369F910C0AB16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEWGJcniDOoMHTA+kRAn8VAJ9TbPQ31zf7ZGnhzTIhLKUDXprUsQCeMSyc
YI/9npcSJGW5WHpruhV9nF8=
=f1Ie
-----END PGP SIGNATURE-----

--------------enig6D03A4966B5369F910C0AB16--

