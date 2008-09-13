Message-ID: <48CB6316.2020903@domain.hid>
Date: Sat, 13 Sep 2008 08:52:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CA7E5D.3080608@domain.hid>
	<48CA8941.5030005@domain.hid>	<48CA90E8.2080909@domain.hid>
	<48CAA459.2010604@domain.hid>
In-Reply-To: <48CAA459.2010604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig409F387A1DA9BA0A8D78779C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] __pse51_get_current_prio
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
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
--------------enig409F387A1DA9BA0A8D78779C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Hi Gilles,
>>>>
>>>> we've integrated your unit_mutex and our native test, but now we
>>>> stumbled over that __pse51_get_current_prio special syscall to check=
 the
>>>> dynamic thread priority (during pi tests). I guess that service only=

>>>> exists in your private patch queue? What are your plans about this i=
n
>>>> case we want to push the mutex test into mainline? Or should we chec=
k
>>>> the thread prio indirectly (by waking up a lower-prio thread)?
>>> I had plan to remove this from unit_mutex. OTOH, it may come in handy=
 if
>>> we start breaking the xnsynchs...
>> Maybe one could invent some "pthread_inquire_np" so that the usefulnes=
s
>> of this extension increases beyond unit tests.
>=20
> Ok. What about splitting struct sched_param contents into two (16 bits)=

> members ? This way we would get the two priorities with an only
> pthread_get_schedparam syscall.
> On the other hand, when using pthread_inquire_np, we could get some mor=
e
> insteresting information such as the task name, its current wchan, the
> mutexes it holds etc...

The latter use was precisely my idea. We would be talking about a
debugging interface via which we could collect as much
(Xenomai-specific) information about some thread as available (and
relevant to user space).

Jan


--------------enig409F387A1DA9BA0A8D78779C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjLYxkACgkQniDOoMHTA+kxHACggkjyJrHb4PolnhFEHFJnjgt0
iJwAn3lJigB5WCxVRfNvVTqoJF15X1c+
=LuFz
-----END PGP SIGNATURE-----

--------------enig409F387A1DA9BA0A8D78779C--

