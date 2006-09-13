Message-ID: <4507C49A.5070909@domain.hid>
Date: Wed, 13 Sep 2006 10:43:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>	
	<1158091876.5020.8.camel@domain.hid>
	<b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
	<450727D1.6060203@domain.hid>
In-Reply-To: <450727D1.6060203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0D1C0D91EF45654BB843986C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] Bad EIP kernel-Oops
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0D1C0D91EF45654BB843986C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Dmitry Adamushko wrote:
>> On 12/09/06, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On Tue, 2006-09-12 at 15:24 +0200, Nils Kemper wrote:
>>>> Hi,
>>>> I want to use Xenomai, but I get (sometimes, but everytime the same)=

>>>> kernel-Oops just by running xeno-test:
>>>>
>>>> [..]
>>>> Xenomai: stopping native API services.
>>>> I-pipe: Domain Xenomai unregistered.
>>>> Xenomai: hal/x86 stopped.
>>>> Xenomai: real-time nucleus unloaded.
>>> Does the issue still pop up if you set the Xenomai nucleus as static
>>> (i.e. not as a module) in the kernel configuration?
>>
>>
>> Just a weird presupposition.
>>
>> In __ipipe_dispatch_event()
>>
>>  ipipe_lock_cpu(flags);
>>
>>  start_domain =3D this_domain =3D ipipe_percpu_domain[cpuid];
>>
>>  list_for_each_safe(pos,npos,&__ipipe_pipeline) {
>>
>>                next_domain =3D list_entry(pos,struct ipipe_domain,p_li=
nk);
>>
>> //...
>>                if (next_domain->evhand[event] !=3D NULL) {
>>                        ipipe_percpu_domain[cpuid] =3D next_domain;
>>                        ipipe_unlock_cpu(flags);
>> (1)
>>                        propagate =3D
>> !next_domain->evhand[event](event,start_domain,data);
>>
>> Does anything prevent another thread from preempting the current one a=
t (1)
>> and making "next_domain" invalid?
>=20
> That could explain it. I only read ipipe_lock_cpu during my first scan
> of this code earlier today, missing the unlock. One should better safe
> the handler in a local variable before releasing the lock...
>=20
>> then :
>>
>> if next_domain =3D=3D "rthal_domain" (aka Xenomai)  -  e.g. someone un=
loaded
>> all
>> the modules.
>>
>> then if it's static :
>>
>> rthal_domain is still kind of a valid object - it's at least in a vali=
d
>> memory region + evhand points to a valid function. It's even possible =
to
>> jump to the next element if the rthal_domain::fields were not cleared.=
=2E.
>>
>> non-static :
>>
>> the module image was unloaded, next_domain doesn't point to anything
>> reasonable.
>=20
> Mmh, we probably need some grace period on unload to avoid such races.
> Reminds me of issues with the IRQ proc output or the shared IRQ
> deregistration...
>=20
>> Jan or Nils, what instructions does "objdump -d kernel/ipipe/core.o" s=
how
>> for a given offset in the __ipipe_dispatch_event().
>>
>> 0xcd in case of Nils.
>>
>> [<c013f158>] __ipipe_dispatch_event+0xcd/0xeb
>>
>> ?
>>
>>
>=20
> Will check this tomorrow.

It's the indirect call to the event handler.

   8b3:   8b 55 e4                mov    0xffffffe4(%ebp),%edx
   8b6:   50                      push   %eax
-> 8b7:   ff 94 93 80 22 00 00    call   *0x2280(%ebx,%edx,4)
   8be:   83 c4 0c                add    $0xc,%esp
   8c1:   85 c0                   test   %eax,%eax

In my case the kernel tries to access the address 0xd09bc5e5 which seems
like it used to be a valid one.

So this looks like we really need some mechanism to make sure all CPUs
use the updated pointers after unhooking some event handler and before
proceeding with further cleanups. Sounds like a job for RCU, but we
don't have such stuff over 2.4.

Jan


--------------enig0D1C0D91EF45654BB843986C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFB8SnniDOoMHTA+kRAnwBAJ9WzPrWwpMKxzjNjMBBDjXjpSNc1QCfV8Cq
uNcRdALMAoJU4TlTvIBMfJE=
=VbrR
-----END PGP SIGNATURE-----

--------------enig0D1C0D91EF45654BB843986C--

