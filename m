Message-ID: <450727D1.6060203@domain.hid>
Date: Tue, 12 Sep 2006 23:34:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>	
	<1158091876.5020.8.camel@domain.hid>
	<b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
In-Reply-To: <b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEB61341385ABFD8316D3048C"
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
--------------enigEB61341385ABFD8316D3048C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 12/09/06, Philippe Gerum <rpm@xenomai.org> wrote:
>>
>> On Tue, 2006-09-12 at 15:24 +0200, Nils Kemper wrote:
>> > Hi,
>> > I want to use Xenomai, but I get (sometimes, but everytime the same)=

>> > kernel-Oops just by running xeno-test:
>> >
>> > [..]
>> > Xenomai: stopping native API services.
>> > I-pipe: Domain Xenomai unregistered.
>> > Xenomai: hal/x86 stopped.
>> > Xenomai: real-time nucleus unloaded.
>>
>> Does the issue still pop up if you set the Xenomai nucleus as static
>> (i.e. not as a module) in the kernel configuration?
>=20
>=20
>=20
> Just a weird presupposition.
>=20
> In __ipipe_dispatch_event()
>=20
>  ipipe_lock_cpu(flags);
>=20
>  start_domain =3D this_domain =3D ipipe_percpu_domain[cpuid];
>=20
>  list_for_each_safe(pos,npos,&__ipipe_pipeline) {
>=20
>                next_domain =3D list_entry(pos,struct ipipe_domain,p_lin=
k);
>=20
> //...
>                if (next_domain->evhand[event] !=3D NULL) {
>                        ipipe_percpu_domain[cpuid] =3D next_domain;
>                        ipipe_unlock_cpu(flags);
> (1)
>                        propagate =3D
> !next_domain->evhand[event](event,start_domain,data);
>=20
> Does anything prevent another thread from preempting the current one at=
 (1)
> and making "next_domain" invalid?

That could explain it. I only read ipipe_lock_cpu during my first scan
of this code earlier today, missing the unlock. One should better safe
the handler in a local variable before releasing the lock...

>=20
> then :
>=20
> if next_domain =3D=3D "rthal_domain" (aka Xenomai)  -  e.g. someone unl=
oaded
> all
> the modules.
>=20
> then if it's static :
>=20
> rthal_domain is still kind of a valid object - it's at least in a valid=

> memory region + evhand points to a valid function. It's even possible t=
o
> jump to the next element if the rthal_domain::fields were not cleared..=
=2E
>=20
> non-static :
>=20
> the module image was unloaded, next_domain doesn't point to anything
> reasonable.

Mmh, we probably need some grace period on unload to avoid such races.
Reminds me of issues with the IRQ proc output or the shared IRQ
deregistration...

>=20
> Jan or Nils, what instructions does "objdump -d kernel/ipipe/core.o" sh=
ow
> for a given offset in the __ipipe_dispatch_event().
>=20
> 0xcd in case of Nils.
>=20
> [<c013f158>] __ipipe_dispatch_event+0xcd/0xeb
>=20
> ?
>=20
>=20

Will check this tomorrow.

Jan


--------------enigEB61341385ABFD8316D3048C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFByfRniDOoMHTA+kRArk9AJ0SfoTqtGBGxkYgAHTVBcD/K82G9QCfQkvt
d9V8zbbbsG1quO7T7qym5yQ=
=taWg
-----END PGP SIGNATURE-----

--------------enigEB61341385ABFD8316D3048C--

