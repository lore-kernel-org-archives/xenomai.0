Message-ID: <4B5C24C1.3080708@domain.hid>
Date: Sun, 24 Jan 2010 11:45:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B59D952.30202@domain.hid>	<1264181859.2350.152.camel@domain.hid>	<4B59E2D4.5040004@domain.hid>
	<4B59E33E.1040203@domain.hid>	<1264182738.2350.158.camel@domain.hid>	<4B59E87F.80108@domain.hid>	<1264183719.2350.159.camel@domain.hid>	<1264240767.2350.164.camel@domain.hid>	<4B5ACAD7.5070607@domain.hid>	<1264241541.2350.166.camel@domain.hid>	<4B5AD08B.1080009@domain.hid>
	<1264328701.2350.182.camel@domain.hid>
In-Reply-To: <1264328701.2350.182.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4DA722E29044B72EA2A20F8D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Domain switch during page fault handling
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4DA722E29044B72EA2A20F8D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2010-01-23 at 11:33 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sat, 2010-01-23 at 11:09 +0100, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Fri, 2010-01-22 at 19:08 +0100, Philippe Gerum wrote:
>>>>>> On Fri, 2010-01-22 at 19:03 +0100, Jan Kiszka wrote:
>>>>>>> Philippe Gerum wrote:
>>>>>>>> On Fri, 2010-01-22 at 18:41 +0100, Jan Kiszka wrote:
>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> Philippe Gerum wrote:
>>>>>>>>>>> On Fri, 2010-01-22 at 17:58 +0100, Jan Kiszka wrote:=20
>>>>>>>>>>>> Hi guys,
>>>>>>>>>>>>
>>>>>>>>>>>> we are currently trying to catch an ugly Linux pipeline stat=
e corruption
>>>>>>>>>>>> on x86-64.
>>>>>>>>>>>>
>>>>>>>>>>>> Conceptual question: If a Xenomai task causes a fault, we en=
ter
>>>>>>>>>>>> ipipe_trap_notify over the primary domain and leave it over =
the root
>>>>>>>>>>>> domain, right? Now, if the root domain happened to be stalle=
d when the
>>>>>>>>>>>> exception happened, where should it normally be unstalled ag=
ain,
>>>>>>>>>>>> *for_that_task*? Our problem is that we generate a code path=
 where this
>>>>>>>>>>>> does not happen.
>>>>>>>>>>> xnhadow_relax -> ipipe_reenter_root -> finish_task_switch ->
>>>>>>>>>>> finish_lock_switch -> unstall
>>>>>>>>>>>
>>>>>>>>>>> Since xnshadow_relax is called on behalf the event dispatcher=
, we should
>>>>>>>>>>> expect it to return with the root domain unstalled after a do=
main
>>>>>>>>>>> downgrade, from primary to root.
>>>>>>>>>> Ok, but what about local_irq_restore_nosync at the end of the =
function ?
>>>>>>>>>>
>>>>>>>>> That is, IMO, our problem: It replays the root state on fault e=
ntry, but
>>>>>>>>> that one is totally unrelated to the (Xenomai) task that caused=
 the fault.
