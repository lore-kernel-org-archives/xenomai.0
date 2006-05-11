Message-ID: <4462EE15.4030307@domain.hid>
Date: Thu, 11 May 2006 09:56:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Pending ownership and resource stealing
References: <44619D0B.1080402@domain.hid>	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
	<4461BB5A.3010403@domain.hid> <44621B00.7090703@domain.hid>
	<44622425.2060302@domain.hid> <446259CD.1030303@domain.hid>
In-Reply-To: <446259CD.1030303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig11C64ED670DF524643693400"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig11C64ED670DF524643693400
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> The only thing that
>>> should change downstream compared to the previous behaviour is that
>>> xnsynch_sleep_on() might unblock immediately at skin level without an=
y
>>> xnsynch_wakeup_sleeper() calls being previously invoked, since the
>>> blocking call does the stealing during the pending ownership window.
>>>
>>> This means that skins now _must_ fix their internal state when unbloc=
ked
>>> from xnsynch_sleep_on() if they happen to track their own resource ow=
ner
>>> field for instance, since they might become the owner of such resourc=
e
>>> without any unlock/release/whatever routine being called at the said
>>> skin level. I've fixed a couple of skins for that purpose (not checke=
d
>>> RTDM btw), but it would be safer if you could double-check the impact=
 of
>>> such change on the interfaces you've crafted.
>>
>>
>> Well, if this means that once you have called xnsynch_wakeup_sleeper()=

>> for some lower-prio task, you must call xnsynch_sleep_on() to steal it=

>> for a higher-prio task, then RTDM needs fixing (it only sets a private=

>> lock bit in this case).
>=20
> No need to call xnsynch_sleep_on() more than usually done; just have a
> look at native/mutex.c in rt_mutex_lock(), and follow the code labeled
> grab_mutex, it should give your the proper illustration of the issue.

I did so and discovered that prio-inheritance was broken for
RTDM-mutexes right from the beginning. In case such a mutex was entered
uncontended, the owner was not recorded. Oops...

This caused no crash due to the check "owner !=3D NULL" in
xnsynch_sleep_on [1]. But this also made me wonder if it is a reasonable
state for a PIP synch object to be acquired without having an owner. If
no, we should rather bail out in some way here.

Anyway, RTDM seems to work fine now (trunk and 2.1.x), even with a
reduced rtdm_mutex_t data structure and shrunken code (rtdm_mutex_unlock
became trivial by only using xnsynch_t). Further tests will follow
during the day. Oh, and the look-steeling code behaved as expected so far=
=2E

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/synch.c=
#L179


--------------enig11C64ED670DF524643693400
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEYu4aniDOoMHTA+kRAk4BAJwPprAK3LQKT/FoaxuWudVPRDBj3QCfVFf3
42uUvvRmV/bcW3aGo7aPa+E=
=GcB9
-----END PGP SIGNATURE-----

--------------enig11C64ED670DF524643693400--

