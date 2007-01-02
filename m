Message-ID: <459A7525.4060408@domain.hid>
Date: Tue, 02 Jan 2007 16:07:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <459A31E3.40807@domain.hid> <1167744149.30347.2.camel@domain.hid>	
	<459A5E92.6030504@domain.hid> <1167745769.30347.6.camel@domain.hid>	
	<459A64A9.4060707@domain.hid>
	<1167747223.30347.10.camel@domain.hid> <459A6A88.8000803@domain.hid>
	<459A6CFD.4030805@domain.hid>
In-Reply-To: <459A6CFD.4030805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7ECE45DB9A882D210BA8B516"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: SVN checkin #2010
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
--------------enig7ECE45DB9A882D210BA8B516
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> On Tue, 2007-01-02 at 14:56 +0100, Gilles Chanteperdrix wrote:
>>>
>>>> Philippe Gerum wrote:
>>>>
>>>>> On Tue, 2007-01-02 at 14:30 +0100, Gilles Chanteperdrix wrote:
>>>>>
>>>>>
>>>>>> Philippe Gerum wrote:
>>>>>>
>>>>>>
>>>>>>> On Tue, 2007-01-02 at 11:20 +0100, Jan Kiszka wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> Hi all - and happy new year,
>>>>>>>>
>>>>>>>> I haven't looked at all the new code yet, only the commit messag=
es. I
>>>>>>>> found something similar to my fast-forward-on-timer-overrun patc=
h in
>>>>>>>> #2010 and wondered if Gilles' original concerns on side effects =
for the
>>>>>>>> POSIX skin were addressed [1]. I recalled that my own final summ=
ary on
>>>>>>>> this was "leave it as it is" [2].
>>>>>>>>
>>>>>>> The best approach is to update the POSIX skin so that it does not=
 rely
>>>>>>> on the timer code to act in a sub-optimal way; that's why this pa=
tch
>>>>>>> found its way in. Scheduling and processing timer shots uselessly=
 is a
>>>>>>> bug, not a feature in this case.
>>>>>> There is some work to be done on the posix skin anyway, this will =
all be
>>>>>> at once. By the way, I tested the trunk on ARM, and I still get a =
lockup
>>>>>> when the latency period is too low. I wonder if we should not comp=
are to
>>>>>> "now + nkschedlat", or even use xnarch_get_cpu_tsc() instead of "n=
ow".
>>>>> You mean as below, in order to account for the time spent in the ha=
ndler(s)?=09
>>>>>
>>>>> -	while ((xntimerh_date(&timer->aplink) +=3D timer->interval) < now=
)
>>>>> +	while ((xntimerh_date(&timer->aplink) +=3D timer->interval) < xna=
rch_get_cpu_tsc())
>>>>> 		    ;
>>>>>
>>>> I mean even:
>>>>
>>>> 	while ((xntimerh_date(&timer->aplink) +=3D timer->interval) <
>>>> 		xnarch_get_cpu_tsc() + nkschedlat)
>>>>                 ;
>>>>
>>>> Because if the timer date is between now and now + nkschedlat, its
>>>> handler will be called again.
>>>>
>>> Ack.
>>>
>>
>> Keep in mind that this code is now a performance regression for the
>> non-overflow case, specifically when xnarch_get_cpu_tsc() costs more
>> than just a simple CPU register access.
>>
>> My previous "leave it as it is" was also due to the consideration that=

>> we shouldn't pay too much in hotpaths for things that go wrong on
>> misdesigned systems.
>=20
> What about a greedy version like this.
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: ksrc/nucleus/timer.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/nucleus/timer.c	(r=C3=A9vision 2037)
> +++ ksrc/nucleus/timer.c	(copie de travail)
> @@ -184,10 +184,10 @@
>  	xntimer_t *timer;
>  	xnticks_t now;
> =20
> +	now =3D xnarch_get_cpu_tsc();
>  	while ((holder =3D xntimerq_head(timerq)) !=3D NULL) {
>  		timer =3D aplink2timer(holder);
> =20
> -		now =3D xnarch_get_cpu_tsc();
>  		if (xntimerh_date(&timer->aplink) - nkschedlat > now)
>  			/* No need to continue in aperiodic mode since timeout
>  			   dates are ordered by increasing values. */
> @@ -199,6 +199,7 @@
>  			if (!testbits(nktbase.status, XNTBLCK)) {
>  				timer->handler(timer);
> =20
> +				now =3D xnarch_get_cpu_tsc();
>  				if (timer->interval =3D=3D XN_INFINITE ||
>  				    !testbits(timer->status, XNTIMER_DEQUEUED)
>  				    || testbits(timer->status, XNTIMER_KILLED))
> @@ -221,8 +222,9 @@
>  			   translates into precious microsecs on low-end hw. */
>  			__setbits(sched->status, XNHTICK);
> =20
> -		while ((xntimerh_date(&timer->aplink) +=3D timer->interval) < now)
> -		    ;
> +		do {
> +			xntimerh_date(&timer->aplink) +=3D timer->interval;
> +		} while (xntimerh_date(&timer->aplink) < now + nkschedlat);
>  		xntimer_enqueue_aperiodic(timer);
>  	}
> =20

Unless I'm overseeing some pitfall right now: looks good! Would also
avoid the #if/#else stuff Philippe reluctantly proposed and I didn't
dared to come up with on my own. :)

Jan


--------------enig7ECE45DB9A882D210BA8B516
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFFmnUlniDOoMHTA+kRAkODAJ92MO8KovAyLEesetZ1r+INiw18dgCYjJeh
6aVDAW9Sxuv60wQ3Pdx1Sw==
=VCGF
-----END PGP SIGNATURE-----

--------------enig7ECE45DB9A882D210BA8B516--