>>>>>>>> The code seems fishy. Try restoring only when the incoming domai=
n was
>>>>>>>> the root one. Indeed.
>>>>>>>>
>>>>>>> Something like this?
>>>>>>>
>>>>>>> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
>>>>>>> index 4442d96..0558ea3 100644
>>>>>>> --- a/arch/x86/kernel/ipipe.c
>>>>>>> +++ b/arch/x86/kernel/ipipe.c
>>>>>>> @@ -702,19 +702,21 @@ static int __ipipe_xlate_signo[] =3D {
>>>>>>> =20
>>>>>>>  int __ipipe_handle_exception(struct pt_regs *regs, long error_co=
de, int vector)
>>>>>>>  {
>>>>>>> +	bool restore_flags =3D false;
>>>>>>>  	unsigned long flags;
>>>>>>> =20
>>>>>>> -	/* Pick up the root domain state of the interrupted context. */=

>>>>>>> -	local_save_flags(flags);
>>>>>>> +	if (ipipe_root_domain_p && irqs_disabled_hw()) {
>>>>>>> +		/* Pick up the root domain state of the interrupted context. *=
/
>>>>>>> +		local_save_flags(flags);
>>>>>>> =20
>>>>>>> -	if (ipipe_root_domain_p) {
>>>>>>>  		/*
>>>>>>>  		 * Replicate hw interrupt state into the virtual mask before
>>>>>>>  		 * calling the I-pipe event handler over the root domain. Also=

>>>>>>>  		 * required later when calling the Linux exception handler.
>>>>>>>  		 */
>>>>>>> -		if (irqs_disabled_hw())
>>>>>>> -			local_irq_disable();
>>>>>>> +		local_irq_disable();
>>>>>>> +
>>>>>>> +		restore_flags =3D true;
>>>>>>>  	}
>>>>>>>  #ifdef CONFIG_KGDB
>>>>>>>  	/* catch exception KGDB is interested in over non-root domains =
*/
>>>>>>> @@ -725,7 +727,8 @@ int __ipipe_handle_exception(struct pt_regs *=
regs, long error_code, int vector)
>>>>>>>  #endif /* CONFIG_KGDB */
>>>>>>> =20
>>>>>>>  	if (unlikely(ipipe_trap_notify(vector, regs))) {
>>>>>>> -		local_irq_restore_nosync(flags);
>>>>>>> +		if (restore_flags)
>>>>>>> +			local_irq_restore_nosync(flags);
>>>>>>>  		return 1;
>>>>>>>  	}
>>>>>>> =20
>>>>>>> @@ -770,7 +773,8 @@ int __ipipe_handle_exception(struct pt_regs *=
regs, long error_code, int vector)
>>>>>>>  	 * Relevant for 64-bit: Restore root domain state as the low-le=
vel
>>>>>>>  	 * return code will not align it to regs.flags.
>>>>>>>  	 */
>>>>>>> -	local_irq_restore_nosync(flags);
>>>>>>> +	if (restore_flags)
>>>>>>> +		local_irq_restore_nosync(flags);
>>>>>>> =20
>>>>>>>  	return 0;
>>>>>>>  }
>>>>>>>
>>>>>>>
>>>>>>> We are currently not able to test this on the system that trigger=
s it,
>>>>>>> but we'll do so tomorrow (yeah...).
>>>>>>>
>>>>>> Should work. Famous last words.
>>>>>>
>>>>> Strike that. This won't work, because the fixup code will use the s=
aved
>>>>> flags even when root is not the incoming domain and/or hw IRQs are =
on on
>>>>> entry. In short, local_save_flags() must be done unconditionally, a=
s
>>>>> previously.
>>>> It will accidentally work for 64-bit where __fixup_if is empty. And =
for
>>>> 32-bit, I would say we need to make it depend on restore_flags as we=
ll.
>>>>
>>> AFAIK, Gilles is working on this. We just need to avoid stepping on
>>> 32bit toes to fix 64.
>>>
>> OK.
>>
>> Just realized that my suggestion would conflict with the comment above=

>> __fixup_if. So I think we first need to clarify the various scenarios
>> again to avoid breaking one while fixing another.
>>
>> Entry over non-root, exit over non-root:
>>  - no need to fiddle with the root state
>>
>=20
> Correct.
>=20
>> Entry over root, exit over root, !irqs_disabled_hw():
>>  - no need to fiddle with the root state
>>  - 32 bit: regs fixup required?
>>
>=20
> The iret emulation via iret_root needs proper fixup to have taken place=
,
> so doing the fixup is mandatory in any case.
>=20
>> Entry over root, exit over root, irqs_disabled_hw():
>>  - save root state & disable root IRQs on entry
>>  - 32 bit: replicate saved state into regs.eflags before calling linux=

>>    handler
>>  - restore saved state on exit
>=20
> Correct.
>=20
>> Entry over non-root, exit over root:
>>  - ?
>>
>> I tend to think that, for the 32-bit cases, we should pick up the flag=
s
>> from the root state _after_ returning from ipipe_trap_notify and only =
if
>> we are truly running in the root domain then. That should be the value=

>> the migration left behind, so the correct one, right?
>>
>=20
> Yes.
>=20
>> Any scenario missing?
>>
>=20
> Should be ok. But the more I think of it, the more I'm convinced that w=
e
> should make the 32 and 64 bit implementation converge to the x86_64 one=
=2E
> iret_root emulation is required because we virtualize the interrupt
> masking in the assembly-written portions for x86_32, which we don't for=

> x86_64.=20
>=20
> Hyste^Horically, there was a strong requirement to do that with legacy
> 2.4 kernels the 32 bit implementation was designed for, because lengthy=

> masked sections would raise the latency above the top. With current
> 2.6/x86 kernels, I don't think virtualizing interrupt masking in the
> assembly-written portions makes a lot of sense anymore, since
> significant work took place upstream over time, to allow for
> fine-grained preemption there.

I'm all for this, but I think it should happen gradually. In step 1, we
should fix the current situation. Step 2 would obsolete __fixup_if by
moving x86-32 towards the 64-bit scheme.

So a discussion of my last patch would be warmly welcomed.

Jan


--------------enig4DA722E29044B72EA2A20F8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktcJMYACgkQitSsb3rl5xRC/gCdGO3QNX//UMgy13L41iJEDL7t
294AnAxnlG+QdbHuKim54ymkgLJbyMoy
=FekF
-----END PGP SIGNATURE-----

--------------enig4DA722E29044B72EA2A20F8D--

