Message-ID: <451B949B.4090602@domain.hid>
Date: Thu, 28 Sep 2006 11:23:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
References: <451786B3.4020506@domain.hid> <1159434450.4949.7.camel@domain.hid>	
	<451B92C8.9050802@domain.hid> <1159434997.4949.9.camel@domain.hid>
In-Reply-To: <1159434997.4949.9.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig79125E8F11C874D0D8DA5ED8"
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
--------------enig79125E8F11C874D0D8DA5ED8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2006-09-28 at 11:15 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2006-09-25 at 09:35 +0200, Jan Kiszka wrote:
>>>
>>> This one won't work. We need to forcibly re-enable the hw IRQs upon r=
oot
>>> unstall requests, regardless of the fact that interrupts are pending =
in
>>> the log; some code rely on this. E.g. Adeos/ppc over 2.4 would remain=

>>> stuck in the delay calibration routine, but there are other more tric=
ky
>>> places where this would bite too.
>> But this would be ok?
>>
>> #else  /* !CONFIG_SMP */
>>         __clear_bit(IPIPE_STALL_FLAG,
>>                     &ipipe_root_domain->cpudata[cpuid].status);
>>
>>        if (unlikely(ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=
=3D
>>            0)) {
>>                local_irq_disable_hw();
>>                __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
>>        }
>>        local_irq_enable_hw();
>> #endif /* CONFIG_SMP */
>>
>> So we can still save one disable IRQ in the fastpath.
>>
>=20
> But in such a case, you would have to use clear_bit() to keep atomicity=
=2E

This is for UP, not SMP.

Jan


--------------enig79125E8F11C874D0D8DA5ED8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFG5SbniDOoMHTA+kRAh7UAJ9n51HGrvdesEv9nU5uFM/4cWF3NQCdGXlt
3m80tWKyfo7jHOye5y73TcE=
=tJ31
-----END PGP SIGNATURE-----

--------------enig79125E8F11C874D0D8DA5ED8--

