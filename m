Message-ID: <49A32123.1080707@domain.hid>
Date: Mon, 23 Feb 2009 23:20:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499EBF45.900@domain.hid>
	<49A290E8.5030400@domain.hid>	<49A29871.90807@domain.hid>
	<49A29CBF.80701@domain.hid>	<49A2A654.7040706@domain.hid>
	<49A2E00C.1090201@domain.hid> <49A2F1B2.7090108@domain.hid>
In-Reply-To: <49A2F1B2.7090108@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig70D18F9D9F686587F78F36C3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] x86: Proper root domain state management
 for ipipe_handle_exception
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig70D18F9D9F686587F78F36C3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> Philippe Gerum wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> This is an attempt to fix the broken root domain state adjustment=
 in
>>>>>>> __ipipe_handle_exception. Patch below fixes the issues recently r=
eported
>>>>>>> by Roman Pisl. Also, it currently makes much more sense to me tha=
n what
>>>>>>> we have so far.
>>>>>>>
>>>>>>> In short, this patch propagates the hardware irq state into the r=
oot
>>>>>>> domains stall flag shortly before calling into the Linux handler,=
 and
>>>>>>> only then. This avoids spurious root domain stalls the end up ove=
r the
>>>>>>> wrong Linux context due to context switches between enter and exi=
t of
>>>>>>> ipipe_handle_exception. Also, this patch drops the bogus
>>>>>>> local_irq_save/restore pair that doesn't account for Linux irq st=
ate
>>>>>>> changes inside its fault handler.
>>>>>>>
>>>>>> Actually, it is not bogus at all, it is even mandatory on x86_64, =
given that we
>>>>>> don't branch to any sysretq/iretq emulation unlike with x86_32. So=
 if we don't
>>>>>> restore the stall bit for the root domain properly there, we could=
 end up
>>>>>> running with interrupts off in user-space.
>>>>>>
>>>>>> However, the way the interrupt state is currently saved is wrong: =
we should not
>>>>>> local_irq_disable() over non-root domains. Here is some on-line do=
cumentation to
>>>>>> explain why:
>>>>>>
>>>>>> The main difference between x86_32 and 64 is that the former does =
virtualize the
>>>>>> interrupt state in entry_32.S, unlike the latter. For that reason,=
 x86_64 does
>>>>>> not require (actually, we should not be doing) any fixup. So, to s=
um up:
>>>>>>
>>>>>> - we use fixup_if() to restore the virtual interrupt state properl=
y when control
>>>>>> is given back to the code that triggered the fault/exception (x86_=
32). We need
>>>>>> to do that because of task migrations between primary and secondar=
y modes.
>>>>>>
>>>>>> - we must clear the virtual interrupt flag before calling the I-pi=
pe handler /
>>>>>> Linux regular exception handler, because our callee may/must run i=
n the root
>>>>>> domain as well, and expect that interrupt state to reflect the hw =
one, as set by
>>>>>> the x86 exception gate / fault prologue in entry_*.S.
>>>>>>
>>>>>> - because of the above, we must use local_irq_save()/local_irq_res=
tore_nosync()
>>>>>> in our fault handler to make sure to restore the virtual interrupt=
 flag properly
>>>>>> between this routine, and the exception return statement (i.e. dur=
ing the Linux
>>>>>> fault epilogue in entry_*.S).
>>>>> OK, if there is a reason to enforce a stalled root domain while cal=
ling
>>>>> into the exception hook, this makes some sense. But I don't think i=
t is
>>>>> formally correct to save the root state on entry and blindly restor=
e it
>>>>> _after_ calling the Linux handler. I rather think we should keep th=
e
>>>>> state that Linux leaves behind to remain transparent to it. Maybe n=
o
>>>>> practical issue ATM, but it makes the code at least illogical.
>>>>>
>>>> Please re-read the explanations, and you will find the logic. I cann=
ot do
>>>> anything more than re-hashing what I just said. What you perceive as=
 illogical
>>>> is actually the only sane way to do this. Formally speaking, a linux=
 fault
>>>> handler may NOT alter the interrupt state blindly, so we must be abl=
e to assume
>>>> that we ought to restore it the way the lower code set it.
>>> I got your first and second point, but they don't imply to me that th=
e
>>> third shall be correct as well. "...to make sure to restore the virtu=
al
>>> interrupt flag properly" is not directly an clear explanation (for me=
)
>>> why we have to restore the flag across calls to the _Linux_ handler. =
We
>>> can demand that the hook handler leaves the root state untouched, but=

>>> requiring the same from Linux is a restriction that you don't find in=

>>> the ipipe-less case, nor do I see the reason for this under ipipe con=
trol.
>>>
>> The make my question a bit more concrete (and help me writing the righ=
t
>> comments around these lines): What makes the following change bogus,
>> which scenario will fail?
>>
>> Index: b/arch/x86/kernel/ipipe.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/arch/x86/kernel/ipipe.c
>> +++ b/arch/x86/kernel/ipipe.c
>> @@ -685,7 +685,9 @@ int __ipipe_handle_exception(struct pt_r
>>  	}
>> =20
>>  	__ipipe_std_extable[vector](regs, error_code);
>> -	local_irq_restore_nosync(flags);
>> +
>> +	__fixup_if(test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)=
),
>> +		   regs);
>> =20
>>  	return 0;
>>  }
>>
>=20
>=20
> This would break the interrupt state on x86_64, because it is not virtu=
alized by

Hmm, __fixup_if is void on x86-64, so this was way off what I was trying
to express.

> the low level code (latency wise, this is not worth the burden). So you=
r
> exception path would stall the root domain, and never unstall it becaus=
e you do
> not have any iretq/sysretq emulation; actually, you do not have any fix=
up. This
> would work on x86_32 for the converse reason though.

OK, I finally understood this difference. (I guess it comes from a
different code structure of entry_32.S compared to entry_64.S, right? So
nothing we could unify on our own?)

To clarify this for me: For 32 bit, the pipeline state after iret/sysret
is calculated in the entry layer (in __ipipe_unstall_iret_root more
precisely), so the local_irq_restore_nosync is actually of minor
importance here, isn't it? Couldn't we skip it for this arch then?

On 64 bit, we have to set the right pipeline state before returning to
the entry layer because it won't be touched there at all. We currently
do this based on the state found on exception entry, but we could also
do it based on the regs.flags state that the Linux handler left behind
(like we do on 32 bit). But the scenario I had in mind where this would
actually make a difference turned out to be a red herring. I don't think
Linux modifies regs.flags in its exception handlers. The ipipe pattern
remains inconsistent IMHO, but it is practically irrelevant.


Final question to explain the __fixup_if in __ipipe_handle_exception:
That's due to the scenario where we migrate to the root domain while
running the notify handler? We may return from that migration with some
IF state in regs.flags that no longer matches the one found on exception
entry, correct?

Will stuff all this into a few lines of comments soon.

Thanks for your patience,
Jan


--------------enig70D18F9D9F686587F78F36C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmjIScACgkQniDOoMHTA+lU5wCdHqYbHHKGPHTXfI7jPTGhPhyN
6xoAnjfN6F0MruQPAyt4kafVLToqwf6Y
=yluf
-----END PGP SIGNATURE-----

--------------enig70D18F9D9F686587F78F36C3--

