Message-ID: <46C59858.7080309@domain.hid>
Date: Fri, 17 Aug 2007 14:45:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2862c2c80708170409p7946b48fw4a18553d5e51da43@domain.hid>
	<2ff1a98a0708170507u6906399dxfa47c704a12080cf@domain.hid>
In-Reply-To: <2ff1a98a0708170507u6906399dxfa47c704a12080cf@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C2AE52484BA01A2D0C945C8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] I-pipe: Detected illicit call from
	domain	'Xenomai'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C2AE52484BA01A2D0C945C8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On 8/17/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
>> Dear all,
>>
>> I have encounter the following problem when migrating a Linux driver t=
o RTDM
>> driver:
>>
>> I-pipe: Detected illicit call from domain 'Xenomai'
>>         into a service reserved for domain 'Linux' and below.

[Nice example for how to validate new RTDM drivers or Xenomai skins
against accidental Linux calls! =3D> CONFIG_IPIPE_DEBUG_CONTEXT]

>> [<c002a474>] (show_stack+0x0/0x58) from [<c00736a4>]
>> (ipipe_check_context+0x98/0xe4)
>> [<c007360c>] (ipipe_check_context+0x0/0xe4) from [<c00d4ca4>]
>> (cache_alloc_refill+0x7c/0x78c)
>>  r8 =3D 00000020  r7 =3D C04A3360  r6 =3D 00000000  r5 =3D 0000001B
>>  r4 =3D 00000000
>> [<c00d4c28>] (cache_alloc_refill+0x0/0x78c) from [<c00d54dc>]
>> (__kmalloc+0x128/0x138)
>> [<c00d53b4>] (__kmalloc+0x0/0x138) from [<c027ede8>] (__alloc_skb+0x58=
/0xf8)
>>  r8 =3D 00000000  r7 =3D C04A8B00  r6 =3D 00000060  r5 =3D 00000020
>>  r4 =3D C065C940
>> [<c027ed90>] (__alloc_skb+0x0/0xf8) from [<c0222b94>]
>> (at91ether_interrupt+0x250/0x350)
>>  r8 =3D FFC00000  r7 =3D C0768A60  r6 =3D C0768B20  r5 =3D 00000046
>>  r4 =3D C03E4C60
>>
>> <snip>
>>
>>  | #  end     0x80000000    -44 __ipipe_unstall_root+0x4c
>> (__ipipe_restore_root+0x70)
>>  | # *func                  -50 __ipipe_unstall_root+0x10
>> (__ipipe_restore_root+0x70)
>>  | # *func                  -56 __ipipe_restore_root+0x10
>> (kmem_cache_alloc+0x84)
>>  | # *func                  -63 debug_smp_processor_id+0x10
>> (kmem_cache_alloc+0x50)
>>  | # *end     0x80000001    -70 kmem_cache_alloc+0xd8 (__alloc_skb+0x3=
c)
>>  | #  begin   0x80000001    -76 kmem_cache_alloc+0xc4 (__alloc_skb+0x3=
c)
>>  | #  func                  -83 kmem_cache_alloc+0x14 (__alloc_skb+0x3=
c)
>>  | #  func                  -91 __alloc_skb+0x14 (at91ether_interrupt+=
0x250)
>>  | #  func                 -100 at91ether_interrupt+0x14
>> (xnintr_irq_handler+0x48)
>>  | #  func                 -107 xnintr_irq_handler+0x14
>> (__ipipe_dispatch_wired+0xf8)
>>  |   +func                 -113 __ipipe_dispatch_wired+0x14
>> (__ipipe_handle_irq+0x1b0)
>>  |   +func                 -119 at91_aic_mask_irq+0x10
>> (__ipipe_ack_level_irq+0x4c)
>>  |   +func                 -125 at91_aic_mask_irq+0x10
>> (__ipipe_ack_level_irq+0x3c)
>>  |   +func                 -130 __ipipe_ack_level_irq+0x10
>> (__ipipe_ack_irq+0x24)
>>  |   +func                 -137 __ipipe_ack_irq+0x10
>> (__ipipe_handle_irq+0x1a4)
>>  |   +func                 -143 __ipipe_handle_irq+0x14
>> (__ipipe_grab_irq+0xa0)
>>  |   +begin   0xffffffff   -150 __ipipe_grab_irq+0x34 (__irq_svc+0x30)=

>>  |   +func                 -156 __ipipe_grab_irq+0x14 (__irq_svc+0x30)=

>>  |   +end     0x80000000   -164 __ipipe_unstall_root+0x4c
>> (__do_softirq+0x4c)
>>  |   #begin   0x80000000   -171 __ipipe_unstall_root+0x70
>> (__do_softirq+0x4c)
>>      #func                 -177 __ipipe_unstall_root+0x10
>> (__do_softirq+0x4c)
>>      #func                 -183 debug_smp_processor_id+0x10
>> (__do_softirq+0x38)
>>      #func                 -190 debug_smp_processor_id+0x10
>> (__do_softirq+0x30)
>>      #func                 -196 add_preempt_count+0x10 (__do_softirq+0=
x2c)
>>
>> Is this the problem coming from the alloc_skb function call? {
>=20
> Yes, you can not call alloc_skb from Xenomai domain, as you can not
> call most Linux functions. Note that if you are porting a network
> driver, you should consider using rtnet.

The point here is specifically that even if Linux itself provides
deterministic execution of your IRQ handler, it cannot guarantee that
there is always memory available for alloc_skb. That's why RTnet uses
preallocated pools for precisely this scenario. But, to avoid potential
misunderstandings right from the start, it is _not_ intended as a
performance or latency "booster" for standard networking applications.

Jan


--------------enig8C2AE52484BA01A2D0C945C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGxZhYniDOoMHTA+kRAr+4AJ9Llsynfy3+QaG9b7AO8JYevBCJagCeJkmW
Y+PW3x2mQWHZPzfA3t4ua5k=
=pib2
-----END PGP SIGNATURE-----

--------------enig8C2AE52484BA01A2D0C945C8--

