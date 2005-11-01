Message-ID: <436759F9.1070101@domain.hid>
Date: Tue, 01 Nov 2005 13:05:13 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>	<43663262.80303@domain.hid>
	<200510312121.14160.dmitry.adamushko@domain.hid>
	<43675853.1000209@domain.hid>
In-Reply-To: <43675853.1000209@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig952AEECF904B910BA8E566EA"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig952AEECF904B910BA8E566EA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Dmitry Adamushko wrote:
>> On Monday 31 October 2005 16:04, you wrote:
>>
>>> Dmitry Adamushko wrote:
>>>
>>>> It seems to me now, that some parts of the hal will be involved
>>>> (rthal_irq_request/release()) since the nucleus itself doesn't keep
>>>> track
>>>> of registered irqs.
>>>
>>> That's true. And it also raises another question to me: why do we hav=
e
>>> those two different IRQ models?
>>>
>>> The HAL only one handler per IRQ which get called with the triggering=

>>> IRQ number. That handler will call the nucleus with an attached cooki=
e.
>>> And on the other side is the nucleus which works with a xnintr_t per
>>> IRQ. The xnintr_irq_handler() deals with things like re-enabling IRQs=
,
>>> rescheduling, etc.
>>>
>>> I'm asking as this abstraction adds one trampoline call (at HAL level=
),
>>> thus may lead to more I-cache misses. Isn't it worth considering some=

>>> HAL mechanisms based on more #defines and static inlines in this rega=
rd?
>>
>>
>> Let's take a look at what we have got currently:
>>
>> [1]     ipipe_domain::irqs[IPIPE_NR_IRQS]    [ADEOS-IPIPE]
>>
>> the handler is defined as void (*handler)(unsigned irq);
>>
>> in our case, this is rthal_irq_trampoline() [2] , but can be different=

>> for some other cases;
>>
>> [2]     rthal_irq_trampoline()                [HAL]
>>
>> struct rthal_realtime_irq[IPIPE_NR_IRQS]
>>
>> the handler is defined as void (*handler)(unsigned irq, void *cookie);=

>>
>> this one normally does a simple thing, just calls xnintr_irq_handler()=

>> [3] as you have mentioned before.
>>
>> [3]     xnintr_irq_handler()                [nucleus]
>> =20
>> this routine calls a certain user's ISR as well as handles some
>> nucleus-specific chores (re-scheduling, etc.)
>>
>> [4]    user's ISR                        [user driver]
>>
>> does user-specific things
>>
>> Well, [3] is necessary anyway since some nucleus-related chores must
>> be done and this is a correct layer for that (e.g. [2] knows nothing
>> about scheduling).
>>
>> What can be theoretically merged is [1] + [2] (errr... I said
>> theoretically, it's still not the case to kill me for just having said=

>> that :o). To this end, ipipe_domain should be extended in order to
>> contain all the fields of [2]::struct rthal_realtime_irq (at least,
>> handler(irq, cookie) + cookie).
>> btw, ipipe_domain::irqs may even contain a pointer to the slightly
>> modified
>=20
> This would mean changing a core Adeos prototype, though.
>=20
> xnintr_t structure (which is really e.g. a circular list) that may be
> passed
>> as "cockie" to the xnintr_irq_handler().
>>
>> The analogy is irq_desc_t vs. irqaction structures in Linux.
>>
>> This way, xnintr_irq_handler() can be called from adeos-ipipe layer
>> directly without the [2] layer.
>>
>> But that change looks quite invasive to me so far since
>> ipipe_domain::irqs::handler(irq - with a single parameter) is used all=

>> over the map.
>>
>=20
> I'd really prefer making one invasive change early in the process of
> addressing the issue than several kludges later to work around
> structural shortcomings, so no problem, go wild, I'm all ears.
>=20

Oh, we have green light for some /real/ changes! ;)

Well, one advantage of a cookie inside the ipipe patch is that also the
data locality would increase, especially for the trivial case of only
one handler being installed. Then we would be able to handle down the
user's xnintr_t structure, and that one would already make it into the
caches by adeos traversing the pipe...

Jan


--------------enig952AEECF904B910BA8E566EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDZ1n5ncNeS9Q0k+IRAiR+AJ9gnZqrbvU0lXCiYTOuIg+gBkCKWACgrS+v
pr+A8ZNv1lnPDqymRS/5BVo=
=xZ7b
-----END PGP SIGNATURE-----

--------------enig952AEECF904B910BA8E566EA--

