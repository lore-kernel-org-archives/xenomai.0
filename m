Message-ID: <45CAED00.3090409@domain.hid>
Date: Thu, 08 Feb 2007 10:27:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Fixed two timer base regressions
References: <45CAE190.6020404@domain.hid> <1170926285.20614.7.camel@domain.hid>
	<45CAEB8C.40000@domain.hid>
In-Reply-To: <45CAEB8C.40000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig001F0E8F8FB6BF58E1F6954D"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig001F0E8F8FB6BF58E1F6954D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Thu, 2007-02-08 at 09:38 +0100, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> the "trivial" bugs are fixed already: see #2152 for the reason why
>>> rt_dev_read timeouts took too long (the timer mode was ignored by
>>> xnsynch_sleep_on),
>> Ok.
>>
>>>  and I also found a yet invisible bug in
>>> rtdm_toseq_init that would have picked the wrong time base (#2153).
>>>
>> Using xnpod_current_thread()'s time base in rtdm_toseq_init() will
>> always pick the master one when called over a secondary mode context,
>> which according to the doc, is allowed. Is this intended?
>=20
> rtdm_toseq_init will only be called over primary context, it belongs
> into the same context as rtdm_mutex_timedlock, rtdm_sem_timeddown, etc.=

>=20

OK, got your point: you were referring to the rtdm_toseq_init doc which
talks about secondary mode usage - this needs fixing now (and never made
any sense :( ).

Jan


--------------enig001F0E8F8FB6BF58E1F6954D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFyu0AniDOoMHTA+kRAicXAJ9W7CsSsz9pVlRnoWNygyGaJXBh9gCeL36T
1a8GQqPNu8eNeRBTzC1L+QE=
=RzZm
-----END PGP SIGNATURE-----

--------------enig001F0E8F8FB6BF58E1F6954D--

