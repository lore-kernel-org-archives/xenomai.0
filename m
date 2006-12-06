Message-ID: <45769862.1060208@domain.hid>
Date: Wed, 06 Dec 2006 11:16:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid>
	<200612051934.14391.Sebastian.Smolorz@domain.hid>
	<4575BFBF.1080306@domain.hid> <E1Grrzu-0008JP-G8@domain.hid>
In-Reply-To: <E1Grrzu-0008JP-G8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig65668531C43A7754B39FF320"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig65668531C43A7754B39FF320
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> Jan Kiszka wrote:
>>>> Try if smaller CONFIG_IPIPE_TRACE_SHIFT makes it boot without
>>>> CONFIG_IPIPE_TRACE_VMALLOC.
>>> I already tried that but it didn't help. First with IPIPE_TRACE_SHIFT=
 set
>>> to 10 and after modifying Kconfig.debug with a value of 5. Booting
>>> impossible.
>> What about starting disabled and arming the tracer later via
>> /proc/ipipe/trace/enable? This sounds like it's not a size issue
>> (TRACE_SHIFT=3D5 is ridiculous small), rather some memory section is
>> accessed too early.
>=20
> It seems to be a combined problem. When the tracer is disabled at boot =
time,=20
> the system starts if IPIPE_TRACE_SHIFT < 14, but not if >=3D 14. With t=
he=20
> tracer enabled at boot time the IPIPE_TRACE_SHIFT value is not relevant=
, no=20
> boot at all.

Then would you mind moving the trace enabling point as I said and post a
patch? And if you have any idea for a characteristic CONFIG-switch that
should lower the default TRACE_SHIFT (CONFIG_EMBEDDED? Or per arch?),
you are welcome as well. TIA.

>=20
> But the freeze lasts again a long time (between 90-100). I wonder if th=
is is=20
> related to the ARM cache nature.

Hmm, maybe each piece of memory is affected by this lacy inclusion in
some process's page list...

Jan


--------------enig65668531C43A7754B39FF320
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdphiniDOoMHTA+kRAp0OAJ4udbFzzSoqNngSfkIMDIRn02djfQCfTBSL
TMAbMWV+SY6EJnpBFdT0iQA=
=U8pO
-----END PGP SIGNATURE-----

--------------enig65668531C43A7754B39FF320--

