Message-ID: <43DDE693.2070702@domain.hid>
Date: Mon, 30 Jan 2006 11:12:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Missing IRQ end function on PowerPC
References: <200601300833.k0U8XtG31144@domain.hid>	<43DDDA6A.3080907@domain.hid>
	<43DDE344.1000900@domain.hid>
In-Reply-To: <43DDE344.1000900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B504F5E43CB3BC4CC39111D"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B504F5E43CB3BC4CC39111D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>
>>>> This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
>>>>
>>>> Philippe Gerum wrote:
>>>>
>>>>> Gilles Chanteperdrix wrote:
>>>>>
>>>>>> Wolfgang Grandegger wrote:
>>>>>> > Therefore we need a dedicated function to re-enable interrupts i=
n
>>>>>> the  > ISR. We could name it *_end_irq, but maybe *_enable_isr_irq=
 is
>>>>>> more  > obvious. On non-PPC archs it would translate to *_irq_enab=
le.
>>>>>> I  > realized, that *_irq_enable is used in various place/skins an=
d
>>>>>> therefore  > I have not yet provided a patch.
>>>>>>
>>>>>> The function xnarch_irq_enable seems to be called in only two
>>>
>>> functions,
>>>
>>>>>> xintr_enable and xnintr_irq_handler when the flag XN_ISR_ENABLE is=

>>>>>> set.
>>>>>>
>>>>>> In any case, since I am not sure if this has to be done at the Ade=
os
>>>>>> level or in Xenomai, we will wait for Philippe to come back and
>>>>>> decide.
>>>>>>
>>>>>
>>>>> ->enable() and ->end() all mixed up illustrates a silly x86 bias I
>>>>> once
>>>>> had. We do need to differentiate the mere enabling from the IRQ
>>>>> epilogue
>>>>> at PIC level since Linux does it - i.e. we don't want to change the=

>>>>> semantics here.
>>>>>
>>>>> I would go for adding xnarch_end_irq -> rthal_irq_end to stick with=

>>>>> the
>>>>> Linux naming scheme, and have the proper epilogue done from there o=
n a
>>>>> per-arch basis.
>>>>>
>>>>> Current uses of xnarch_enable_irq() should be reserved to the
>>>>> non-epilogue case, like xnintr_enable() i.e. forcibly unmasking the=

>>>>> IRQ
>>>>> source at PIC level outside of any ISR context for such interrupt (=
*).
>>>>> XN_ISR_ENABLE would trigger a call to xnarch_end_irq, instead of
>>>>> xnarch_enable_irq. I see no reason for this fix to leak to the Adeo=
s
>>>>> layer, since the HAL already controls the way interrupts are ended
>>>>> actually; it just does it improperly on some platforms.
>>>>>
>>>>> (*) Jan, does rtdm_irq_enable() have the same meaning, or is it
>>>>> intended
>>>>> to be used from the ISR too in order to revalidate the source at PI=
C
>>>
>>> level?
>>>
>>>> Nope, rtdm_irq_enable() was never intended to re-enable an IRQ line
>>>> after an interrupt, and the documentation does not suggest this eith=
er.
>>>> I see no problem here.
>>>
>>> But RTDM needs a rtdm_irq_end() functions as well in case the
>>> user wants to reenable the interrupt outside the ISR, I think.
>>
>>
>> If this is a valid use-case, it should be really straightforward to ad=
d
>> this abstraction to RTDM. We should just document that rtdm_irq_end()
>> shall not be invoked from IRQ context -
>=20
> It's the other way around: ->end() would indeed be called from the ISR
> epilogue, and ->enable() would not.

I think we are talking about different things: Wolfgang was asking for
an equivalent of RTDM_IRQ_ENABLE outside the IRQ handler. That's the
user API. You are now referring to the back-end which had to provide
some end-mechanism to be used both by the nucleus' ISR epilogue and that
rtdm_irq_end(), and that mechanism shall be told apart from the IRQ
enable/disable API. Well, that's at least how I think to have got it...

>=20
>  to avoid breaking the chain in
>> the shared-IRQ scenario. RTDM_IRQ_ENABLE must remain the way to
>> re-enable the line from the handler.
>>
>> Jan
>>
>>
>=20
>=20

Jan


--------------enig8B504F5E43CB3BC4CC39111D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3eaUniDOoMHTA+kRAgvRAJ4vBMeGWF7BcNXPf2xhamKYlbHktgCeLSh1
ck9rOO7kmj79tabW8i9VwEY=
=yydl
-----END PGP SIGNATURE-----

--------------enig8B504F5E43CB3BC4CC39111D--

