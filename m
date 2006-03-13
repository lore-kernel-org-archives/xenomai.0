Message-ID: <4415B605.105@domain.hid>
Date: Mon, 13 Mar 2006 19:12:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>	<200603101700.10820.lbocseg@domain.hid>
	<44155BFD.300@domain.hid> <200603131154.13627.lbocseg@domain.hid>
In-Reply-To: <200603131154.13627.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig85C4E0B89AE0BBD673FEAB69"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85C4E0B89AE0BBD673FEAB69
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Segunda 13 Mar=E7o 2006 08:48, voc=EA escreveu:
>> ...
>>
>>> Do you mean that rtdm_clock_read will always read a multiple of tickv=
al
>>> value? If so, I think it would be good to make it clear on its
>>> documentation. "Get system time" isn't enough for getting this
>>> information, IMHO.
>> Please have a look at the two sentences of documentation I added to SV=
N
>> (didn't make it into the release).
>=20
> I did.
>=20
>> I gave your scenario a try, and I was able to verify that
>> rtdm_task_busy_sleep works correctly under both timer modes.
>=20
> I cannot understand yet why it doesn't occur here, but I'll investigate=
 if I
> have the time to.

I counted the loops rtdm_task_busy_sleep took, and they were quite
similar (IRQ noise aside).

>=20
>> Indeed, the
>> behaviour of rtdm_clock_read may have been confusing due to lacking
>> information, but it was also correct.
>=20
> I liked the note, but I would include another one:
> "When in periodic mode, the time resolution is limited to the tick set =
to the
> system timer" or something like. Maybe:
> "[If using periodic mode, note that ]The time resolution is limited by =
the
> system timer tick". Well my English is not that good, so I think you co=
uld
> give a better description, but I really need this note is very useful.

"Resolution" is the accurate term, indeed. To include what I think is
the core of your suggestions:

"The resolution of the this service depends on the system timer. In
particular, if the system timer is running in periodic mode, the return
value will be limited to multiples of the timer tick period."

Actually, the resolution based on TSC is also limited - when your CPU
has less then 1 GHz. ;)

Jan


--------------enig85C4E0B89AE0BBD673FEAB69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFbYFniDOoMHTA+kRAhJ5AJ0fToxJcZ9Cz9LGpE0MHL0LHSrObQCdF23M
71kCePetai3+oINvgE6YE7I=
=nNNu
-----END PGP SIGNATURE-----

--------------enig85C4E0B89AE0BBD673FEAB69--

