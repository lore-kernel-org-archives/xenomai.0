Message-ID: <44ACFE07.5040609@domain.hid>
Date: Thu, 06 Jul 2006 14:11:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] delete queues "offline"; /proc/stat
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F8CE2@domain.hid>	<17580.62092.647925.100612@domain.hid>	<44ACF432.7090200@domain.hid>
	<17580.64278.6862.15230@domain.hid>
In-Reply-To: <17580.64278.6862.15230@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig936FB5C4A5CA30E9AF7DE3B1"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig936FB5C4A5CA30E9AF7DE3B1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > > Yes, all resources specific to a process are deleted automatically=
, so,
>  > > any message queue descriptor or shared memory descriptor is
>  > > closed. Named objects are not deleted though, since they may be sh=
ared
>  > > between several processes, only non-pshared anonymous objects and =
named
>  > > objects *descriptors* are deleted. This is the only reasonable
>  > > implementation I could find.
>  >=20
>  > What about a usage counter maintained on creation/binding vs.
>  > closing/destruction? I would prefer to get them cleaned up automatic=
ally
>  > as well somehow, or we really need tool support for IPC cleanup, and=

>  > that is ugly in my eyes.
>=20
> I am not sure one would expect a named object to be unlinked when one o=
nly
> calls its "close" service, without calling its "unlink" service. If, on=

> the other hand, one calls the "unlink" service, then the object will be=

> automatically destroyed when the last descriptor is closed, as mandated=

> by the specification.

But if the creator of an object dies + there are no further open
instances, I see no practical reason to keep this alive. I'm talking
about the check on process exit here, not on explicit close().

>=20
> Moreover, the existence of such objects is not a leak that will grow
> over time, if one do not use the O_EXCL flag when opening objects,
> existing objects will simply be reused. If one use the O_EXCL flag,
> opening will fail.
>=20
> This behaviour is the same as Linux behaviour.
>=20

Well, I have sys-v ipc in mind where I used to fiddle a lot with ipcrm
to get certain applications running again after unexpected termination.
The reason was that the developers used the existence of certain ipc
names to check if a central component was already running.

Maybe it's really dependent on the actual ipc mechanism, and having the
one characteristic for posix and some other later for native might be
the way to go.

Jan


--------------enig936FB5C4A5CA30E9AF7DE3B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErP4HniDOoMHTA+kRAvWaAJ4/uAcfGzbeQKu8ZDSN7wQj/I6u8ACfQXpm
lMYlE3kO2JkmD8VNSFzCc44=
=0Qkp
-----END PGP SIGNATURE-----

--------------enig936FB5C4A5CA30E9AF7DE3B1--

