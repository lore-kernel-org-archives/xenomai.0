Message-ID: <471A500F.3000503@domain.hid>
Date: Sat, 20 Oct 2007 20:59:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1192641492.5973.67.camel@domain.hid> <4719DFD8.3030402@domain.hid>
	<471A1DF3.3060507@domain.hid>
In-Reply-To: <471A1DF3.3060507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF134F8B062502691C4DF2F5F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai/Blackfin upgrade
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF134F8B062502691C4DF2F5F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Our Blackfin port has just been upgraded to the latest 2.6.23. The ot=
her
>>> good news is that we have now rebased this work over mainline kernels=
=2E
>>> The I-pipe patch below is an all-in-one, supporting the bf533, bf537 =
and
>>> bf561 dual core boards. Any Xenomai version from 2.3.2 and on can be
>>> used (albeit pre 2.4-rc4 will require to fix the default calibration
>>> value by hand for the bf561).
>>>
>>> If you happen to have any of these boards at hand, and really don't k=
now
>>> how to spend geek time these days, please give this a try and send so=
me
>>> feedback.
>>>
>>> http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-2.6.2=
3-bf5xx-1.7-00.patch
>>>
>> Unfortunately, ipipe for bfin is still borken: my setup is 2.6.23.1 +
>> "uclinux mtd maps: add blackfin maps" + the ipipe patch above on a BF5=
37
>> stamp. I'm running the cache calibrator over the serial console and a
>> hello world shell loop over telnet. When ipipe is enabled (no Xenomai)=

>> and the calibrator is in its measurement cycle, the telnet connection
>> stalls. Actually, it seems the whole Linux scheduling stalls, because
>> when I turn this into a background loop, it doesn't make progress when=

>> the calibrator runs. All this does not happen when I disable ipipe in
>> the config.
>>
>=20
> Does the bug disappear with the patch below? (this is obviously not a
> fix since latency would skyrocket with this patch in, only a way to
> confirm that threading the timer IRQ causes the stall as we already
> observed a while ago with earlier versions).
>=20
> --- a/arch/blackfin/kernel/ipipe.c
> +++ b/arch/blackfin/kernel/ipipe.c
> @@ -388,7 +388,7 @@ static void kick_irqd(unsigned irq, void *cookie)
>=20
>  int ipipe_start_irq_thread(unsigned irq, struct irq_desc *desc)
>  {
> -	if (desc->thread || !create_irq_threads)
> +	if (desc->thread || !create_irq_threads || irq =3D=3D IRQ_SYSTMR)
>  		return 0;
>=20
>  	if (desc->ipipe_demux !=3D NULL)
>=20

Yep, this "solves" the problem here.

Jan


--------------enigF134F8B062502691C4DF2F5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHGlAPniDOoMHTA+kRAixwAJ93HckRv3zidk63Pv6ZgwYwiIetLQCfT6gS
sKR/LlAXUIuchyQ9avA+R+M=
=rtqa
-----END PGP SIGNATURE-----

--------------enigF134F8B062502691C4DF2F5F--

