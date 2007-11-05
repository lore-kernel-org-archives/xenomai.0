Message-ID: <472ED274.9070205@domain.hid>
Date: Mon, 05 Nov 2007 09:21:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4717D8AC.8000900@domain.hid>	<FDBBB5CC70676540B3EF7CFE83FD94E0999445@domain.hid>	<4718670D.6000008@domain.hid>
	<472ED13D.4050703@domain.hid>
In-Reply-To: <472ED13D.4050703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA47869765EB4E027E415289D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] LTTng for Xenomai - next round
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA47869765EB4E027E415289D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> ...
>> Regarding the instrumentation: My latest Xenomai patch changed the
>> marker arguments even more away from your original patch. Not looking =
at
>> the plugin for this, I may have removed useful information. Please let=

>> us know what you would like to see in the trace points so that this pa=
rt
>> can quickly stabilise, maybe even go into the next Xenomai release.
>=20
> I decided to accelerate the core instrumentation as it looks like I wil=
l
> need it sooner than expected. So here comes another version of the
> Xenomai-part of the patch series, changing the following:
>=20
>  - Full conversion to trace_mark, no intermediate xnltt_log_event
>    anymore. Unsupported kernel versions are caught by the wrapping laye=
r
>    instead. Thus, also ltt.h is obsolete now (bootstrap run is required=

>    for user land).

Just realised: As usual, this patch nicely breaks the simulator (what is
trace_mark?). Will fix with the next submission later today or tomorrow.

Jan


--------------enigA47869765EB4E027E415289D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHLtJ0niDOoMHTA+kRAgppAJ9CV6IfNhQZjhdv2skEPcs1xR5aiACfW/DW
gwxbr6lD+W2Hn/OmAFiALeA=
=mC20
-----END PGP SIGNATURE-----

--------------enigA47869765EB4E027E415289D--

