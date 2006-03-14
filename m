Message-ID: <4416666B.5040201@domain.hid>
Date: Tue, 14 Mar 2006 07:44:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>
	<200603131631.26195.lbocseg@domain.hid> <4415FAC5.7050608@domain.hid>
	<200603132236.12791.lbocseg@domain.hid>
In-Reply-To: <200603132236.12791.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D5B24E4A9CF5910A05418A4"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D5B24E4A9CF5910A05418A4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Segunda 13 Mar=E7o 2006 20:05, Jan Kiszka escreveu:
>> ...
>>>> We would definitely need a good name for it,
>>>> rtdm_clock_read_ex(<clock-id>), rtdm_clock_read_tsc(),
>>>> rtdm_clock_read_monotonic()? I'm not going to break rtdm_clock_read(=
) by
>>>> adding an argument (otherwise, I would have to fix too many drivers =
on
>>>> my own... :-/).
>>> That is the idea, I think. I agree that rtdm_clock_read() should be k=
ept
>>> as it is (the API/definition). No body is asking you to change it. Ad=
ding
>>> rtdm_clock_read_tsc() would be sufficient in my opinion whilst it mai=
ntain
>>> coherency with other skins.
>> Thinking about this more thoroughly, a few questions popped up for me:=

>>
>> o When we call it rtdm_clock_read_tsc(), we should actually return the=

>>  raw TSC values, shouln't we? But then we also need conversion
>>  functions (rtdm_clock_tsc2ns, rtdm_clock_ns2tsc). Or should we always=

>>  convert to nanoseconds on return? POSIX and Native are different in
>>  this regard.
>=20
> I would prefer returning always ns, but both solutions would fit my nee=
ds, so=20
> I'm not really worried about this topic.
>=20
>> o What would be the core rationale behind it, having a high-resolution=

>>  time stamp? What are the primary use cases? I'm asking for this so
>>  that I can clearly differentiate between this new service and the
>>  existing one in the docs. Also, giving an abstract description would
>>  leave more options to the actual implementation on other archs or
>>  platforms.
>=20
> As I've said, I think that it is good to give some independency to the =
driver,=20
> at least to the time related functions, for not depending on the user c=
hosen=20
> timer behaviour for some delay routines. Eg, I would like to wait a spe=
cified=20
> amount of us before testing some register. That is a quite normal task =
when=20

This is what rtdm_task_busy_sleep() already provides - independent of
the system timer.

> developing drivers. Another one is for timeouts on short delays. In tho=
se=20
> cases, we want a good resolution, but this should be independent of the=
=20
> user's timer choice IMO.

And this is something rtdm_clock_read_tsc() will obviously not be for.

Again, when the user / system administrator decided to lower the timer
resolution in favour of performance, it is not possible (and doesn't
make sense) to circumvent this decision at driver level (except for busy
waiting). So, I wonder what you plan to do with the return value of the
new function?

Jan


--------------enig2D5B24E4A9CF5910A05418A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFmZrniDOoMHTA+kRAhlyAJ9L/5WwAArpWeEbaN5M5JMdJ8RhugCePJ3x
rRONBvqaDPfVqTTdDUSCTEM=
=oPAf
-----END PGP SIGNATURE-----

--------------enig2D5B24E4A9CF5910A05418A4--

