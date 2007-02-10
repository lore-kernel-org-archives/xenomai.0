Message-ID: <45CD0CBA.9070004@domain.hid>
Date: Sat, 10 Feb 2007 01:07:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45CCEB58.8020103@domain.hid> <1171064941.25642.50.camel@domain.hid>
In-Reply-To: <1171064941.25642.50.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig854A76E92C79CEEAEB2777D8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: xnpod_suspend_thread and past absolute timeouts
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig854A76E92C79CEEAEB2777D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2007-02-09 at 22:44 +0100, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> RTnet revealed a problem of rtdm_task_sleep_until in trunk. When being=

>> called with a past date, it blocks forever because xnpod_suspend_threa=
d
>> considers such timeouts as infinite:
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c?v=
=3DSVN-trunk#1456
>>
>> Are there users relying on this property of xnpod_suspend_thread? If
>> yes, I would unfortunately have to catch this case in RTDM.
>>
>=20
> Here is the proposed change, absolutely untested; could you give this
> hell on your favourite RTNet torture? TIA,

No full test yet, but the scenario that failed before now works nicely.

Jan


--------------enig854A76E92C79CEEAEB2777D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFzQy6niDOoMHTA+kRAj22AJsHga21/aC6V2EXuefLW4KlZaQejgCeMcRQ
dPpgjBYLYM+WQ0ApzEXQJSk=
=1rcB
-----END PGP SIGNATURE-----

--------------enig854A76E92C79CEEAEB2777D8--

