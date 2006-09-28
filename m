Message-ID: <451BA49D.2030303@domain.hid>
Date: Thu, 28 Sep 2006 12:31:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
References: <451786B3.4020506@domain.hid> <1159434450.4949.7.camel@domain.hid>	
	<451B92C8.9050802@domain.hid> <1159434997.4949.9.camel@domain.hid>	
	<451B949B.4090602@domain.hid> <1159438034.4949.25.camel@domain.hid>
In-Reply-To: <1159438034.4949.25.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig61B8AAA146E9B8D3DCE4D2A7"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61B8AAA146E9B8D3DCE4D2A7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2006-09-28 at 11:23 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2006-09-28 at 11:15 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Mon, 2006-09-25 at 09:35 +0200, Jan Kiszka wrote:
>>>>>
>>>>> This one won't work. We need to forcibly re-enable the hw IRQs upon=
 root
>>>>> unstall requests, regardless of the fact that interrupts are pendin=
g in
>>>>> the log; some code rely on this. E.g. Adeos/ppc over 2.4 would rema=
in
>>>>> stuck in the delay calibration routine, but there are other more tr=
icky
>>>>> places where this would bite too.
>>>> But this would be ok?
>>>>
>>>> #else  /* !CONFIG_SMP */
>>>>         __clear_bit(IPIPE_STALL_FLAG,
>>>>                     &ipipe_root_domain->cpudata[cpuid].status);
>>>>
>>>>        if (unlikely(ipipe_root_domain->cpudata[cpuid].irq_pending_hi=
 !=3D
>>>>            0)) {
>>>>                local_irq_disable_hw();
>>>>                __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
>>>>        }
>>>>        local_irq_enable_hw();
>>>> #endif /* CONFIG_SMP */
>>>>
>>>> So we can still save one disable IRQ in the fastpath.
>>>>
>>> But in such a case, you would have to use clear_bit() to keep atomici=
ty.
>> This is for UP, not SMP.
>>
>=20
> This is not a UP vs SMP issue, the stall bit is strictly CPU local
> anyway. The issue is that some archs do _not_ have intrinsically atomic=

> bitops; they need to emulate them by masking interrupts around the bit
> setting operation. Using __clear_bit() in this context would make this
> code preemptible by an interrupt in the middle of the bitop. Disabling
> hw IRQs on entry allows us to use non-atomic bitops.

Yeah, I meanwhile realised my x86-restricted view as well. :)

Does it still make sense then to optimise like I proposed?


--------------enig61B8AAA146E9B8D3DCE4D2A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFG6SdniDOoMHTA+kRAgpBAJ9htY/RJOidOXljTalYpioYJuvuUgCfXue3
MUICXGPCKGSgFEC3I4T+B1M=
=nPCX
-----END PGP SIGNATURE-----

--------------enig61B8AAA146E9B8D3DCE4D2A7--

