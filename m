Message-ID: <479A38CF.6070209@domain.hid>
Date: Fri, 25 Jan 2008 20:30:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4e0b9cb00801240505y77d71956w994e312be382f91b@domain.hid>
In-Reply-To: <4e0b9cb00801240505y77d71956w994e312be382f91b@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAB7E50113EE2B2708B923576"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Some beginner technical questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Remi Lefevre <rlefevre@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB7E50113EE2B2708B923576
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Remi Lefevre wrote:
> Hi, I try to really understand the Xenomai design & behavior and have
> a few technical questions for which I can't find exact answers on
> documentations or mailing list :
>=20
> - What is the overhead of the Adeos/I-Pipe layer on non RT Linux tasks
> (including linux kernel) ?
> This surely depends on interrupts number, but perhaps some results on
> a particular platform exist.

It also depends on the architecture and CPU speed. I can't provide
up-to-date numbers, and the best for you is anyway to evaluate
specifically your desired platform. This could mean running typical
Linux benchmark (eg. lmbench) on kernels with and without I-pipe +
Xenomai. You are always welcome to publish results and discuss them with =
us.

>=20
> - When using RTnet, I understand that non RT Linux tasks uses a
> virtual network device linked to the RTnet one, so what performance
> impact does this have on non RT network bandwidth ?

That depends. First of all, you only have to use the the virtual NICs
when you have to share the RT Ethernet link with non-RT traffic.
Otherwise you could simply use standard networking without penalties. If
VNICs are to be used, the performance Linux sees heavily depends on the
RTmac discipline and its configuration (e.g. the TDMA slot layout). Feel
free to continue on this topic on the rtnet-user list.

>=20
> I saw on some introduction slides that an arinc 653 skin would be possi=
ble.
> Emulating the arinc 653 is certainly possible, but if a real arinc 653
> system is considered, this raises a few technical issues.
> - Is the nucleus memory space protected from the Linux kernel (at
> least in primary mode) ? If not, would this be possible ?

Nucleus, skins, and Linux kernel share the same memory space and run at
the same privilege level. This enables very advanced Linux integration
of RT threads and significantly reduces the performance impact on Linux
(and/or the need to add emulation/paravirtualisation code).

Before thinking about any design to add such memory protection domains
for Linux and I-pipe/Xenomai, it should be clarified what level of
protection is required. Full protection means not just establishing
separate memory domain, but also pushing Linux out of the supervisor
mode. And that means a lot of work - to provide all the trusted hardware
drivers in the context of some hypervisor, because Linux is untrusted
and unprivileged then.

Some less drastic approach might be to isolate the Nucleus from Linux,
but to trust Linux (and it's drivers) to
 a) not install invalid page tables and
 b) not program DMA-capable hardware with invalid addresses.

But I can't comment on if this approach is acceptable for whatsoever
"critical" ARINC 653 application (and its potential certification).

> - It seems from what I understand that nucleus implements threads, but
> not processes (like others RTOS), does this mean that they all share
> the same memory space ?

If you write your applications for the Linux kernel space (not
recommended!), then they share the memory space with everything else in
the kernel. But when you write user space applications, Xenomai reuses
the process abstraction and protection Linux already provides. So,
process are protected from each other, even if they include Xenomai RT
threads.

> - Can the nucleus kernel still run if the Linux kernel crashes (which
> happens in ring 1 mode on x86 if I'm correct) ?

[Linux runs at ring 0 - don't trust old written concepts of Adeos.]
There are certain fault scenarios of the Linux kernel which will not
impact the nucleus - but that should be carefully analyzed for the
particular system (as you do with _every_ critical system anyway).

> - Or more generally, what Linux kernel services are used by nucleus
> (it seems at least the memory allocation ones) ?

What is a "Linux kernel service" for you? Some potentially blocking or
failing kernel subsystem or also some inline functions from Linux
headers etc.? Bugs aside, the former is definitely not the case while
the later is unavoidable for certain shared services (which are
generally checked on kernel updates and/or with the help of kernel
instrumentations).

> - This is linked to the previous questions, but if we wanted to remove
> everything from the Linux kernel that is not used by Xenomai, what
> would be necessary to keep ?

For what level of Xenomai services? Something like a stand-alone nucleus
+ in-kernel applications? In any case, Xenomai is built on the
environment that Linux provides, with all the platform and peripheral
hardware initialized and managed later on. So it heavily depends on what
you want for such a scenario, and then you will have to provide it on
your own (look at what Xen does these days: reimplementing wide parts of
the tricky board setup that Linux normally provides - with all its quirks=
).

> - At last, is there a way to guaranty a worst case latency on Xenomai
> (even a high one) supposing we know every hardware behavior (hum...) ?

The Xenomai design is, theoretically, prepared for a comprehensive WCET
analysis. Going through the code paths that a certain application
depends on, you shall not be able to find dependencies on the timing
behavior of Linux, its lock-nestings, memory consumption, I/O load, etc.
However, deriving a reliable WCET model from this is still a challenge,
and surely not a small one. We also do not have "building blocks" for
such a model that one could use for a concrete configuration - because
no one yet needed them and/or was willing to spend the required effort.

> I'm sorry if these questions are stupid or have been answered
> previously, guiding me to the references would certainly greatly help
> me in this case.

In no way are they stupid. And I do not recall anyone asking this in
such depth before. You are welcome!

Jan


--------------enigAB7E50113EE2B2708B923576
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHmjjYniDOoMHTA+kRAqB/AJ95bJcjD570ZU2iKt9TMsDnAiDaLgCfZizP
RTlbz9YaHoSlwzJUeDx0WCE=
=hn4p
-----END PGP SIGNATURE-----

--------------enigAB7E50113EE2B2708B923576--

