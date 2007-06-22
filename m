Message-ID: <467BBF76.5040202@domain.hid>
Date: Fri, 22 Jun 2007 14:24:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46782305.4080501@domain.hid>	
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>	
	<4679A302.2060403@domain.hid>	
	<b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>	
	<467A42F6.8080706@domain.hid>	
	<b647ffbd0706210252o1074fa6aof00e82b5ba5a2509@domain.hid>	
	<467A7593.4040402@domain.hid>	
	<b647ffbd0706210614ib24568bq6f5bc149c2bbc423@domain.hid>	
	<467A7FCA.40708@domain.hid> <467BB833.1030401@domain.hid>
	<b647ffbd0706220517j693a736bk5cd3a46fc2635200@domain.hid>
In-Reply-To: <b647ffbd0706220517j693a736bk5cd3a46fc2635200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3731A49B76916AD36A24A38F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3731A49B76916AD36A24A38F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 22/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> [ ... ]
>>
>> Only compile-tested under various .configs. Any comment welcome.
>>
>=20
>> @@ -76,7 +102,7 @@ static inline void xnintr_stat_counter_d
>>  static void xnintr_irq_handler(unsigned irq, void *cookie)
>>  {
>>         xnsched_t *sched =3D xnpod_current_sched();
>> -       xnintr_t *intr =3D (xnintr_t *)cookie;
>> +       xnintr_t *intr;
>>         xnstat_runtime_t *prev;
>>         xnticks_t start;
>>         int s;
>> @@ -86,6 +112,16 @@ static void xnintr_irq_handler(unsigned
>>         xnltt_log_event(xeno_ev_ienter, irq);
>>
>>         ++sched->inesting;
>> +
>> +       xnlock_get(&xnirqs[irq].lock);
>> +
>> +#ifdef CONFIG_SMP
>> +       /* In SMP case, we have to reload the cookie under the per-IRQ=

>> lock
>> +          to avoid racing with xnintr_detach. */
>> +       intr =3D rthal_irq_cookie(&rthal_domain, irq);
>> +#else
>> +       intr =3D cookie;
>> +#endif
>>         s =3D intr->isr(intr);
>=20
> I guess, 'intr' can be NULL here.

Yeah, needs to be caught as well.

>=20
> Could you please send me attached (non-inlined) a combo patch on top
> of the trunk version (as I see this one seems to be on top of your
> previous one)? I'll try to come up with some solution during this
> weekend.

My patch was an attachment (though I wonder we everyone has so much
problems with inlines - broken mailers all over the place), and it was
already against trunk (#2654). Philippe merged my preliminary fix this
morning.

Looking forward to your suggestions!

Jan


--------------enig3731A49B76916AD36A24A38F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGe792niDOoMHTA+kRAm32AJ9rfSvUeN3BjSn2JCx0uAI0L2aM0wCaAvlL
AZQTnNnYKuSAt5F0Rg4yEvA=
=7Tl4
-----END PGP SIGNATURE-----

--------------enig3731A49B76916AD36A24A38F--

