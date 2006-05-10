Message-ID: <44622425.2060302@domain.hid>
Date: Wed, 10 May 2006 19:34:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Pending ownership and resource stealing
References: <44619D0B.1080402@domain.hid>	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
	<4461BB5A.3010403@domain.hid> <44621B00.7090703@domain.hid>
In-Reply-To: <44621B00.7090703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0F918D838D9B1EFCE2A3356B"
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
--------------enig0F918D838D9B1EFCE2A3356B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>=20
>> Besides this, we then may want to consider if introducing a pending
>> ownership of synch objects is worthwhile to improve efficiency of PIP
>> users. Not critical, but if it comes at a reasonable price... Will try=

>> to draft something.
>>
>=20
> I've committed an implementation of this stuff to the trunk, tested on
> your testcase over the simulator. So far, it's ok.

I'll give up, you are too fast for me. ;)

> The only thing that
> should change downstream compared to the previous behaviour is that
> xnsynch_sleep_on() might unblock immediately at skin level without any
> xnsynch_wakeup_sleeper() calls being previously invoked, since the
> blocking call does the stealing during the pending ownership window.
>=20
> This means that skins now _must_ fix their internal state when unblocke=
d
> from xnsynch_sleep_on() if they happen to track their own resource owne=
r
> field for instance, since they might become the owner of such resource
> without any unlock/release/whatever routine being called at the said
> skin level. I've fixed a couple of skins for that purpose (not checked
> RTDM btw), but it would be safer if you could double-check the impact o=
f
> such change on the interfaces you've crafted.

Well, if this means that once you have called xnsynch_wakeup_sleeper()
for some lower-prio task, you must call xnsynch_sleep_on() to steal it
for a higher-prio task, then RTDM needs fixing (it only sets a private
lock bit in this case).

>=20
> This change only affects PIP-enabled synchronization objects in a
> reasonably limited manner and seems to behave properly, but please, giv=
e
> this code hell on your side too.
>=20

Will do.

Jan


PS: The usage can be checked also via the cross reference:
http://www.rts.uni-hannover.de/xenomai/lxr/ident?v=3DSVN-trunk;i=3DXNSYNC=
H_PIP


--------------enig0F918D838D9B1EFCE2A3356B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEYiQlniDOoMHTA+kRAsu8AJ921izU80v00eYihLtMS8QqqOJngACfSc8G
0aCJGVm2EHwUsNWDbXXgJMo=
=GMY3
-----END PGP SIGNATURE-----

--------------enig0F918D838D9B1EFCE2A3356B--

