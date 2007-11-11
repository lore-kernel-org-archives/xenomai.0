Message-ID: <47373FBE.6070301@domain.hid>
Date: Sun, 11 Nov 2007 18:45:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47373B12.7020808@domain.hid> <47373CB9.2010104@domain.hid>
In-Reply-To: <47373CB9.2010104@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCADFCD502F0A3584F1993DAF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] x86_64: problems with syscall tracing?
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCADFCD502F0A3584F1993DAF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe,
>>
>> you recently said there is a bug in the x86_64 support when syscall
>> tracing is enabled. Now I think I stepped on it as well: In order to
>> validate my APIC frequency patches for that arch, I wanted to use LTTn=
g
>> there. But as soon as I start the trace, the latency test fails to run=
,
>> prematurely exiting due to a segfault.
>=20
> Exactly what Gilles sees on his box too, latency segfaulting at startup=
=2E
> On mine, the kernel does not even boot.
>=20
>  Gdb and the kernel say that user
>> land jumped to address 0, I just yet failed to find out where they com=
e
>> from. I strongly assume LTTng enables syscall tracing, because its
>> entry/exit instrumentations are inside the hook function
>> (syscall_trace_entry/leave).
>>
>> Do you have any further details on your tracing issue? Does may
>> observation correlates with yours?
>=20
> Quite frankly, I did not dig the issue that far yet, but yes, my first
> impression is that something is broken in the syscall return path (or
> entry?), and it shows when the return path to user-space is diverted in=

> some way, either for security auditing, or likely for tracing like
> you've just reported.

I once got this path into qemu+gdb, but did not trapped a case where the
kernel decides to mess things up and return to NULL. Anyway, this
debugging was not fully reliable, and I will retry soon (once my target
has finished installing a new, full-blown 64-bit distro).

Beside this, I already tried to analyse the return path but found
nothing obvious on first sight. Hmm, wait, if tracing is enabled and we
return from a Xenomai-handled syscall, I guess everything could go wrong
if we then run into syscall_trace_leave over non-root domains, right?
Maybe I should check if this could/actually does happen.

[This bug is annoying. I have a huge pile of new patches here, all just
waiting to be tested, and then this... :-/]

Jan


--------------enigCADFCD502F0A3584F1993DAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHNz++niDOoMHTA+kRAid3AJ0UXIxiv3hnreewjEYpkcDupnnZOwCdE763
FP3zvd+Uax2Cp+t4C6gN3wg=
=pFXr
-----END PGP SIGNATURE-----

--------------enigCADFCD502F0A3584F1993DAF--

