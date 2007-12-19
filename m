Message-ID: <47693FE6.30707@domain.hid>
Date: Wed, 19 Dec 2007 16:59:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5864711.1198077318353.JavaMail.ngmail@domain.hid>
In-Reply-To: <5864711.1198077318353.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF47BC3C6DE20E75A5946F9E1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RTnet-users] /proc/xenomai/affinity and
	T_CPU(n) in rt_task_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF47BC3C6DE20E75A5946F9E1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I am currently evaluating the latest Xenomai release 2.4.0 on a Dual Co=
re Pentium 4 using
> the 2.6.23 kernel and also the latest rtnet 0.9.10-rc1.
> I have one question concerning the relation of the /proc/xenomai/affini=
ty entry and the parameter
> T_CPU(n) I pass with rt_task_create (native API).
> If I set /proc/xenomai/affinity to 1 (which means to run all real time =
tasks on CPU 0). I am not allowed
> to pass T_CPU(1) with rt_task_create. rt_task_start returns with a -EIN=
VAL.
>=20
> Background for my question is:
> rtnet uses a internal system task For this task I cannot pass the CPU I=
 want to run this CPU on.
> My idea is now to set /proc/xenomai/affinity to 1 which means (in my mi=
nd) that all tasks that do
> not have specified explicitly a task number (T_CPU(n)) will run on the =
CPU(s) specified by /proc/xenomai/affinity.
> All those tasks that specify T_CPU explicitly will run on the specified=
 CPU, no matter what value=20
> /proc/xenomai/affinity is.
> However, this seems not to work.

Yes, the development version used to have this behaviour. But it didn't
work out for skins like POSIX where there is no clear
I-don't-care-about-affinity state on thread creation. So we switched to
unconditional enforcement before the final release (don't have the
thread at hand, but you can find it in the xenomai-core archive). Sorry
for the inconvenience, but it was unavoidable.

>=20
> I want to run rtnet on CPU 0 and my own code on CPU 1. For this I write=
 1 to /proc/xenomai/affinity and=20
> pass T_CPU(1) with all my calls to rt_task_create. However, these tasks=
 return with -EINVAL.
> I debugged into Xenomai and found out that is caused in xnpod_start_thr=
ead() at the condition
> if (xnarch_cpus_empty(thread->affinity)) ...
>=20
> When I write 3 to /proc/xenomai/affinity my tasks start fine, however I=
 have now no control of the
> CPU placement of the rtnet system task.
>=20
>=20
> Any hints on that are highly welcome.

Suggested procedure:
1. set global affinity for RTnet and start up the stack
2. set global affinity for your application (or open it) and start that
   one up

Or do you have any tricky dependencies that work against this approach?

Jan


--------------enigF47BC3C6DE20E75A5946F9E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHaT/nniDOoMHTA+kRAkDBAJ9z1kPw3FWcxNHOaI72jeP7W57q2ACfejnm
bdvkDQ4MI73nON7jneq2IZ8=
=x9EA
-----END PGP SIGNATURE-----

--------------enigF47BC3C6DE20E75A5946F9E1--

