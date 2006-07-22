Message-ID: <44C25DA7.6020302@domain.hid>
Date: Sat, 22 Jul 2006 19:17:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.2
References: <1153227929.5029.25.camel@domain.hid>	<44BE8ECF.2050608@domain.hid>	<44BE943E.80302@domain.hid>	<44BEA974.40708@domain.hid>
	<44BFC5FA.6080608@domain.hid> <44BFFC62.8030601@domain.hid>
	<44C21AF8.3000906@domain.hid>
In-Reply-To: <44C21AF8.3000906@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig35825623F054A64543E25BD2"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35825623F054A64543E25BD2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Hi Jan!
>=20
> Jan Kiszka wrote:
> [...]
>> Hmm, 2.4 limitation. There used to by some tool called ksymoops for
>> this. Please give it a try.
>=20
> hmm...so far I haven't figured out how to use ksymoops, but I got this:=


ksymoops < your-kernel-log

If you have nothing in your local logs, try to redirect the kernel
output to a serial port and capture it on a second box over null-modem.

>=20
> # addr2line -e vmlinux -f c0126f46
> __ipipe_dispatch_event
> ??:0
> # addr2line -e vmlinux -f c01160d1
> schedule
> ??:0
> # addr2line -e vmlinux -f c01266c7
> flush_scheduled_tasks
> ??:0
> # addr2line -e vmlinux -f c0105000
> _stext
> ??:0
> # addr2line -e vmlinux -f c0105080
> init
> main.c:0
> # addr2line -e vmlinux -f c010739e
> arch_kernel_thread
> ??:0
> # addr2line -e vmlinux -f c0105070
> init
> main.c:0
>=20
> Does this help ?

What about addr2line -e vmlinux -f c01d68b2?

> If not, please advise with ksymoops. (btw, there is no .ksyms file
> in /var/log/ksymoops for the boot oops)

/proc/ksyms?

>=20
>>> .config later
>=20
> Find my kernel config attached. Note that the same config without
> the periodic timer works flawlessly.

I still got no oops here, even with LAPIC on (one of the major
differences in our configs). Maybe I will try your original config later.=


But there is definitely something fishy about
adeos-ipipe-2.4.32-i386-1.2-05: my Linux clock runs about twice as fast
as it should. This doesn't happen with a comparable 2.6 setup. I still
need to check what happens without CONFIG_XENO_OPT_TIMING_PERIODIC...
Uuh, what's this now? The oops, just with "inverted" .config! And it's
inside qemu - no chance to escape then. 8)

Ok, will keep you posted!

Jan


--------------enig35825623F054A64543E25BD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEwl2rniDOoMHTA+kRAiqiAJ9sH+RH0Wgu3e1aPwA8i8oUN4EfHgCfeOCw
gIibUy/Hkf2FlvC513jDQSI=
=VyYE
-----END PGP SIGNATURE-----

--------------enig35825623F054A64543E25BD2--

