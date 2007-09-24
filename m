Message-ID: <46F7F868.2050904@domain.hid>
Date: Mon, 24 Sep 2007 19:48:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <899865CA54E4444DAF2E3639C04C5F4805ED13@domain.hid>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805ED13@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig72A69E2B93E1531DD12CA8BA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC] Fast Context Switch Extension for ARM Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72A69E2B93E1531DD12CA8BA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Richard Cochran wrote:
> I know that this is a bit off topic, yet perhaps some on this list
> have interest or knowledge in this area. I am also posting this idea
> to the linux-arm-kernel list.
>=20
> I would like to implement the ARM FCSE under Linux, using the Intel
> IXP425 board. Before I start, I would like to ask:
>=20
> 1. Has any work already been done in this area?
>=20
> 2. Is there something about the current Linux MM that would make this
>    impractical?

Nothing is impossible (specifically as FASS proves its feasibility),
it's just a question how much work it is to implement it AND maintain it
or merge it into standard Linux. And I cannot imagine ARM or its
licensees dropping this feature without an acceptable alternative once
Linux started to use it broadly...

>=20
> 3. Does anyone else have interest in this?

I can only repeat that I think this is a worthwhile effort - at least
until we know the real effort required for hacking this into Linux and
then Xenomai :). It would be really great for ARM real-time applications
if you could once isolate then in their own address range, reducing the
context switch latencies significantly!

So, please try to find out more details about the requirements and
limitations, let us know about them even if some realisation turns out
to be too much for a student job. Maybe other will jump on this, maybe I
can organise some support then (no promise, consider this yet as my
private idea... :) ).

>=20
> I had once proposed this task as a student project, and so I append
> the long project description, below.
>=20
> Thanks,
> Richard
>=20
> ARM Fast Context Switch Extension for Linux
>=20
> Motivation
>=20
>  The ARM v5 CPUs are inexpensive, low power, 32 bit processors widely
>  used in embedded systems. However, because of these processors' cache
>  implementation, using memory protection on these systems may incur a
>  performance penalty that is too great for real time applications. The
>  aim of this study is to achieve both memory protection and good cache
>  performance under the Linux 2.6 operating system, by implementing
>  the Fast Context Switch Extension (FCSE).
>=20
> Task
>=20
>  ARM v5 processors access the cache by virtual addresses. As a result,
>  the cache is invalidated after a context switch, since no two
>  processes share the same address space. Reloading the cache from main
>  memory is a very expensive operation.
>=20
>  One approach to address this problem, used for example in vxWorks or
>  uClinux, is to use one "flat" address space, shared by the operating
>  system kernel and all user processes. This avoids the context switch
>  penalty while sacrificing memory protection. The obvious drawback
>  under this scenario is that any one misbehaving program can corrupt
>  the kernel or other programs.
>=20
>  Another solution, not yet implemented under Linux, is to use the
>  "Process ID" register found on some ARM CPUs, for example the Intel
>  IXP425. This register contains a 7 bit process identifier that can be
>  combined with a 25 bit virtual address. Using this method allows 128
>  distinct 32 MB address spaces, so that up to 128 processes may safely
>  co-exist, without paying the context switch penalty. The resulting
>  limitation of 128 processes and 32 MB address space is acceptable for
>  many embedded systems.
>=20
>  The tasks of this study would be:
>=20
>  1. Research and summarize the existing work in this area.
>=20
>  2. Benchmark the current implementations to demonstrate the problem,
>     using "standard" Linux, Xenomai, and the PREEMPT_RT patch set.
>=20
>  3. Illuminate the Linux memory management subsystem.
>=20
>  4. Implement FCSE in the Linux memory management subsystem.
>=20
>  5. Benchmark the result of the improved kernel.
>=20
> Selected references:
>=20
> o A short summary of the issue and the approach used by QNX:
>   http://www.qnx.com/developers/docs/6.3.0/neutrino/prog/arm_memory.htm=
l
>=20
> o Context Switching and IPC Performance Comparison between uClinux and
>   Linux on the ARM9 based Processor
>   http://opensrc.sec.samsung.com/document/uc-linux-04_sait.pdf
>=20
> o Fast Address-Space Switching for ARM Linux Kernels
>   http://www.ertos.nicta.com.au/software/fass/

The "funny" thing is that some marketing people use this to argue that
para-virtualised Linux over some specific microkernel is even faster
than native Linux. They just forget to mention the minor technical
details about the origin and the domain of these numbers.

>=20
> o Context Switch Overheads for Linux on ARM Platforms
>   http://choices.cs.uiuc.edu/contextswitching.pdf
>=20

Jan


--------------enig72A69E2B93E1531DD12CA8BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG9/honiDOoMHTA+kRAl+hAJ0R0Y05HvHfj3ziktLGTut8kwC+NgCeIIG6
AOUeM8GstHPhq3T+jcIpwnw=
=YbDD
-----END PGP SIGNATURE-----

--------------enig72A69E2B93E1531DD12CA8BA--

