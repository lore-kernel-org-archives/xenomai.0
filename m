Message-ID: <463F178D.4020805@domain.hid>
Date: Mon, 07 May 2007 14:11:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>
	<463AE79E.2090901@domain.hid>
	<1178281926.29093.93.camel@domain.hid> <463B2A69.7080704@domain.hid>
	<463EE376.9030702@domain.hid> <463EEA4A.1070405@domain.hid>
	<463F1468.8010403@domain.hid>
In-Reply-To: <463F1468.8010403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD000EFC8B7D04861B5DCD1D8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD000EFC8B7D04861B5DCD1D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johan Borkhuis wrote:
> Jan Kiszka wrote:
>> I don't see anything suspicious right now, so please consider capturin=
g
>> a trace with the latency as I suggested. That should give a full pictu=
re
>> of what is happening when latency detects that huge delay.
>>
>> Jan
> To get the tracing to work I had to set CONFIG_IPIPE_TRACE_VMALLOC, as
> my system did not boot when this was not set. I also set

Yep, that's "normal" on small system (and might be better documented
somewhere, suggestions welcome).

> CONFIG_IPIPE_TRACE_SHIFT to 16. I attached the logfile of a latency
> session.

You are now seeing a latency of 1800 us, but you trace only lasts back a
few ten us. Please extend it (back_trace_points) to cover the full
range. We see some ugly priority inversion, we now need to find the
point where this started.

Jan


PS: I personally might not be able to answer following posts until
Wednesday, just to inform you.


--------------enigD000EFC8B7D04861B5DCD1D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGPxeNniDOoMHTA+kRAlOJAJ9zDzPpDEFcdBDKxMrZNsZy4ZpYGwCfb53C
Tv5fAhgVuVwJ7gQcFhrjhX8=
=VGx0
-----END PGP SIGNATURE-----

--------------enigD000EFC8B7D04861B5DCD1D8--

