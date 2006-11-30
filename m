Message-ID: <456EDA4B.3060809@domain.hid>
Date: Thu, 30 Nov 2006 14:19:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<4566C5AF.7030107@domain.hid>	<20061124113009.08c0a490.benjamin.zores@domain.hid>	<4569E699.6050003@domain.hid>	<20061127092143.e633cd91.benjamin.zores@domain.hid>	<456ACA35.8030206@domain.hid>	<20061127125419.3852edd9.benjamin.zores@domain.hid>	<456AD5EB.5040901@domain.hid>
	<20061130133745.272ab4b1.benjamin.zores@domain.hid>
In-Reply-To: <20061130133745.272ab4b1.benjamin.zores@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7D31ECA08AADCB4EDDDA134C"
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
To: Benjamin Zores <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D31ECA08AADCB4EDDDA134C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Benjamin Zores wrote:
> On Mon, 27 Nov 2006 13:11:23 +0100
> Wolfgang Grandegger <wg@domain.hid> wrote:
>=20
>> Benjamin Zores wrote:
>>> On Mon, 27 Nov 2006 12:21:25 +0100
>>> Wolfgang Grandegger <wg@domain.hid> wrote:
>>>
>>>>> Well, I hack a bit my patch to make it compile and the kernel alrea=
dy booted.
>>>>> Though it hangs when loading the SATA driver.
>>>>> I have no idea why atm.
>>>> Problems with IRQs?
>>> Probably, as when unplugging the SATA drive, the boot goes further
>>> but then hang at USB detection (both are handlign IRQs a lot i guess)=
=2E
>>> Would be interesting if someone could test on other board than just m=
ine.
>> As I pointed out in my previous mail, the IRQ handling is not yet=20
>> correct for powerpc. Try to correct his first.
>=20
> The 2.6.19 having been released out, and working much better on my card=

> than the vanilla 2.6.18 used to be, I'm now more kind to adapt my patch=
 to
> this latest kernel.
>=20
> However the IRQ handling API seem to have changed a lot
> and i was wondering if some work on porting Adeos
> (x86/ppc, not yet powerpc of course) patches already have been started
> by someone here ?

I don't see that PPC is converted to genirq, that new API. And I'm not
sure (while not being a PPC expert) if it ever will be, specifically as
PowerPC is already on genirq and should obsolete PPC one day, right?

Anyway, there is an unreleased work-in-progress patch for x86 over -rc6
by Philippe. I recently had the chance to test it and hack a bit on the
SMP IO-APIC part. It seems to work fine under UP, but SMP had some
issues that are identified, but still need to be addressed - thanks to
genirq, now in a widely arch-independent way.

Philippe, I know you are very busy, but shouldn't we make a pre-release
available already, also to discuss further how to deal best with genirq
on other platforms beyond x86?

Jan


--------------enig7D31ECA08AADCB4EDDDA134C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbtpLniDOoMHTA+kRAlp0AJ0WHuPp+6ayT+WpgX1Z/q+Qsl6zPgCfRN6p
S3FlRXfelKTt4cxZtZMOdkY=
=c0ge
-----END PGP SIGNATURE-----

--------------enig7D31ECA08AADCB4EDDDA134C--

