Message-ID: <44A234F9.9010705@domain.hid>
Date: Wed, 28 Jun 2006 09:51:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 2/6] Improve fault report
References: <20060626172116.019532000@domain.hid>	
	<20060626172118.347530000@domain.hid> <1151480559.5154.2.camel@domain.hid>
In-Reply-To: <1151480559.5154.2.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig758D42C6B2A07B0F823BA5F6"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig758D42C6B2A07B0F823BA5F6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2006-06-26 at 19:21 +0200, jan.kiszka@domain.hid wrote:
>> plain text document attachment (enhance-kernel-fault-report.patch)
>> Introduce xnarch_fault_um() to test if a fault happened in user-mode a=
nd applies the new feature to report core and driver crashes more verbose=
ly.=20
>=20
>> 	if (xnpod_shadow_p()) {
>>  #ifdef CONFIG_XENO_OPT_DEBUG
>> -		if (xnarch_fault_notify(fltinfo))	/* Don't report debug traps */
>> +		if (!xnarch_fault_um(fltinfo)) {
>> +			xnarch_trace_panic_freeze();
>=20
> KGDB breakpoint issue?

Sorry, please switch on verbose mode, didn't get yet what you mean.

>=20
>> +			xnprintf
>> +			    ("Switching %s to secondary mode after exception #%u in "
>> +			     "kernel-space at 0x%lx (pid %d)\n", thread->name,
>> +			     xnarch_fault_trap(fltinfo),
>> +			     xnarch_fault_pc(fltinfo),
>> +			     xnthread_user_pid(thread));
>> +			xnarch_trace_panic_dump();
>> +		} else if (xnarch_fault_notify(fltinfo)) /* Don't report debug trap=
s */
>=20

Jan


--------------enig758D42C6B2A07B0F823BA5F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEojT6niDOoMHTA+kRAih7AJ9xKrfkxXaObLhLVJgbZUzShmMNlgCeIWa2
gRvmoN+PUoElcZ3vglvTzj8=
=GWr1
-----END PGP SIGNATURE-----

--------------enig758D42C6B2A07B0F823BA5F6--

