Message-ID: <4548F8BE.90809@domain.hid>
Date: Wed, 01 Nov 2006 20:42:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [Xenomai-help] invalid use of FPU in Xenomai context]
References: <4548C170.1000504@domain.hid>
In-Reply-To: <4548C170.1000504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFD425C7F317C69668C7794D4"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD425C7F317C69668C7794D4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Jeff Webb wrote:
>> If I run the attached program, I get the following result:
>>
>>  [root]# ./mqtest2
>>  CPU time limit exceeded
>>
>> The kernel log contains:
>>
>>  Oct 25 14:13:03 kernel: invalid use of FPU in Xenomai context at
>> 0x80492f6
>=20
> I have another piece of information on this problem.  I was able to tes=
t
> the program on two other machines: an Athlon XP, and a PIII laptop.  Th=
e
> program works on the PIII, but fails on the Athlon XP.  I then compiled=

> a new kernel, selecting the "Pentium-Pro" processor family instead of
> the "Athlon/Duron/K7" processor family.  The mqtest2 program now works
> on my Athlon64 X2 and Athlon XP systems, if I use the "Pentium-Pro" ker=
nel.
>=20
> Here is a summary of what I tried:
>=20
> Machine #1: AMD Athlon(tm)64 X2 Dual Core Processor  4400+
>        OS: Fedora Core 5
> a) Linux SMP 2.6.17.13 (K7 config) / Xenomai 2.2.4 -> mqtest2 fails
> b) Linux SMP 2.6.17.13 (K7 config) / Xenomai trunk r1749 + patch ->
> mqtest2 fails
>   patch =3D https://mail.gna.org/public/xenomai-core/2006-10/msg00069.h=
tml
> c) Linux UP 2.6.17.13 (K7 config) / Xenomai 2.2.4 -> mqtest2 fails
> d) Linux SMP 2.6.17.13 (K7 config) / Xenomai 2.2.1 -> mqtest2 fails
> e) Linux UP 2.6.17.13 (ppro config) / Xenomai 2.2.4 -> mqtest2 WORKS!
>=20
> Machine #2: AMD Athlon(tm) XP 3200+
> a) Fedora Core 1 / Linux 2.4.32 (K7 config) / Xenomai 2.2.3 -> mqtest2
> fails
> b) Fedora Core 5 / Linux 2.6.17.13 (ppro config) / Xenomai 2.2.4 ->
> mqtest2 WORKS!
>=20
> Machine #3: Intel Pentium III Mobile CPU
> OS: Debian Unstable (old)
> Linux 2.4.33.3 (ppro config) / Xenomai 2.2.4 -> mqtest2 WORKS!
>=20
> So, it seems that a bug is introduced when compiling for the AMD K7
> family.  Is the mqtest2 problem a compiler optimization bug, a Linux
> bug, a Linux configuration problem, a Xenomai bug, or a problem in my
> code?  Any ideas on how to proceed?  I am not familiar with the Xenomai=

> internals or low-level x86 code, but I will do what I can to help debug=

> this.
>=20
> Does anyone else have an AMD system that can verify my results?

I have an old Athlon 800. Maybe we are lucky and it exposes the problem
when the kernel is optimised for it. I'm going to give this a try, but
it may take a few days (and a free time slot).

>=20
> The mqtest2.c program in question was attached here:
>  https://mail.gna.org/public/xenomai-help/2006-10/msg00147.html
>=20
> The problem seems to be connected with the size of writes to Xenomai
> pipes.  This example uses POSIX message queues, but I had a similar
> problem a while back with RTAI pipes.  Maybe this tells us the problem
> is in the nucleus pipe code?  Just a guess.  The problem seems to affec=
t
> both 2.4 and 2.6 systems, and goes back to at least Xenomai 2.2.1.

Maybe, maybe not. Pipes remain fairly unrelated to FPU usage, so there
is still /at least/ one piece missing in the puzzle.

BTW, did you already write what compiler version you are using for these
tests (/me too lazy to search the archives)?

Jan


--------------enigFD425C7F317C69668C7794D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFSPjCniDOoMHTA+kRAlaZAKCETc3KTLR9qXO+ZHjIm7OarwKYjwCfd1Zs
zr1oefOiwKs879LWQwRxXF8=
=mjBB
-----END PGP SIGNATURE-----

--------------enigFD425C7F317C69668C7794D4--

