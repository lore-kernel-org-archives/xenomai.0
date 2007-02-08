Message-ID: <45CAEB8C.40000@domain.hid>
Date: Thu, 08 Feb 2007 10:21:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45CAE190.6020404@domain.hid> <1170926285.20614.7.camel@domain.hid>
In-Reply-To: <1170926285.20614.7.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig55646BEA220E82AD042D1852"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Fixed two timer base regressions
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
--------------enig55646BEA220E82AD042D1852
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-02-08 at 09:38 +0100, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> the "trivial" bugs are fixed already: see #2152 for the reason why
>> rt_dev_read timeouts took too long (the timer mode was ignored by
>> xnsynch_sleep_on),
>=20
> Ok.
>=20
>>  and I also found a yet invisible bug in
>> rtdm_toseq_init that would have picked the wrong time base (#2153).
>>
>=20
> Using xnpod_current_thread()'s time base in rtdm_toseq_init() will
> always pick the master one when called over a secondary mode context,
> which according to the doc, is allowed. Is this intended?

rtdm_toseq_init will only be called over primary context, it belongs
into the same context as rtdm_mutex_timedlock, rtdm_sem_timeddown, etc.


--------------enig55646BEA220E82AD042D1852
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFyuuNniDOoMHTA+kRArTqAJ4mioR3RfZtAjzzmz55NSrf0Gg5FQCdGuT+
b3BZcBpu2Qg9m3kw1SghsyY=
=liWW
-----END PGP SIGNATURE-----

--------------enig55646BEA220E82AD042D1852--

