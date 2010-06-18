Message-ID: <4C1BD462.1000702@domain.hid>
Date: Fri, 18 Jun 2010 22:17:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid>
	<4C095876.3060605@domain.hid>	<4C099329.6000303@domain.hid>
	<4C0A49C4.8000509@domain.hid>	<4C0A9AB9.7030602@domain.hid>
	<4C0A9C2A.1030002@domain.hid>	<4C0AA224.6060409@domain.hid>
	<4C0AA2F0.6050201@domain.hid>	<4C0AA3EC.7040106@domain.hid>
	<4C0AA548.6070409@domain.hid>	<4C0AB7BA.7000100@domain.hid>
	<4C0B9846.7050203@domain.hid> <4C1BC224.5040505@domain.hid>
	<4C1BC3BA.3020603@domain.hid>
In-Reply-To: <4C1BC3BA.3020603@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFF7C12651211319D2A2187E8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Rework
 handling of pthread carrier thread
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFF7C12651211319D2A2187E8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> However, I do not have a strong opinion on this, it is just an open
>>> question. More generally, I would like us to discuss once and for all=

>>> about the semantic of the various calls and their effect on the RT_TA=
SK
>>> duration, instead of changing this semantic every release and risk
>>> breaking non-broken applications (I mean, the one which do not segfau=
lt).
>> To pick up this issue again (in order to get my queue flushed):
>>
>> We basically have to decide about the question what rt_task_delete
>> invalidates and what impact this shall have on rt_task_join. It is
>> already documented that rt_task_delete invalidates (and releases) the
>> kernel-side resources of a RT_TASK. The question is what shall happen =
to
>> the not explicitly mentioned user-side resources (ie. the pthread -
>> where available).
>>
>> Option 1 is to decouple both and keep the user side of a joinable
>> RT_TASK alive until it is explicitly joined. Option 2 could be to
>> declare both parts invalid on rt_task_delete. Based on this decision,
>> the finalization logic of rt_task_delete and rt_task_join then needs t=
o
>> be adjusted to deliver the right behavior, including proper error code=
s
>> instead of sporadic SEGV.
>=20
> Relying on the contents of the RT_TASK structure to know the state of a=

> task is bound to fail: the RT_TASK structure may be copied around, so
> changing the contents of the RT_TASK structure in rt_task_delete, to us=
e
> that information later will only work if the same RT_TASK structure is
> used later. This is fragile.

That's true but somehow the best we can do to detect errors that remain
fuzzy otherwise. We neither have a list of all user space RT_TASK
structs nor any in-kernel object to ask after rt_task_delete or join.

>=20
>> Do we expect applications to rely on this joinability after
>> rt_task_delete? If yes, we should make it official, document the
>> descriptor split and the fact that the descriptor cannot be looked up
>> anymore after deletion but has to be saved beforehand.
>>
>> Independently, we need to clarify that cross-process join is not
>> supported. Trying to do this ATM will result in a SEGV (something I
>> missed so far).
>=20
> This is a regression. At some point in the past, a NULL pthread_t opaqu=
e
> pointer was used to mean that the thread was living in a different
> process, and rt_task_delete would skip the pthread_cancel.
>=20

I was talking about rt_task_join on a foreign RT_TASK. And I was wrong,
it actually works with and without my patch SEGV-free. It just lacks
documentation.

But you did not address the core questions.

Jan


--------------enigFF7C12651211319D2A2187E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwb1GYACgkQitSsb3rl5xRWfACdGHn3XVYJ9Vr3wVzuLpOoG+7x
aYQAoJ7XLkUL9OmaJNsNEPhesjFqk/80
=1zcy
-----END PGP SIGNATURE-----

--------------enigFF7C12651211319D2A2187E8--

