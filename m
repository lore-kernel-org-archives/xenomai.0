Message-ID: <43E9AAB3.5020004@domain.hid>
Date: Wed, 08 Feb 2006 09:24:19 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
References: <b647ffbd0602070104s63275903q@domain.hid>
	<43E86F4D.4050400@domain.hid>
	<43E8DFC4.4010805@domain.hid>
	<43E99D2F.6040609@domain.hid>
In-Reply-To: <43E99D2F.6040609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE5E8337891BB951A7EDAC5CE"
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
--------------enigE5E8337891BB951A7EDAC5CE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> Dmitry Adamushko wrote:
>>>> Hi,
>>>>
>>>> this is the final set of patches against the SVN trunk of 2006-02-03=
=2E
>>>>
>>>> It addresses mostly remarks concerning naming (XN_ISR_ISA ->
>>>> XN_ISR_EDGE), a few cleanups and updated comments.
>>>>
>>>> Functionally, the support for shared interrupts (a few flags) to the=

>>
>> Not directly your fault: the increasing number of return flags for IRQ=

>> handlers makes me worry that they are used correctly. I can figure out=

>> what they mean (not yet that clearly from the docs), but does someone
>> else understand all this:
>>
>> - RT_INTR_HANDLED
>> - RT_INTR_CHAINED
>> - RT_INTR_ENABLE
>> - RT_INTR_NOINT
>>
>> or
>>
>> - RTDM_IRQ_PROPAGATE
>> - RTDM_IRQ_ENABLE
>> - RTDM_IRQ_NOINT
>>
>> Third-party comments / suggestions welcome as well. Maybe I'm too
>> pessimistic.
>>
>>>> rtdm (Jan's patch) and native skin.
>>>> In the later case, rt_intr_create() now contains the 6-th argument,
>>>> namely "int mode".
>>>>
>>>> Now I'm waiting for the test results from Jan (the previous patch-se=
t
>>>> remains to be suitable for testing too in case you are using it
>>>> already). Upon success, the new code is ready for merging.
>>
>> Trying to manage the priority list of someone else is tricky - I hope =
we
>> can see something soon, but I cannot promise anything.
>>
>>>> the patches have to be applied as follows :
>>>> - shirq-base
>>>> - shirq-v8
>>>> - shirq-proc
>>>> - shirq-edge
>>>> - shirq-ext
>>>>
>>>> Happy testing ! :)
>>> My concern is code size. I see that the patches add substantial amoun=
t
>>> of code to the ISR. What about make this feature configurable?
>>>
>>
>> I would vote for the (already scheduled?) extension to register an
>> optimised IRQ trampoline in case there is actually no sharing taking
>> place. This would also make the "if (irq =3D=3D XNARCH_TIMER_IRQ)" pat=
h
>> obsolete.
>=20
> I still prefer configuration options as they also allow to reduce the
> overall code size (less cache refills and TLB misses). And shared
> interrupts are for x86 only (approximately), I think. Unfortunately, I

Ok, that's a good argument. Then make the whole IRQ-sharing stuff
compile-time configurable and see how much we can save.

> don't have the time to follow all the details of the rapid Xenomai
> development and can't therefore judge what is really necessary.
>=20
> Wolfgang.
>=20

Jan



--------------enigE5E8337891BB951A7EDAC5CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD6aqzncNeS9Q0k+IRApz3AKClT07LeT+5/10ZBdbn3VgLUyyrtgCfejzO
dhFeilmfS9gdkFET1StXDEw=
=RICO
-----END PGP SIGNATURE-----

--------------enigE5E8337891BB951A7EDAC5CE--

