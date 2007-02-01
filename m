Message-ID: <45C1C482.4000207@domain.hid>
Date: Thu, 01 Feb 2007 11:44:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Running real time task on one of the cores of
	a Dual	Core CPU
References: <2284653.1170323957613.JavaMail.ngmail@domain.hid>
In-Reply-To: <2284653.1170323957613.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig79CB8578A8ABD9DBA48B0051"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79CB8578A8ABD9DBA48B0051
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi all,
>=20
> I have some results and some questions on running Xenomai on a Dual Cor=
e CPU.
> At my PC I have a Pentium D CPU (3.2 GHz), kernel 2.6.19.2, Xenomai 2.3=
 + some COW patches.
> In the kernel I have enabled SMP.
>=20
> The first interesting thing I noticed is that this kernel seems to run =
all standard processes
> on core 0. The kernel does not automatically distribute processes on tw=
o cores.
> I think I saw a different behaviour with an earlier kernel version (2.6=
=2E17 or even 2.4.33).
> I do not have to use the isolcpus kernel parameter to force running all=
 user space tasks on core 0.
> This is exactly the thing I wanted to have. All "standard" linux tasks =
are running
> on core 0.
> Does anybody know if there was a change in the kernel?
>=20
> Now I placed all real time tasks from Xenomai on core 1. This works fin=
e.
> My application calculates periodically a fairly complex simulation mode=
l. The interesting thing
> is now, that the computation time needed for this model is much more co=
nstant in opposite to the
> UP mode. On an UP system I had computation times between 111 and 170 mi=
croseconds.
> With the SMP system I have now computation times between 111 and 115 mi=
croseconds.
> Great! The worst case execution time is very close to the best case exe=
cution time!
> I think this is caused by a more deterministic usage of the cache for t=
he real time system.
> In the UP system the cache cannot be reserved for the real time applica=
tion, i.e. the real time
> application has to re-read more often directly from memory.

Yep, that makes sense.

>=20
> Now my questions:
> In a setup that uses core 0 for standard linux stuff and core 1 for Xen=
omai stuff the
> Xenomai scheduler is running in SMP mode. However, I am not sure if thi=
s required in this setup.

With the current Xenomai code, this is required because you cannot
exclude that some application accidentally or intentionally forces some
threads or IRQs on CPU 0. So you would otherwise leave a fragile system
behind.

> As all real time code is bound to one core there does not have to be an=
y multi processing
> save synchronisation for the real time code.
> My proposal is to support three different scheduling modes:
> 1 - UP as now
> 2 - SMP as now
> 3 - UP on a certain core: All real time code runs on one (runtime selec=
table) core even
> if the linux kernel is fully SMP. This should increase the performance =
as inter CPU
> protection is not required for the real time code.
> Any comments on this idea are welcome!

Even more generic ideas in this direction are haunting in my head for
quite some time, but no concrete design nor some implementation roadmap
exist yet.

The approach is basically to revamp SMP support so that you are able to
declare whatever core object (threads, IPC objects, devices, etc.)
CPU-local, thus avoiding the need to use SMP locking for it, but also
install safety belts that prevents you from accidentally accessing such
objects from remote CPUs. In other words: instead of one global
cross-CPU nucleus lock, per-CPU nklocks (which means IRQ disable) +
classic spinlocks for those objects that are still used across CPUs.

One may think about an intermediate step: create a Xenomai variant that
builds like UP over an SMP kernel and binds only to one CPU. But I
haven't looked at details and cannot asses right now if the effort would
be worth it or if we should better direct resources to the more advanced
(IMHO) design as I sketched above. Granted, the SMP revamping will be
not be trivial work (and will probably require some $funding), but UP
over SMP will waste CPUs for RT usage once we are no longer just talking
about *dual* cores...

> I also use rtnet. Unfortunately I am not able to force rtnet (RTDM base=
d) to run on CPU core 1
> without patching the RTDM code.
> A couple of months ago, I already asked for this issue.
> Jan, can you tell me the latest news regarding this issue?

The global affinity mask is now part of Xenomai 2.3 (though I haven't
tested it again after it was merged). What part of RTnet precisely is
resisting to move to CPU 1, or what do you currently have to patch?

Jan


--------------enig79CB8578A8ABD9DBA48B0051
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwcSCniDOoMHTA+kRAqDqAJ0U+VEG1cJM+9CvFm1AzgT1TkfFvwCfWBfn
vURwVUBHmNqwi2llZs4GifU=
=CgGB
-----END PGP SIGNATURE-----

--------------enig79CB8578A8ABD9DBA48B0051--

