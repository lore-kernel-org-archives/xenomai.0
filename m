Message-ID: <4AC77576.9070700@domain.hid>
Date: Sat, 03 Oct 2009 18:01:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC5E895.8010107@domain.hid> <4AC5F49E.3070608@domain.hid>
	<4AC5FEAD.7000608@domain.hid>
In-Reply-To: <4AC5FEAD.7000608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig316BD1572624BB1ED93874A6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Freeze on SMP x86-64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roman Pisl <rpisl@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig316BD1572624BB1ED93874A6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Roman Pisl wrote:
> On 2.10.2009 14:39, Gilles Chanteperdrix wrote:
>> Roman Pisl wrote:
>>> Hello,
>>> I just tried x86-64 SMP Linux/Xenomai on my workstation (Intel Core2
>>> Quad) but it freezes immediately after latency test or clocktest is
>>> started. It freezes even during the boot, when Xenomai debbuging is
>>> enabled.
>>>
>>> The same kernel binary runs seamlessly in KVM on the same machine.
>>>
>>> When I completely disable ACPI, the kernel recognizes only one CPU an=
d
>>> the latency test works.
>>>
>>> The same configuration but for 32bit x86 also runs without freeze.
>>>
>>> Do you have any ideas?
>>
>> Yes. As we repeated many times.
>> Tell us the versions of Xenomai and of the I-pipe patch you use.
>> Send us your .config
>> Manage to get the kernel console output (using a serial cable connecte=
d
>> to another PC, or the netconsole, some people even used to send us
>> photos about kernel crashes).
>>
>=20
> I send dmesg output for both 32 and 64 bit. Unfortunately it just
> freezes with no kernel panic output. When Xenomai debugging is enabled,=

> the kernel freezes after Xenomai is initialized (last message: Xenomai:=

> starting RTDM services).

Does this patch make any difference?

Jan

------->

x86: Fix irq_move_cleanup virtualization

Call the right function and avoid a recursion when this interrupt
triggers.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 arch/x86/kernel/ipipe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index b8f9139..d4789c8 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -290,7 +290,7 @@ void __init __ipipe_enable_pipeline(void)
=20
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     ipipe_apic_vector_irq(IRQ_MOVE_CLEANUP_VECTOR),
-			     (ipipe_irq_handler_t)&irq_move_cleanup_interrupt,
+			     (ipipe_irq_handler_t)&smp_irq_move_cleanup_interrupt,
 			     NULL,
 			     &__ipipe_ack_apic,
 			     IPIPE_STDROOT_MASK);



--------------

PS:
=2E..
> [    0.005664] Checking 'hlt' instruction... OK.
> [    0.020484] ACPI: Core revision 20090521
> [    0.259694] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin=
2=3D-1
> [    0.260001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC

This is an ipipe triggered oddity (if not bug), too. I'm seeing it over
kvm as well, and it goes away when disabling ipipe. Does it ring some
bell? Otherwise I will check this later.



--------------enig316BD1572624BB1ED93874A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrHdXoACgkQitSsb3rl5xSOOwCeO4APFJszNn/bXKe6I0FNVHbc
pbkAoNEq0DMaspTIfo8Mwkt2w9xR6JHp
=R9nB
-----END PGP SIGNATURE-----

--------------enig316BD1572624BB1ED93874A6--

