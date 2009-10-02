Message-ID: <4AC65172.8060900@domain.hid>
Date: Fri, 02 Oct 2009 21:16:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC61F57.2010404@domain.hid> <4AC62804.7090903@domain.hid>
	<4AC62B41.3050404@domain.hid>
In-Reply-To: <4AC62B41.3050404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBEEBD6B9248DC61070E9AB5E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM fd support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBEEBD6B9248DC61070E9AB5E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Hi Jan,
>>>
>>> from discussions on the mailing list, it seems that we are going to n=
eed
>>> that unified file descriptors thing. However, since everybody wants
>>> 2.5.0 to be released ASAP, we should try to think about any changes f=
or
>>> this support which would break the ABI, do them now, and keep the res=
t
>>> for later.
>>>
>>> One such problem is the translation which currently exists between rt=
dm
>>> file descriptors and descriptors passed to the posix skin, by adding
>>> 1024 - 128. So, I propose to fix this issue.
>>>
>>> The idea Philippe had, and which I tend to agree to, was, in case of
>>> open/socket/accept, to open("/dev/null"), and use an association tabl=
e
>>> somewhere to associate with the kernel-space descriptor number. Since=

>>> we are at it, this association table could in fact be the file
>>> descriptor table, which we would put in the core skin ppd. The actual=

>>> data structure should be sparse, a linked list does not scale, so,
>>> probably a hash would do. (I could also propose a solution based on a=
vl
>>> trees, but their implementation is not nearly as simple).
>>>
>>> Additionnally, this would allow our open/socket to conform to posix
>>> which states that open should return the lowest free file descriptor.=

>>>
>>> Should I propose a patch in that direction? Do you see any other
>>> possible cause of ABI breakage when we migrate to an unified file
>>> descriptors structure?
>> Right now this sounds like a plan - but I don't feel 100% comfortable =
to
>> predict that we will get along with it. Converting some skin-specific
>> service to a generic one involves quite a lot of refactoring. It is no=
t
>> really unlikely that we define some ABI now that will later turn out t=
o
>> be insufficient for what we want to achieve.
>=20
> For the posix skin, I can live with a two hops solution right now, and
> implement the one-hop solution later.
>=20
> user-space fd
>       |
>       | core skin fd table
>       v
> kernel-space fd
>       |
>       | posix skin registry
>       v
> actual object
>=20
> If we do this, there is not much re-factoring involved.
>=20
> The question really boils down to whether you accept this solution for
> the rtdm skin too.

Let me check if I got the idea: the first change would only modify the
librtdm and the rtdm part of libpthread_rt, right? The second step would
then, later on in the 2.5.x series, refactor the core to a generic fd
service, change the kernel ABI and adapt the libraries accordingly while
keeping the library ABI? That would only break statically linked Xenomai
apps, not sure if this is a problem, though.

Jan


--------------enigBEEBD6B9248DC61070E9AB5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrGUYEACgkQitSsb3rl5xSz3ACfRL36fZT4y3jEwKuLGSRstDmq
d0QAoIFm9Fh/2ctZ+WTp7n23MiqCVKUV
=m8PO
-----END PGP SIGNATURE-----

--------------enigBEEBD6B9248DC61070E9AB5E--

