Message-ID: <4779000C.9050403@domain.hid>
Date: Mon, 31 Dec 2007 15:43:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b131c9f0712300411w46996c98i395344b377c6bacf@domain.hid>	<200712310033.05927.paul_c@domain.hid>
	<b131c9f0712310604k2aac428rccacaf2006ecd147@domain.hid>
In-Reply-To: <b131c9f0712310604k2aac428rccacaf2006ecd147@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig326F0BEB24219E75FA840ABC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Large (negative) latency test results and fast
 PC clock
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig326F0BEB24219E75FA840ABC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

vikesh rambaran wrote:
> Hi
>=20
> Thanx for taking the time to reply over this festive season !
>=20
> Although suboptimal for this PC, i am compiling using ubuntu's default
> config file.
> The idea is to make a general kernel image .deb file which can be used =
to
> install
> xenomai on older PC architectures (not necessarily AMD 64 bit CPUs)
> Therefore the processor shows up as "CONFIG_M586"

But will there be CPUs included that don't have TSC support? If not,
choose at least a type that tells Xenomai it can use the TSC and does
not have to fall back to slow PIT-based emulation for timekeeping.

>=20
> This seems to be what Paul is making available as well - thanx i will t=
ry
> them out.
>=20
> Jan, i have checked the kernel config file. The following are set
>=20
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
>=20
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
>=20
> Is this combination a problem ?

Yes, because with TSC being officially available, Xenomai uses the PIT
for timekeeping. At the same time, HPET_TIMER disables the PIT. That's
my theory ATM. Could you validate it by disabling CONFIG_HPET_TIMER?

> dmesg shows that the APIC is configured and enabled, but no information=
 of
> the HPET is displayed. (dmesg output is attached)
>=20
> I have not been able to find the message "NOTE: Xenomai needs either
> X86_LOCAL_APIC enabled or HPET_TIMER disabled."
> during kernel configuration (make menuconfig) or during the xenomai
> configuration. Is there a specific place where i should look ?

It would pop up on top of the Xenomai submenu. But as the local APIC is
on, this will not trigger anyway. If my theory is correct, we need to
enhance the condition for the warning.

>=20
> To build the kernel image package i used
>=20
> fakeroot makekpkg --initrd --append_to_version "-adeos-realtime"
> kernel_image kernel_headers
>=20
> For the xenomai configuration i used
>=20
> ./configure --disable-x86-tsc
>=20
>=20
> Note, on this same PC, using ubuntu 6.06, kernel 2.6.20.12, xenomai 2.3=
=2E1,

According to your logs, you are using Xenomai 2.4.

> the latency test runs without large
> (negative) latencies and no noticeable PC clock speedup. Test configura=
tion
> was also for CONFIG_M586=3Dy
> but with SMI workaround not enabled.
>=20
> Please let me know if any other information that i can provide or tests=
 that
> can be done to solve this.
>=20
> Thanx for your help
> Vicki
>=20

Jan


--------------enig326F0BEB24219E75FA840ABC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHeQARniDOoMHTA+kRAkWeAJ91RQKVjOsVLbTwGJTCYpJcIZJSYQCdHuWk
AQOpCYPqC6Hgoqe712YWMuY=
=XREX
-----END PGP SIGNATURE-----

--------------enig326F0BEB24219E75FA840ABC--

