Message-ID: <458681C3.9040507@domain.hid>
Date: Mon, 18 Dec 2006 12:55:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Latency trace on ARM
References: <E1GutB2-0005VT-Vb@domain.hid>
	<E1GvE4x-0002Xw-4y@domain.hid> <4582B3B0.8080505@domain.hid>
	<E1GwG68-0005um-1j@domain.hid>
In-Reply-To: <E1GwG68-0005um-1j@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig93B2B1CD9C77033976CE8F22"
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
--------------enig93B2B1CD9C77033976CE8F22
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> Jan Kiszka wrote:
>>>> Sebastian Smolorz wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Sebastian Smolorz wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> we all know that the latency test should not be run with a period=
 of
>>>>>>> 100 us because it easily gets locked up. The attached trace
>>>>>>> illustrates this problem in detail. It shows that a timer interru=
pt
>>>>>>> needs about 50 us to be processed. Furthermore, there is not enou=
gh
>>>>>>> time between two timer interrupts for the latency task to get all=
 its
>>>>>>> work done.
>>>>>>>
>>>>>>> The current I-pipe tracer patch for ARM is available at
>>>>>>> http://opensource.emlix.com/ipipe-s3c24xx/download/ipipe-tracer-a=
rm.p
>>>>>>> at ch _v4
>>>>>>>
>>>>>>> Comments welcome.
>>>>>> Something is still broken, given all those "N"s in Delay column. I=
s
>>>>>> there something like NMI at all on your board?
>>>>> There isn't AFAIK. What could be the reason for all this noise?
>>>>> Recursive spin-locking?
>>>> Yes. If those Ns aren't false positive in the sense that
>>>> IPIPE_TFLG_NMI_HIT is set accidentally, __ipipe_trace is re-entered
>>>> while IPIPE_TFLG_NMI_LOCK is still set.
>>> Interesting: If I disable CONFIG_IPIPE_TRACE_MCOUNT the "Noise" doesn=
't
>>> appear at all.
>> Sounds like some function that __ipipe_trace calls is instrumented, th=
us
>> the recursion. Could be something trivial like memcpy (if that happens=

>> to be uninlined here).
>=20
> Ok, your hint was very useful! The problem was __ipipe_mach_get_tsc() w=
hich is=20
> no inline function (and can't be). I solved it by adding 'notrace' to t=
he=20
> function. Now the 'N's don't appear at all!

And I guess the overhead should drop a bit as well. Perfect.

If you have anything more pending, please post soon, Gilles is
collecting the ARM stuff for Xenomai 2.3.

Jan


--------------enig93B2B1CD9C77033976CE8F22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFhoHDniDOoMHTA+kRAi5SAJ4nsoG59pg0SCeZ6v9QLAu5mwYeDgCeN54t
AbOo5y3eJ7uA7ZGuzv/pGtA=
=sR8+
-----END PGP SIGNATURE-----

--------------enig93B2B1CD9C77033976CE8F22--

