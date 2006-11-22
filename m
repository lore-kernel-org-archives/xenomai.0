Message-ID: <45640F06.5000005@domain.hid>
Date: Wed, 22 Nov 2006 09:49:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <13096879.1164184060512.JavaMail.ngmail@domain.hid>
In-Reply-To: <13096879.1164184060512.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2841E095171C1D625872A82B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] Limiting Xenomai tasks to one
 certain core in a dual	core system
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2841E095171C1D625872A82B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi all,
>=20
> I want to run Xenomai and rtnet (using RTDM) on a dual core CPU.
> Using the kernel parameter isolcpus I can force the standard Linux task=
s
> to run on one of the cores.
> The other core should be used exclusively by all real time tasks (inclu=
ding rtnet).
> I can - of course - pass a parameter on each rt_task_create() call.
> However how can I force rtnet (using RTDM) to run on this CPU core?

You hit a weak point, see the Task Market in the wiki: "CPU affinity for
RTDM threads." We both need an API for RTDM and its application on
RTnet. Not complex work, just work...

> Is there a possibility to mask the CPUs to be used globally?
> This could also avoid to pass the CPU number with each rt_task_create()=
 call.

Well, that would actually be an additional way. Yeah, maybe some global
CPU mask that controls the affinity on future thread creation. We could
export it via /proc so that you can set it right before starting a
specific group of applications and drivers.

On the long term, a control interface to the Xenomai scheduler would be
good so that things like policy, priority, time-slice, or CPU affinity
could be manipulated with some command line tool or via /proc after
thread creation.

Further feedback welcome!

Jan


--------------enig2841E095171C1D625872A82B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFZA8LniDOoMHTA+kRAuRaAJ0eLTi6D5Cmc/9FDxxiqILhp9mWMwCggFuA
XClqsR9XC5w077le31ijVJs=
=05eZ
-----END PGP SIGNATURE-----

--------------enig2841E095171C1D625872A82B--

