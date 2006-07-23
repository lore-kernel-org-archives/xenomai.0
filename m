Message-ID: <44C3E17C.2050906@domain.hid>
Date: Sun, 23 Jul 2006 22:52:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] x86 TSC emulation broken
References: <44C3B1DB.2040807@domain.hid> <1153686507.8053.9.camel@domain.hid>
In-Reply-To: <1153686507.8053.9.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9ED1CE47FE25C1E7F111EBE0"
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
--------------enig9ED1CE47FE25C1E7F111EBE0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2006-07-23 at 19:28 +0200, Jan Kiszka wrote:
>> Hi,
>>
>> I happened to switch on some CPU type that enabled the Xenomai's TSC
>> emulation code. The result was an ugly lock-up: endless loop in the
>> timer IRQ handler.
>>
>> The reason: the TSC emulation collides with the VT sound output / the =
PC
>> speaker driver. Over 2.6, one can easily avoid this my switching off
>> CONFIG_INPUT_PCSPKR. 2.4 requires to export and than manipulate
>> kb_mksound (the pointer to the sound gen*
>> erating code).
>=20
> There is an issue in the Adeos 2.4 patch (1.2-05) which is not
> preventing the kernel from poking into the 8254 registers to determine
> the current time offset.

But the TSC emulation itself is not an Adeos service. Shouldn't it be
better moved? Then I would happily leave it up to you. :)

>=20
>> The latter pointer rang some bell. I once fixed a broken RTAI build du=
e
>> to that code. So I pulled out vulcano and actually found the related
>> code + an extension of the original ipipe patch to export kb_mksound. =
I
>> guess it would have been too complicated for Paolo to explain the reas=
on
>> of this export to us...
>>
>> Anyway, this digging revealed another potential breakage in the
>> emulation code: RTAI takes care to read the emulated TSC at least once=

>> per 50 ms, to avoid overflows I assume. Xenomai does not.
>=20
> Mm, through the host timer service, it should at least each 10ms period=
=2E

Yeah, true. I probably got blinded by the existing RTAI code. There is
just the likely theoretical case that there is no host tick (LAPIC +
emulated TSC? Not configurable, is it?).

Jan


--------------enig9ED1CE47FE25C1E7F111EBE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEw+GAniDOoMHTA+kRAncYAJ9EgEVGGAbXflBWQadviVD57RUmugCeLKSp
YwlqUWcHWiX0fZI3S2jnLgk=
=2nyL
-----END PGP SIGNATURE-----

--------------enig9ED1CE47FE25C1E7F111EBE0--

