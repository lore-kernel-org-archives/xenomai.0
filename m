Message-ID: <43E323CC.4040306@domain.hid>
Date: Fri, 03 Feb 2006 10:35:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] some results on my laptop
References: <43E288AA.3050203@domain.hid>	<43E28EE8.3020103@domain.hid>	<43E2A31D.9000807@domain.hid>	<43E30B8D.6030507@domain.hid>
	<43E31186.1000007@domain.hid> <43E31EE0.8020808@domain.hid>
In-Reply-To: <43E31EE0.8020808@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9F45F1BFD25218A64C976E72"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9F45F1BFD25218A64C976E72
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> Jan Kiszka wrote:
>> ...and may also add further latencies with the system has to speed up
>> again. Anyway, there might be use-cases where power consumption is -
>> besides latency - also an important issue. I'm just thinking of our
>> smaller mobile robots where the power demand of the drives and the
>> controller are not that far apart as on the larger platforms.
>>
>> What about other time sources on x86? Which systems already have HPET
>> these days, and does this source not suffer from frequency scaling? I
>> once read that HPET is quite easy to program, is this true? IOW, would=

>> it be worth considering to add this to the HAL?
> If it an computer with ACPI (which is very likely), one could use the P=
M
> Timer (3.579545 MHz) as the base system clock, and sync with TSC at
> every clockscaling and power events (the reason for that is that PM
> Timer reads  are quite slow (around 1 microsecond on the hardwares I
> have tested), so most timer stuff should go via TSC).
>=20
> The advantage with this is that the system will keep accurate time even=

> in the low power modes (when TSC is turned off). I have done a crude
> implementation of this on KURT (http://www.ittc.ku.edu/kurt/), and it i=
s
> a workable solution

Oh, KURT still exists? Appeared a bit unmaintained to me last time I
checked.

>=20
> There are also good research/development oppurtunities in:
>=20
>   1. scheduling ACPI wakeup from those low-power modes in such good
>      time that all realtime requirements are met :-)
>   2. scheduling of clockscaling changes to make minimum impact
>      on realtime tasks
>=20
> (For ACPI, see http://www.acpi.info/DOWNLOADS/ACPIspec30a.pdf)
>=20

Hmm, though likely feasible, this sounds like it requires some effort,
especially the infrastructure to access ACPI directly (I guess we would
still have to switch it off for Linux, wouldn't we?) and to set up the
power event hooks. How much code was involved in your KURT add-on? Can
you extract it as a patch to asses the required work? I'm not planing to
work on this, but if it is not too complicated, someone may once pick it
up and integrate it in Xenomai.

Jan


--------------enig9F45F1BFD25218A64C976E72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4yPMniDOoMHTA+kRAoeEAJ9c4FXJ4QPgkCgqfhDNAoZD+0Uy+ACeItYn
/1VkhwIavqG40oYU+9FY6j8=
=Z9Ma
-----END PGP SIGNATURE-----

--------------enig9F45F1BFD25218A64C976E72--

