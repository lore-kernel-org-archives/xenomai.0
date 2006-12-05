Message-ID: <4575BFBF.1080306@domain.hid>
Date: Tue, 05 Dec 2006 19:51:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid>
	<E1GrdKV-00048O-FF@mailer.emlix.com> <4575A2C0.6000305@domain.hid>
	<200612051934.14391.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200612051934.14391.Sebastian.Smolorz@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDDC32145D423743581E22598"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDC32145D423743581E22598
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Sebastian Smolorz wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Are you tracing into vmalloc'ed memory?
>>>>>>>> Yes, without CONFIG_IPIPE_TRACE_VMALLOC the system does not boot=
=2E
>>>>>>> Hmm, makes me wonder of some laziness of the page mapping or a
>>>>>>> missing lock-against-swapping causes this. Could you have a close=
r
>>>>>>> look at the tracer code if we are lacking some magic for the vmal=
loc
>>>>>>> trace buffer (compare to the xnheap code, e.g.)?
>>>>>> This is a known issue, the ARM architecture lacks the set_pgdir
>>>>>> function, needed in mm/vmalloc.c to workaround the lazy page mappi=
ng
>>>>>> of vmalloced areas.
>>>>> Would vmalloc+memset help to be safe for the remaining system runti=
me?
>>>> Probably not, the vmalloced area is added only to the page table of =
the
>>>> process that calls vmalloc, it is added to other processes table pag=
e
>>>> only once they use it.
>>> Are there any alternatives? Or do we have to live with this restricti=
on?
>> Try if smaller CONFIG_IPIPE_TRACE_SHIFT makes it boot without
>> CONFIG_IPIPE_TRACE_VMALLOC.
>=20
> I already tried that but it didn't help. First with IPIPE_TRACE_SHIFT s=
et to=20
> 10 and after modifying Kconfig.debug with a value of 5. Booting impossi=
ble.

What about starting disabled and arming the tracer later via
/proc/ipipe/trace/enable? This sounds like it's not a size issue
(TRACE_SHIFT=3D5 is ridiculous small), rather some memory section is
accessed too early.

If it works we could postpone enabling to __ipipe_init_tracer by default
(like it is done for TRACE_VMALLOC). I cannot imagine use cases for the
tracer ATM that would benefit from early tracing.

Jan


--------------enigDDC32145D423743581E22598
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdb+/niDOoMHTA+kRAlRIAJ49B8klAtn8ZXhwSVDI72gF/kVIZwCaAhat
e/17fCBSzyV0BL9qWyJ6114=
=XPE9
-----END PGP SIGNATURE-----

--------------enigDDC32145D423743581E22598--

