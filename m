Message-ID: <43DDDA6A.3080907@domain.hid>
Date: Mon, 30 Jan 2006 10:20:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Missing IRQ end function on PowerPC
References: <200601300833.k0U8XtG31144@domain.hid>
In-Reply-To: <200601300833.k0U8XtG31144@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig75EA84B940A637279FCE2C3F"
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
--------------enig75EA84B940A637279FCE2C3F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
>=20
>> This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
>>
>> Philippe Gerum wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Wolfgang Grandegger wrote:
>>>>  > Therefore we need a dedicated function to re-enable interrupts in=

>>>> the  > ISR. We could name it *_end_irq, but maybe *_enable_isr_irq i=
s
>>>> more  > obvious. On non-PPC archs it would translate to *_irq_enable=
=2E
>>>> I  > realized, that *_irq_enable is used in various place/skins and
>>>> therefore  > I have not yet provided a patch.
>>>>
>>>> The function xnarch_irq_enable seems to be called in only two
> functions,
>>>> xintr_enable and xnintr_irq_handler when the flag XN_ISR_ENABLE is s=
et.
>>>>
>>>> In any case, since I am not sure if this has to be done at the Adeos=

>>>> level or in Xenomai, we will wait for Philippe to come back and deci=
de.
>>>>
>>> ->enable() and ->end() all mixed up illustrates a silly x86 bias I on=
ce
>>> had. We do need to differentiate the mere enabling from the IRQ epilo=
gue
>>> at PIC level since Linux does it - i.e. we don't want to change the
>>> semantics here.
>>>
>>> I would go for adding xnarch_end_irq -> rthal_irq_end to stick with t=
he
>>> Linux naming scheme, and have the proper epilogue done from there on =
a
>>> per-arch basis.
>>>
>>> Current uses of xnarch_enable_irq() should be reserved to the
>>> non-epilogue case, like xnintr_enable() i.e. forcibly unmasking the I=
RQ
>>> source at PIC level outside of any ISR context for such interrupt (*)=
=2E
>>> XN_ISR_ENABLE would trigger a call to xnarch_end_irq, instead of
>>> xnarch_enable_irq. I see no reason for this fix to leak to the Adeos
>>> layer, since the HAL already controls the way interrupts are ended
>>> actually; it just does it improperly on some platforms.
>>>
>>> (*) Jan, does rtdm_irq_enable() have the same meaning, or is it inten=
ded
>>> to be used from the ISR too in order to revalidate the source at PIC
> level?
>> Nope, rtdm_irq_enable() was never intended to re-enable an IRQ line
>> after an interrupt, and the documentation does not suggest this either=
=2E
>> I see no problem here.
>=20
> But RTDM needs a rtdm_irq_end() functions as well in case the
> user wants to reenable the interrupt outside the ISR, I think.

If this is a valid use-case, it should be really straightforward to add
this abstraction to RTDM. We should just document that rtdm_irq_end()
shall not be invoked from IRQ context - to avoid breaking the chain in
the shared-IRQ scenario. RTDM_IRQ_ENABLE must remain the way to
re-enable the line from the handler.

Jan



--------------enig75EA84B940A637279FCE2C3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3dpqniDOoMHTA+kRAvPEAJ9OXlZ4io2JlhaJd8UPK5mXn6WxTgCeNNKt
eBxvwCRKW6WxsRhsvrcOyUQ=
=gbpF
-----END PGP SIGNATURE-----

--------------enig75EA84B940A637279FCE2C3F--

