Message-ID: <4AF8A181.3050502@domain.hid>
Date: Tue, 10 Nov 2009 00:10:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AF85A5F.2030203@domain.hid>
	<4AF85B75.40408@domain.hid>	<4AF85EAD.5020408@domain.hid>
	<4AF86204.6000700@domain.hid>	<4AF8646D.1000204@domain.hid>
	<1257807715.2210.482.camel@domain.hid>
In-Reply-To: <1257807715.2210.482.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9F06D34A6347873CE8953CDD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] Unchecked ipipe_test_pipeline_from
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9F06D34A6347873CE8953CDD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2009-11-09 at 19:50 +0100, Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi Philippe,
>>>>>>
>>>>>> just noticed: The __ipipe_check_percpu_access of __ipipe_get_cpu_v=
ar,
>>>>>> added in 2.6.29, makes ipipe_test_pipeline_from unusable for debug=
ging
>>>>>> purposes. It now triggers a false positive warning if the caller d=
id not
>>>>>> disabled interrupts or stalled its pipeline. One such user under X=
enomai
>>>>>> is rthal_local_irq_disabled, and that is used to check RTDM driver=

>>>>>> handlers /wrt leaking IRQ masks.
>>>>> It does not look like a false positive. If the task issuing the cal=
l to
>>>>> rthal_local_irq_disabled function was migrated at the wrong time, i=
t
>>>>> could check the stall flag on the wrong cpu.
>>>> Unless you want to test the migration logic itself, a plain task in
>>>> whatever domain should never see a CPU-depend rthal_local_irq_disabl=
ed -
>>>> migration should never alter the context in this respect.
>>>>
>=20
> A plain task over the root domain which is subject to a migration may
> end up testing the stall bit on the wrong (dest) CPU, which may execute=

> a different domain than the one running on the source CPU. As soon as

Yeah, makes sense now (with source and dest swapped, though).

> the domain is not a context invariant, you do have a serious issue
> coming up. So this does matter a lot, as the bug fixed some time ago in=

> ipipe_check_context() showed.
>=20
>>>>> So, it looks like
>>>>> rthal_local_irq_disabled should be fixed to turn off irqs during th=
e check.
>>>>>
>>>> Would work, but would also be more heavy-weighted then needed.
>>> If it is debug stuff, does the heavy-weight matter that much?
>>>
>> Actually, I'm no longer sure that a preemption check for
>> ipipe_stall_pipeline_from makes sense at all. Am I missing some case?
>>
>=20
> Same as above. Albeit there may not be forced CPU migration over the
> Xenomai domain, this is perfectly possible on the root one.

OK, will fix the checks in RTDM then.

Jan


--------------enig9F06D34A6347873CE8953CDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr4oYEACgkQitSsb3rl5xSTIQCdEa3m4gDp9ES/Xl1VRIqeRZNj
Us4An2OfRN2lSZO9p1kHlhK2gyuIoMkF
=BztN
-----END PGP SIGNATURE-----

--------------enig9F06D34A6347873CE8953CDD--

