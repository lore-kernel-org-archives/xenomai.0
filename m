Message-ID: <459A6A88.8000803@domain.hid>
Date: Tue, 02 Jan 2007 15:22:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <459A31E3.40807@domain.hid> <1167744149.30347.2.camel@domain.hid>	
	<459A5E92.6030504@domain.hid> <1167745769.30347.6.camel@domain.hid>	
	<459A64A9.4060707@domain.hid> <1167747223.30347.10.camel@domain.hid>
In-Reply-To: <1167747223.30347.10.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0E99768EABDCA07BE3735FF6"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E99768EABDCA07BE3735FF6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2007-01-02 at 14:56 +0100, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> On Tue, 2007-01-02 at 14:30 +0100, Gilles Chanteperdrix wrote:
>>>
>>>> Philippe Gerum wrote:
>>>>
>>>>> On Tue, 2007-01-02 at 11:20 +0100, Jan Kiszka wrote:
>>>>>
>>>>>
>>>>>> Hi all - and happy new year,
>>>>>>
>>>>>> I haven't looked at all the new code yet, only the commit messages=
=2E I
>>>>>> found something similar to my fast-forward-on-timer-overrun patch =
in
>>>>>> #2010 and wondered if Gilles' original concerns on side effects fo=
r the
>>>>>> POSIX skin were addressed [1]. I recalled that my own final summar=
y on
>>>>>> this was "leave it as it is" [2].
>>>>>>
>>>>>
>>>>> The best approach is to update the POSIX skin so that it does not r=
ely
>>>>> on the timer code to act in a sub-optimal way; that's why this patc=
h
>>>>> found its way in. Scheduling and processing timer shots uselessly i=
s a
>>>>> bug, not a feature in this case.
>>>> There is some work to be done on the posix skin anyway, this will al=
l be
>>>> at once. By the way, I tested the trunk on ARM, and I still get a lo=
ckup
>>>> when the latency period is too low. I wonder if we should not compar=
e to
>>>> "now + nkschedlat", or even use xnarch_get_cpu_tsc() instead of "now=
".
>>>
>>> You mean as below, in order to account for the time spent in the hand=
ler(s)?=09
>>>
>>> -	while ((xntimerh_date(&timer->aplink) +=3D timer->interval) < now)
>>> +	while ((xntimerh_date(&timer->aplink) +=3D timer->interval) < xnarc=
h_get_cpu_tsc())
>>> 		    ;
>>>
>> I mean even:
>>
>> 	while ((xntimerh_date(&timer->aplink) +=3D timer->interval) <
>> 		xnarch_get_cpu_tsc() + nkschedlat)
>>                  ;
>>
>> Because if the timer date is between now and now + nkschedlat, its
>> handler will be called again.
>>
>=20
> Ack.
>=20

Keep in mind that this code is now a performance regression for the
non-overflow case, specifically when xnarch_get_cpu_tsc() costs more
than just a simple CPU register access.

My previous "leave it as it is" was also due to the consideration that
we shouldn't pay too much in hotpaths for things that go wrong on
misdesigned systems.

Jan


--------------enig0E99768EABDCA07BE3735FF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFmmqIniDOoMHTA+kRAgDvAJ4xiJvzWz3GYViwT1xE1AFeTs/mqgCfd92n
B6q5RQWpPjaToJpDiu4Z0Ik=
=qyBL
-----END PGP SIGNATURE-----

--------------enig0E99768EABDCA07BE3735FF6--

