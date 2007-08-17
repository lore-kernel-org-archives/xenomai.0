Message-ID: <46C59855.7030902@domain.hid>
Date: Fri, 17 Aug 2007 14:45:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C590D5.1060507@domain.hid>
In-Reply-To: <46C590D5.1060507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig10022AE9790D730D4E0C4378"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Time for rt_mutex_acquire
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dirk Eibach <eibach@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig10022AE9790D730D4E0C4378
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
> gilles.chanteperdrix@xenomai.org wrote:
>> On 8/17/07, Dirk Eibach <eibach@domain.hid> wrote:
>>> gilles.chanteperdrix@xenomai.org wrote:
>>>> Dirk Eibach wrote:
>>>>  > Hello,
>>>>  >
>>>>  > I'm wondering how long a rt_mutex_acquire is supposed to take on =
a PPC405
>>>>  > platform. I'm getting times about 50 usec here, which is too much=
 for my
>>>>  > application. Is anything wrong in my kernel/xenomai configuration=
 or is
>>>>  > this time to expected?
>>>>
>>>> How do you measure this ? Are you sure the mutex is free when you tr=
y to
>>>> acquire it ?
>>>>
>>> I prepared a small testcase. It shows about 8.300 ticks, which is abo=
ut 30
>>> usec on my platform (266MHz).
>> Did you try to call ppc_getcounter twice in a raw to measure the
>> overhead of this function ?
>=20
> Calling ppc_getcounter twice in a raw results in 116 ticks.

Is that service RT-safe, means does it stay in user space and issue no
Linux syscall? Maybe some of the PPC gurus can comment on this as well
(/me is lacking comparative numbers).

Besides this, you may want to try running the latency tracer on your
scenario. xntrace_user_start() and xntrace_user_stop(0) would frame the
path you want to measure, /proc/ipipe/trace/frozen will show its kernel
side. For sure, that tool will increase the latency even more, but it
may show better what goes on.

Jan


--------------enig10022AE9790D730D4E0C4378
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGxZhVniDOoMHTA+kRArQMAKCAVydlpOuu0WPKK9bAwVoMP/+mOACdF9j6
mAG8dN8gwvgRoGUO6lkDW50=
=O+QA
-----END PGP SIGNATURE-----

--------------enig10022AE9790D730D4E0C4378--

