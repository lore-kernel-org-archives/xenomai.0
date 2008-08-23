Message-ID: <48AFEF1B.8040508@domain.hid>
Date: Sat, 23 Aug 2008 13:06:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48AFCB3F.6070902@domain.hid>
	<48AFE9E9.3050509@domain.hid>	<48AFEBB9.9080108@domain.hid>
	<48AFED54.6040608@domain.hid> <48AFEE5B.3050200@domain.hid>
In-Reply-To: <48AFEE5B.3050200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFEABC875123EE6D6FB9FA62C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Racy pse51_mutex_check_init?
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
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFEABC875123EE6D6FB9FA62C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Hi Gilles,
>>>>>
>>>>> trying to understand the cb_read/write lock usage, some question ca=
me up
>>>>> here: What prevents that the mutexq iteration in pse51_mutex_check_=
init
>>>>> races against pse51_mutex_destroy_internal?
>>>>>
>>>>> If nothing, then I wonder if we actually have to iterate over the w=
hole
>>>>> queue to find out whether a given object has been initialized and
>>>>> registered already or not. Can't this be encoded differently?
>>>> We actually iterate over the queue only if the magic happens to be
>>>> correct, which is not the common case.
>>> However, there remains a race window with other threads removing othe=
r
>>> mutex objects in parallel, changing the queue - risking a kernel oops=
=2E
>>> And that is what worries me. It's unlikely. but possible. It's unclea=
n.
>> Ok. This used to be protected by the nklock. We should add the nklock =
again.
>=20
> Well I do not think that anyone is rescheduling, so we could probably
> replace the nklock with a per-kqueue xnlock.

If nklock or per queue - both will introduce O(n) at least local
preemption blocking. That's why I was asking for an alternative
algorithm than iterating over the whole list.

Jan


--------------enigFEABC875123EE6D6FB9FA62C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkiv7x0ACgkQniDOoMHTA+nDMgCfV9Ic3Xq1PLyjhhfw0lglFEpY
ZaMAoIRxFU6Zb8AsIoiCX/vYQqIx3JK7
=jhDP
-----END PGP SIGNATURE-----

--------------enigFEABC875123EE6D6FB9FA62C--

