Message-ID: <44A2491D.5040102@domain.hid>
Date: Wed, 28 Jun 2006 11:17:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 2/6] Improve fault report
References: <20060626172116.019532000@domain.hid>	
	<20060626172118.347530000@domain.hid>
	<1151480559.5154.2.camel@domain.hid>	 <44A234F9.9010705@domain.hid>
	<1151481889.5154.14.camel@domain.hid>	 <44A23B66.7070202@domain.hid>
	<1151483788.5154.22.camel@domain.hid>	 <44A24308.70703@domain.hid>
	<1151485207.5154.28.camel@domain.hid>
In-Reply-To: <1151485207.5154.28.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig35FB6F728DF96B93A0BFAD71"
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
--------------enig35FB6F728DF96B93A0BFAD71
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-06-28 at 10:51 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2006-06-28 at 10:18 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Wed, 2006-06-28 at 09:51 +0200, Jan Kiszka wrote:
>>>>>> Philippe Gerum wrote:
>>>>>>> On Mon, 2006-06-26 at 19:21 +0200, jan.kiszka@domain.hid wrote:
>>>>>>>> plain text document attachment (enhance-kernel-fault-report.patc=
h)
>>>>>>>> Introduce xnarch_fault_um() to test if a fault happened in user-=
mode and applies the new feature to report core and driver crashes more v=
erbosely.=20
>>>>>>>> 	if (xnpod_shadow_p()) {
>>>>>>>>  #ifdef CONFIG_XENO_OPT_DEBUG
>>>>>>>> -		if (xnarch_fault_notify(fltinfo))	/* Don't report debug traps=
 */
>>>>>>>> +		if (!xnarch_fault_um(fltinfo)) {
>>>>>>>> +			xnarch_trace_panic_freeze();
>>>>>>> KGDB breakpoint issue?
>>>>>> Sorry, please switch on verbose mode, didn't get yet what you mean=
=2E
>>>>> Oops, sorry. I meant: what if a KGDB breakpoint is hit from kernel =
space
>>>>> while running a shadow thread? The way I read the modified test seq=
uence
>>>>> above, such bp trap is going to trigger a panic, instead of being
>>>>> silently passed to Linux.
>>>> I would say: KGDB will not come along here with a breakpoint. It sho=
uld
>>>> already got involved in __ipipe_divert_exception().
>>> Ok, so the only problem that remains would be inlined asm("int 1/3") =
in
>>> kernel space not handled by KGDB (whether the KGDB patch is in or not=
).
>>> I'm still scratching my head pondering if we can live with this or no=
t.
>> But this is perfectly one of the situations my patch tries to catch: a=

>> fatal bug in the kernel! Such a hand-coded kernel breakpoint without a=

>> debugger caring is a bug to me.
>=20
> Not that sure: passive debug code may exist. Only the presence of the
> debugger should activate it.
>=20

=2E..but remains a bug for me /w RT code. We now complain about this
exception happened. And there is no crash/BUG in this case, just a
desirable warning with back-trace in the log.

Jan


PS: Other OSes show you a nice blue-screen when they ran on such
orphaned breakpoints.


--------------enig35FB6F728DF96B93A0BFAD71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEokkeniDOoMHTA+kRAj86AJ9ufp0MijEUFVYMszc63J4ARs5EbwCeKoOW
b5nuEZOCHWME20VorXSAPoI=
=43J8
-----END PGP SIGNATURE-----

--------------enig35FB6F728DF96B93A0BFAD71--

