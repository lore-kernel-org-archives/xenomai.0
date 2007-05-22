Message-ID: <46532186.8070809@domain.hid>
Date: Tue, 22 May 2007 18:59:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C5@domain.hid>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C5@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0131C708E85030B564919360"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0131C708E85030B564919360
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

RAKOTOSALAMA, Nirilanto wrote:
> Hello,
>=20
> I have some question about CPU affinity with Xenomai 2.3.1.
> (it is to see if  xenomai support developing for a cpu manager library =
is feasible)

What will this library do? (/me just nosy)

>=20
> When using rt_task_create, CPU mask can be specified. However, when sch=
ed_setaffinity is called=20
> to modify main program affinity, and after, rt_task_create is called wi=
thout specifying CPU mask,
> did the child task inherits from the main program affinity ?

If you don't provide a target CPU (either on creation or via
/proc/xenomai/affinity), better consider the affinity as unspecified
(any possible CPU). The target CPU derives from Linux decision where to
put the thread non-RT boot code on, Xenomai just nails that decision
down until someone explicitly migrates.

>=20
> Same question for Posix skin threads ?
>=20
> Can native task affinity be set other than when creating ? using sdhed_=
setaffinity ?

/proc/xenomai/affinity (has global scope) or sched_setaffinity. Xenomai
shadow threads follow the migration that may took place while in
secondary mode, and sched_setaffinity comes with such a mode switch.

>=20
> Can posix skin thread affinity be set using sched_affinity ?
>=20
>=20
> Thanks in advance.
>=20
> Niry.
>=20

Jan


--------------enig0131C708E85030B564919360
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGUyGGniDOoMHTA+kRAizgAJ9o8dRt6s186ByH4AfzUs83yKQ0RwCfdNQt
5D9Q2XQjSLxf5k8NhznHGTM=
=f/kV
-----END PGP SIGNATURE-----

--------------enig0131C708E85030B564919360--

