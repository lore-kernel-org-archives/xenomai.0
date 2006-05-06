Message-ID: <445C59C9.8020107@domain.hid>
Date: Sat, 06 May 2006 10:09:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF55C880ECC5751BCE4E4687E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC] Micro-optimisations for the libs
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: Daniel.Rossier@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF55C880ECC5751BCE4E4687E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

[Daniel, I put you in the CC as you showed some interest in this topic.]

as I indicated a some weeks ago, I had a closer look at the code the
user space libs currently produce (on x86). The following considerations
are certainly not worth noticeable microseconds on GHz boxes, but they
may buy us (yet another) few micros on low-end.

First of all, there is some redundant code in the syscall path of each
skin service. This is due to the fact that the function code is
calculated based on the the skin mux id each time a service is invoked.
The mux id has to be shifted and masked in order to combine it with the
constant function code part - this could also easily happen
ahead-of-time, saving code and cycles for each service entry point.

Here is a commented disassembly of some simple native skin service which
only takes one argument.


Function prologue:
 460:   55                      push   %ebp
 461:   89 e5                   mov    %esp,%ebp
 463:   57                      push   %edi
 464:   83 ec 10                sub    $0x10,%esp

Loading the skin mux-id:
 467:   a1 00 00 00 00          mov    0x0,%eax

Loading the argument (here: some pointer)
 46c:   8b 7d 08                mov    0x8(%ebp),%edi

Calculating the function code:
 46f:   c1 e0 10                shl    $0x10,%eax
 472:   25 00 00 ff 00          and    $0xff0000,%eax
 477:   0d 2b 02 00 08          or     $0x800022b,%eax

Saving the code:
 47c:   89 45 f8                mov    %eax,0xfffffff8(%ebp)

 47f:   53                      push   %ebx

Loading the arguments (here only one):
 480:   89 fb                   mov    %edi,%ebx

Restoring the code again, issuing the syscall:
 482:   8b 45 f8                mov    0xfffffff8(%ebp),%eax
 485:   cd 80                   int    $0x80

 487:   5b                      pop    %ebx

Function epilogue:
 488:   83 c4 10                add    $0x10,%esp
 48b:   5f                      pop    %edi
 48c:   5d                      pop    %ebp
 48d:   c3                      ret


Looking at this code, I also started thinking about inlining short and
probably heavily-used functions into the user code. This would save the
function prologue/epilogue both in the lib and the user code itself. For
sure, it only makes sense for time-critical functions (think of
mutex_lock/unlock or rt_timer_read). But inlining could be made optional
for the user by providing both the library variant and the inlined
version. The users could then select the preferred one by #defining some
control switch before including the skin headers.

Any thoughts on this? And, almost more important, anyone around willing
to work on these optimisations and evaluate the results? I can't ATM.

Jan


--------------enigF55C880ECC5751BCE4E4687E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEXFnJniDOoMHTA+kRArGeAJ9NTkgXzwxmkn0rbiDBh4dAnk3PoQCfUP2S
6ErnnJwNWo5tOZGcjg6KTsk=
=grRp
-----END PGP SIGNATURE-----

--------------enigF55C880ECC5751BCE4E4687E--

