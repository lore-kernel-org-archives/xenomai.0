Message-ID: <4C0A9AB9.7030602@domain.hid>
Date: Sat, 05 Jun 2010 20:43:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid> <4C095876.3060605@domain.hid>
	<4C099329.6000303@domain.hid> <4C0A49C4.8000509@domain.hid>
In-Reply-To: <4C0A49C4.8000509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig08A35F5ECD84303458E44787"
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
--------------enig08A35F5ECD84303458E44787
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> GIT version control wrote:
>>>> Module: xenomai-jki
>>>> Branch: for-upstream
>>>> Commit: 0352b068600bd4ef3172c8a42416badbcdad32ca
>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D0=
352b068600bd4ef3172c8a42416badbcdad32ca
>>>>
>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>> Date:   Wed Apr 28 15:08:11 2010 +0200
>>>>
>>>> native: Rework handling of pthread carrier thread
>>>>
>>>> This patch improves two pitfalls of libnative's interaction with
>>>> underlying pthreads:
>>>>
>>>> First, it tries to detect double deletions (cancellations or joining=
s)
>>>> of pthreads and report them via an error code. This reduces the risk=
 to
>>>> trigger a SIGSEGV accessing meanwhile released pthread objects. And
>>>> second, it properly detaches joinable pthreads when they are deleted=

>>>> instead. This properly releases the pthread resources.
>>> I really do not understand that. What is the point of creating a
>>> joinable thread if you do not want to join it once it has been cancel=
ed?
>>>
>> Keep in mind that there is no pthread_cancel equivalent in the native
>> API. Moreover, even POSIX has pthread_detach so that you are not force=
d
>> to join every joinable thread. I could imagine that one may want to us=
e
>> this fot error cleanups. But first of all this is about improving the
>> API consistency and fault tolerance.
>=20
> I have no strong opinion on that matter, but it looks to me like the
> "joinable" stuff in the native API is made to look like the posix
> equivalent, following the principle of least surprise. So, since posix
> requires joining a thread after canceling, it should be necessary to
> join a thread after deleting it.

The problem is that there is no direct equivalent to rt_task_delete with
pthread. What comes closest is pthread_cancel + pthread_detach (where
required). Still, rt_task_delete is synchronous, pthread_cancel not.

>=20
> As for pthread_detach, its main justification is a corner case: being
> able to avoid leaks when canceling a thread which was blocked in a call=

> to pthread_join by calling pthread_detach in the cancelation cleanup
> handler.
>=20
> The reason for the way the native API is, is that you may delete a
> thread which is in fact running in another process. And I am not sure
> the patch you sent addresses this issue.

I does not. And thinking about it, I guess we should simply deny remote
deletion of joinable tasks as there is no reasonable way to cleanly
release the remote pthread resources. I could post an update for code
and docs on top of this.

Jan


--------------enig08A35F5ECD84303458E44787
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwKmrkACgkQitSsb3rl5xTg9QCgnaZyFCvvFt18G3HHCfJDcnEv
69EAoNXFOwLsHPRwIXHzu3VnJ/TvoMz1
=Oi0m
-----END PGP SIGNATURE-----

--------------enig08A35F5ECD84303458E44787--

