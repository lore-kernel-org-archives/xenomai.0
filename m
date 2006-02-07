Message-ID: <43E8DFC4.4010805@domain.hid>
Date: Tue, 07 Feb 2006 18:58:28 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
References: <b647ffbd0602070104s63275903q@domain.hid>
	<43E86F4D.4050400@domain.hid>
In-Reply-To: <43E86F4D.4050400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDAD6EB8073F2227ED6F9BAE7"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>, Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDAD6EB8073F2227ED6F9BAE7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> Dmitry Adamushko wrote:
>>
>> Hi,
>>
>> this is the final set of patches against the SVN trunk of 2006-02-03.
>>
>> It addresses mostly remarks concerning naming (XN_ISR_ISA ->
>> XN_ISR_EDGE), a few cleanups and updated comments.
>>
>> Functionally, the support for shared interrupts (a few flags) to the

Not directly your fault: the increasing number of return flags for IRQ
handlers makes me worry that they are used correctly. I can figure out
what they mean (not yet that clearly from the docs), but does someone
else understand all this:

- RT_INTR_HANDLED
- RT_INTR_CHAINED
- RT_INTR_ENABLE
- RT_INTR_NOINT

or

- RTDM_IRQ_PROPAGATE
- RTDM_IRQ_ENABLE
- RTDM_IRQ_NOINT

Third-party comments / suggestions welcome as well. Maybe I'm too
pessimistic.

>> rtdm (Jan's patch) and native skin.
>> In the later case, rt_intr_create() now contains the 6-th argument,
>> namely "int mode".
>>
>> Now I'm waiting for the test results from Jan (the previous patch-set
>> remains to be suitable for testing too in case you are using it
>> already). Upon success, the new code is ready for merging.

Trying to manage the priority list of someone else is tricky - I hope we
can see something soon, but I cannot promise anything.

>>
>> the patches have to be applied as follows :
>> - shirq-base
>> - shirq-v8
>> - shirq-proc
>> - shirq-edge
>> - shirq-ext
>>
>> Happy testing ! :)
>=20
> My concern is code size. I see that the patches add substantial amount
> of code to the ISR. What about make this feature configurable?
>=20

I would vote for the (already scheduled?) extension to register an
optimised IRQ trampoline in case there is actually no sharing taking
place. This would also make the "if (irq =3D=3D XNARCH_TIMER_IRQ)" path
obsolete.

Jan


--------------enigDAD6EB8073F2227ED6F9BAE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD6N/EncNeS9Q0k+IRAlSaAKCNljFs77Qh/93rXBwIOPxmrsPY2gCeJpJ5
Ib1PmWZsHaUebyz+6UWNY0s=
=l2yx
-----END PGP SIGNATURE-----

--------------enigDAD6EB8073F2227ED6F9BAE7--

