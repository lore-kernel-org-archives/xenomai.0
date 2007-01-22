Message-ID: <45B4C4FF.1070501@domain.hid>
Date: Mon, 22 Jan 2007 15:06:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PPC405: DMA-problem solved!
References: <200701172333.25574.niklaus.giger@domain.hid>	<45AF306E.4070606@domain.hid>
	<200701200006.45387.niklaus.giger@domain.hid>
	<45B1CD21.1090307@domain.hid> <45B3DD0A.3010303@domain.hid>
In-Reply-To: <45B3DD0A.3010303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF9FA1DB49CCBBBE238C1B989"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF9FA1DB49CCBBBE238C1B989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
>> In any case, we need to resolve the arch dependency somehow. I guess
>> it will  currently not fly when I kick the full build in examples/ for=
 a
>> non-PPC platform. Any *simple* way to catch this? Would also be
>> applicable to the heartbeat-x86 example then, though this will not cau=
se
>> build troubles.
>=20
> The only simple way I see is referencing the configured kernel tree.

Sourcing $KSRC/.config into the makefile and evaluating the ARCH? Would
save us from passing ARCH on make invocation...

=2E..
>>> +    int res =3D 0;
>>> +    memset((char *)&p_init, sizeof(p_init), 0);
>>> +    p_init.polarity =3D 0;
>>> +    p_init.pwidth   =3D PW_8;
>>> +     res =3D ppc4xx_init_dma_channel(DMA_NR, &p_init);
>>> +    if (res) {
>>> +        printk("%32s: nit_dma_channel return %d %d bytes dest %p\n",=

>>> +            __FUNCTION__, res, length, dst);
>>> +    }
>>> +    res =3D ppc4xx_clr_dma_status(DMA_NR);
>>> +    if (res) { +        printk("%32s: ppc4xx_clr_dma_status %d\n",
>>> __FUNCTION__, res);
>>> +    }
>>> +#warning flush_dcache_all is a performance killer, but I do not know=

>>> at the +#warning moment how to flush only the parts needed
>>
>> Can we resolve this? Wolfgang?
>=20
> flush_dcache_range should do the job. Or even better use the DMA-API
> described in Documentation/DMA-API.txt to get DMA'able memory (as
> pointed out recently on the linuxppc-emmbedded ML).

I definitely prefer to have a tested variant here that is as little
invasive as possible. This is "educational" code, so we should not
spread suboptimal patterns.

>>> +    if (rtdm_irq_free (&irq_handle)) {
>>> +        printk("%32s: rtdm_irq_free failed\n",__FUNCTION__);
>>> +    }
>>> +    show_irq(irq);
>>> +}
>=20
> And should we not also use rtdm_prinkt()?

Not strictly required here, we are in non-rt context.

Jan


--------------enigF9FA1DB49CCBBBE238C1B989
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFtMT/niDOoMHTA+kRAmWUAJ0Tkfob+JNhiJkKCPx+k8UUT/C2AACfRKUi
3cvqJLoONHXckGfdtSdGjoI=
=Uq0N
-----END PGP SIGNATURE-----

--------------enigF9FA1DB49CCBBBE238C1B989--

