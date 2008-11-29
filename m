Message-ID: <493099C6.1070807@domain.hid>
Date: Sat, 29 Nov 2008 02:24:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200811281535.7647@domain.hid>
	<200811281536.819@domain.hid>	<200811281537.16959@domain.hid>
	<200811281538.1680@domain.hid>	<200811281539.441@domain.hid>
	<200811281540.19192@domain.hid>	<200811281541.22553@domain.hid>
	<200811281542.10754@domain.hid> <200811281542.2528@domain.hid>
In-Reply-To: <200811281542.2528@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC616B3E4F0BFA92080C5D6E7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Hang at glibc time() function call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC616B3E4F0BFA92080C5D6E7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
> Hello,
> we have a problems with hanging of our real-time application. In fact, =
the computer stops to respond totally.
> I succeeded to find the exact hang position in couple of our tasks (but=
 not all of them) by setting of some digital outputs of HW device:
> 1) The most real-time task with the highest priority is still running a=
s it should be (100us period).
> 2) Some of the tasks are in "sleep" state. They are waiting on some eve=
nt or timeout.
> 3) One low priority task seems to be blocked at glibc time() function c=
all.

Is the low priority task also mapped as Xenomai task? In that case
calling standard Linux time services can be lethal:

If the Linux clocksource is TSC or HPET, glibc will use a syscall-less
variant for time of day reading. That variant has two properties:

A) It doesn't switch Xenomai task into secondary mode like ordinary
   syscalls do.

B) It can deadlock with the Linux kernel, leaving the caller spinning
   forever so that Linux is no longer executed.

The testsuite's clocktest used to have this issue as well (luckily, I
was able to analyze it over KVM with a source level debugger :) ).

Jan


--------------enigC616B3E4F0BFA92080C5D6E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkkwmc4ACgkQniDOoMHTA+n5EwCffjdkY4Isxx2uJBGKKfwg0ZTh
zAsAn1ceG0TqYWDjMiruumcaB1OA8kHx
=5Oul
-----END PGP SIGNATURE-----

--------------enigC616B3E4F0BFA92080C5D6E7--

