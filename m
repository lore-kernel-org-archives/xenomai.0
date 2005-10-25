Message-ID: <435E5647.70406@domain.hid>
Date: Tue, 25 Oct 2005 17:59:03 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How to implement a GUI for RT apps?
References: <435D7D8C.1010004@domain.hid> <435E079F.4030108@domain.hid>
	<435E0921.20001@domain.hid> <435E5044.8090600@domain.hid>
In-Reply-To: <435E5044.8090600@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9E99D40B6259B6464D02B78E"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E99D40B6259B6464D02B78E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
> Jan Kiszka wrote:
>=20
>=20
>>Ignacio Garc=EDa P=E9rez wrote:
>>=20
>>
>>
>>>>1. What's the best way to implement a GUI for a RT app?
>>>>    =20
>>>>
>>>
>>>Make it non-RT. The "U" in "GUI" is user. Users are not real time.
>>>
>>>  =20
>>>
>>
>>Not true. That thread must be mapped to Xenomai in order to use
>>rt-mutexes. Otherwise, one has to use rt-pipes.
>>
>>Jan
>>
>>=20
>>
>=20
> I was talking design. Anything that requires user interaction is by
> definition non-realtime, so,  if you have the choice to leave it out of=


Do you happen to design ATMs as well? They interact with me, a user, but
also not in real-time. I typically have to type my PIN at least two
times to get all digits recognised. ;)

> the RT domain, do it. You'll save a lot of headaches.
>=20
> Of course, if your GUI is so tightly coupled to your RT processing that=

> you cannot do without rt_mutexes and/or other sync primitives, then you=

> must map it to Xenomai.

Basically, we are discussing here where to put the "bridge" between RT
and non-RT. Some instance in your system has to be a bridge which
switches between both worlds in order to get data in and out of the RT
domain. Such bridge can be a rt-pipe (and related variants) or an
explicitly coded version at application layer. I don't see why it should
be bad design or cause troubles to create Xenomai RT threads like this:

while (!finished) {
    do_a_lot_of_non-rt_stuff;

    rt_mutex_lock();
    copy_data_between_rt_and_local_buffers;
    rt_mutex_unlock();

    do_more_non_rt_stuff;
}

Only when the code between rt_mutex_lock and unlock gets too complicated
and intransparent, your design needs a revision.

Ok, an option that does not require context migrations is lock-less
synchronisation. For example, one may maintain revision counters of data
structures which get updated on changes by the RT part. The non-RT part
can then spin on reading a consistent version until the revision on
entry equals the one on exit. And double-buffering can be used to write
data structures into the RT domain. But this can be more complex and is
not feasible in each and every scenario.

Jan


--------------enig9E99D40B6259B6464D02B78E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDXlZHncNeS9Q0k+IRAp/vAJ9kFg4005iEVxvCPb/3tOb4aYbsewCfXJBJ
Q7A9ZRzECQ4kRhymdvHeh88=
=TnIh
-----END PGP SIGNATURE-----

--------------enig9E99D40B6259B6464D02B78E--

