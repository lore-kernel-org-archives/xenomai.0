Message-ID: <448D2861.9010704@domain.hid>
Date: Mon, 12 Jun 2006 10:40:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44720BD1.805@domain.hid>
	<447E9E9E.6070301@domain.hid>	<4486FCA3.2070501@domain.hid>
	<448703C2.8030601@domain.hid> <4487DEC5.50705@domain.hid>
	<448B4589.6030101@domain.hid> <448D2574.1000204@domain.hid>
In-Reply-To: <448D2574.1000204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6FAFC3410A9726072828EF77"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] kgdb/x86 over I-pipe
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
--------------enig6FAFC3410A9726072828EF77
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Philippe Gerum wrote:
>>>>
>>>>
>>>>> Hi Jan,
>>>>>
>>>>> Based on your previous work, here is a set of patches coupling KGDB=

>>>>> and
>>>>> the I-pipe. Basically, I've attempted to shrink the extra patches
>>>>> needed
>>>>> against the original KGDB + I-pipe ones to the bare minimum. This h=
as
>>>>> been obtained by having the I-pipe provide ipipe_current_safe(), an=
d
>>>>> drastically reduce the amount of fiddling with smp_processor_id().
>>>>>
>>>>> The key difference with the former implementation is that a domain
>>>>> (e.g.
>>>>> Xenomai) is now expected to tell the I-pipe when it's switching to =
a
>>>>> non-Linux stack, and the I-pipe makes good use of this information =
to
>>>>> return the proper "current" value when asked to through
>>>>> ipipe_safe_current() from the KGDB code. The issue of swapping
>>>>
>>>>
>>>> This looks nice.
>>>>
>>>>
>>>>
>>>>> smp_processor_id() with ipipe_processor_id() has been addressed the=

>>>>> hard
>>>>> way: smp_processor_id() is simply defined as ipipe_processor_id() w=
hen
>>>>> CONFIG_IPIPE and CONFIG_KGDB are both enabled in include/linux/smp.=
h.
>>>>> This approach was actually used during the old Adeos times when
>>>>> pipeline
>>>>> domain had their own separate stack. I take for granted that the CP=
U
>>>>> penalty taken in doing this is perfectly acceptable, since well, we=

>>>>> are
>>>>> debugging after all.
>>>>
>>>>
>>>> There is only one drawback: we will not be able to debug
>>>> smp_processor_id-related bugs in ipipe/Xenomai anymore...
>>>>
>>>
>>> Good point. Here is an updated patch.
>>>
>>
>>
>> Nope that's not the point I meant. I was referring to bugs like the
>> missing smp_processor_id patch in asm-i386/mmu_context.h. Your way mak=
es
>> such problems disappear once you switch on the debugger. Remember that=

>> we spotted the mmu_context issue via kgdb.
>>
>=20
> Got it now. Indeed, making such kind of bugs disappear would be a very
> undesirable side-effect of enabling KGDB.
>=20
>> The attached kgdb-ipipe patch (which also updates to kgdb-CVS head)
>> addresses maintenance and smp-safeness by redefining the involved
>> services only per source file, not kernel-wide. What's do you think
>> about this approach?
>>
>=20
> Mixed feelings. On one hand, it locally fixes the issue without masking=

> any bugs and that's good. On the other hand, I've been bitten using thi=
s
> kind of tricks in earlier Adeos releases for patching printk() the same=

> way, substituting it with spin_lock_irqsave_hw. At some point,
> spin_lock_irqsave became local_irq_save + spin_lock in the vanilla code=
,
> making the substitution of the former pointless, and opening a
> preemption hole in the code. This said, no spinlock macros are involved=

> in the substitution you are suggesting, so there is no such risk, and i=
n
> any case, the risk is confined to one file and not spread all over the
> place like with the raw_smp_processor_id() substitution. IOW, let's go
> your way.

I agree that it's kind of fragile, but we need to check on kgdb updates
anyway. I hope for kgdb becoming mainline one day. Then the code should
stabilise (if it hasn't already), and we can track it via ipipe directly
- without tricks. So far, this should help to keep efforts lower for us.

>=20
> While we are at it,
> #define current ipipe_safe_current() /* ? */

Nope, there is the need for some special changes.

>=20
>> I'm also posting two fixes for ipipe itself to 1) make kgdb work over
>> SMP and 2) fix a compiler warning.
>>
>> This version works fine for me, at least in qemu. I tried to check SMP=

>> as well, but qemu obviously lacks support for NMIs raised via IPI, and=

>> this is used by kgdb to sync all CPUs on debugging events (vanilla kgd=
b
>> suffers too).
>>
>=20

Jan


--------------enig6FAFC3410A9726072828EF77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjShhniDOoMHTA+kRAu7oAJ9cbk6is4fNb4G0Y/ObGfdFL8mpGACbB4O5
S1y5Ny09W8Ofeh7+0/2DZlY=
=Z/UJ
-----END PGP SIGNATURE-----

--------------enig6FAFC3410A9726072828EF77--

