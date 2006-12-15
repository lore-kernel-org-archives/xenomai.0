Message-ID: <4582B3B0.8080505@domain.hid>
Date: Fri, 15 Dec 2006 15:39:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Latency trace on ARM
References: <E1GutB2-0005VT-Vb@domain.hid>
	<E1Gv9g9-0001FB-Gy@domain.hid> <458270A5.8050905@domain.hid>
	<E1GvE4x-0002Xw-4y@domain.hid>
In-Reply-To: <E1GvE4x-0002Xw-4y@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig94AAF901FB0959AFD12D442C"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94AAF901FB0959AFD12D442C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> Jan Kiszka wrote:
>>>> Sebastian Smolorz wrote:
>>>>> Hi,
>>>>>
>>>>> we all know that the latency test should not be run with a period o=
f
>>>>> 100 us because it easily gets locked up. The attached trace illustr=
ates
>>>>> this problem in detail. It shows that a timer interrupt needs about=
 50
>>>>> us to be processed. Furthermore, there is not enough time between t=
wo
>>>>> timer interrupts for the latency task to get all its work done.
>>>>>
>>>>> The current I-pipe tracer patch for ARM is available at
>>>>> http://opensource.emlix.com/ipipe-s3c24xx/download/ipipe-tracer-arm=
=2Epat
>>>>> ch _v4
>>>>>
>>>>> Comments welcome.
>>>> Something is still broken, given all those "N"s in Delay column. Is
>>>> there something like NMI at all on your board?
>>> There isn't AFAIK. What could be the reason for all this noise? Recur=
sive
>>> spin-locking?
>> Yes. If those Ns aren't false positive in the sense that
>> IPIPE_TFLG_NMI_HIT is set accidentally, __ipipe_trace is re-entered
>> while IPIPE_TFLG_NMI_LOCK is still set.
>=20
> Interesting: If I disable CONFIG_IPIPE_TRACE_MCOUNT the "Noise" doesn't=
 appear=20
> at all.

Sounds like some function that __ipipe_trace calls is instrumented, thus
the recursion. Could be something trivial like memcpy (if that happens
to be uninlined here). You may want to check the disassembly... :)

Jan


--------------enig94AAF901FB0959AFD12D442C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgrOwniDOoMHTA+kRAuS4AJ9CpVLsOq+cuq8dtilc5S31CZ1PXgCfWwX1
Fy9RWNorD4OFRrPKlEEyE18=
=U2yv
-----END PGP SIGNATURE-----

--------------enig94AAF901FB0959AFD12D442C--

