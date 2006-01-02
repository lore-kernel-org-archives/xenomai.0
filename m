Message-ID: <43B972E7.7070700@domain.hid>
Date: Mon, 02 Jan 2006 19:37:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCHES] various fixes
References: <43B92C73.6080004@domain.hid> <43B9711A.1070609@domain.hid>
In-Reply-To: <43B9711A.1070609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E0645EAC45C2BF26424C895"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E0645EAC45C2BF26424C895
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> 
>>  * maxlat_proc.patch - export NMI watchdog threshold via /proc, trigger
>>    trace freezing instead of die_nmi() if CONFIG_IPIPE_TRACE is enabled
> 
> 
> Merged.

Gilles pointed out that ipipe_trace_freeze() is not NMI-save. After
sorting my private patch chaos, I'm going to work on this.

There is also already a fix+update for the latency benchmark pending.
This will be next. Puh!

Jan

--------------enig3E0645EAC45C2BF26424C895
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDuXLnniDOoMHTA+kRAgITAJ9GgrzGsSZUx3PCChwDDy2QAyM8fQCfZRTy
RFABZZ8fnvqEu5j9/gPFP6s=
=6J7F
-----END PGP SIGNATURE-----

--------------enig3E0645EAC45C2BF26424C895--

