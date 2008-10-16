Message-ID: <48F7B98D.8040000@domain.hid>
Date: Fri, 17 Oct 2008 00:00:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016145757.935266172@domain.hid>	<48F76068.7050903@domain.hid>
	<48F76362.4010104@domain.hid> <48F79F7A.2030304@domain.hid>
In-Reply-To: <48F79F7A.2030304@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFFE36D9E51552783A68B2006"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 0/2] Fix and improve task/thread inquire
 services
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFFE36D9E51552783A68B2006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> This series fixes the issues around rt_task_inquire I posted yesterd=
ay.
>>>> Additionally, it introduces an analogous services pthread_inquire_np=
 for
>>>> the POSIX skin. That allows, among other things, to implement test c=
ases
>>>> for the upcoming fast xnsynch/mutex patches.
>>> Ok. Since this applies only for debugging purpose, and displaying
>>> whether a task is in primary mode may be use badly by users, maybe we=

>>> should make this service a shadow syscall, and not export any interfa=
ce
>>> to use it. This would further avoid duplication between the native an=
d
>>> posix skins.
>> Debugging is not the holy, exclusive business of Xenomai hackers.
>>
>> The inquire services are useful in libraries as well, when you want to=

>> check if the caller complies to the call convention ("don't use in
>> primary mode", "caller's priority must not exceed X" or whatever).
>>
>> That said, I'm open for unifying the code, maybe introducing some
>> xnthread_inquire.
>>
>=20
> That would be much better than publishing an open interface to fiddle e=
ven more
> with thread modes via rt_task_set_mode(). I would definitely merge that=
=2E

Code refactoring is no problem, will work that out. I just want to keep
the user interface.

Jan


--------------enigFFE36D9E51552783A68B2006
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3uY0ACgkQniDOoMHTA+mvYwCeNPxfJkXYjdpsMFfPc3t8lSNc
5YgAnj3w6vsi3InYyhmDQO+AEGtYATgM
=SiVN
-----END PGP SIGNATURE-----

--------------enigFFE36D9E51552783A68B2006--

