Message-ID: <44169813.6020007@domain.hid>
Date: Tue, 14 Mar 2006 11:16:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>	<200603131431.35216.lbocseg@domain.hid>
	<4415BB0D.8070808@domain.hid>	<200603131631.26195.lbocseg@domain.hid>
	<4415FAC5.7050608@domain.hid> <44167BE9.2090703@domain.hid>
In-Reply-To: <44167BE9.2090703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA4E11D423276E3A531455103"
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4E11D423276E3A531455103
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> Jan Kiszka wrote:
>> ...
>> Thinking about this more thoroughly, a few questions popped up for me:=

>>
>> o When we call it rtdm_clock_read_tsc(), we should actually return the=

>>   raw TSC values, shouln't we? But then we also need conversion
>>   functions (rtdm_clock_tsc2ns, rtdm_clock_ns2tsc). Or should we alway=
s
>>   convert to nanoseconds on return? POSIX and Native are different in
>>   this regard.
>>
>> o What would be the core rationale behind it, having a high-resolution=

>>   time stamp? What are the primary use cases? I'm asking for this so
>>   that I can clearly differentiate between this new service and the
>>   existing one in the docs. Also, giving an abstract description would=

>>   leave more options to the actual implementation on other archs or
>>   platforms.
> If you implement it, don't forget to point out that the tsc may have
> increments varying over time (due to clock scaling), and might even sto=
p
> for long periods (ACPI sleep), just so we are not faced with a primitiv=
e
> that makes it impossible to implement low-power operation (not at the
> very top on my priority list, but still important).

Yeah, one reason why I'm hesitating ATM to introduce a too specific
service to RTDM. But I'm still open to being persuaded about its usefulne=
ss.

Jan



--------------enigA4E11D423276E3A531455103
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFpgUniDOoMHTA+kRAil4AJsHkAAJOVPlDZc5Jt0emgrtd5hJbACeNCzr
jwA/hK12eCkuZWHBIs1umIM=
=pj6r
-----END PGP SIGNATURE-----

--------------enigA4E11D423276E3A531455103--

