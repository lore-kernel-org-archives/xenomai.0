Message-ID: <44ACF432.7090200@domain.hid>
Date: Thu, 06 Jul 2006 13:29:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] delete queues "offline"; /proc/stat
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F8CE2@domain.hid>
	<17580.62092.647925.100612@domain.hid>
In-Reply-To: <17580.62092.647925.100612@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF6C05141330BAFB18D3E8EE4"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6C05141330BAFB18D3E8EE4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Roderik_Wildenburg@domain.hid wrote:
>  > > > when a xenomai-task crashs which created some queues=20
>  > > > (rt_queue_create)=20
>  > > > and I try to restart the task the creation of the queues=20
>  > > > will fail as=20
>  > > > the queue still exists (error EEXIST =3D=3D 17). Is there a=20
>  > > > possibility to=20
>  > > > see which queues exist (I did not find a hint in the /proc/xenom=
ai
>  > > > directory) and to get rid of these queues (or geneally=20
>  > > > spoken : to get=20
>  > > > rid of allocated resources) e.g. with a commandline tool ?
>  >=20
>  > >=20
>  > > Native or posix skin? Gilles added per-process resource=20
>  > > cleanup to the posix skin in 2.2-rc3.
>  > >
>  >=20
>  > following Murphys law, I, of course, use native skin where this mech=
anism isn?t=20
>  > implemented yet ;-)
>  > What does "per-process resource cleanup" mean ?=20
>  > When the process/thread is killed the queues and other resources of =
this=20
>  > process/thread are deleted automaticaly ?
>=20
> Yes, all resources specific to a process are deleted automatically, so,=

> any message queue descriptor or shared memory descriptor is
> closed. Named objects are not deleted though, since they may be shared
> between several processes, only non-pshared anonymous objects and named=

> objects *descriptors* are deleted. This is the only reasonable
> implementation I could find.

What about a usage counter maintained on creation/binding vs.
closing/destruction? I would prefer to get them cleaned up automatically
as well somehow, or we really need tool support for IPC cleanup, and
that is ugly in my eyes.

Jan


--------------enigF6C05141330BAFB18D3E8EE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErPQyniDOoMHTA+kRAsMFAJ9qtZ5rArK2YxuoRwSppiBsi5w2BwCfTLv7
gVQSk9T287fmtUtXBzY+1Y8=
=IQl1
-----END PGP SIGNATURE-----

--------------enigF6C05141330BAFB18D3E8EE4--

