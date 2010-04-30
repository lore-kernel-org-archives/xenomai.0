Message-ID: <4BDA7BF7.9090507@domain.hid>
Date: Fri, 30 Apr 2010 08:43:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1271600150.git.jan.kiszka@domain.hid>	
	<4BD54515.9010101@domain.hid> <4BD5C8C4.3040207@domain.hid>
	<1272577158.24705.16.camel@domain.hid>
In-Reply-To: <1272577158.24705.16.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDF5DC396AA4CE697F50A60CC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 00/23] [git pull] procfs overflow fixes
 and seq_file conversions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF5DC396AA4CE697F50A60CC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2010-04-26 at 19:09 +0200, Gilles Chanteperdrix wrote:=20
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> The following changes since commit 113ea4d56e8b215cb56ae7673013163ea=
5a5987d:
>>>>   Gilles Chanteperdrix (1):
>>>>         switchtest: increase stack sizes
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://git.xenomai.org/xenomai-jki.git queues/proc
>>>>
>>>> This series fixes some of the potential (but when they happen fatal)=

>>>> overflows in our procfs outputs. Specifically, it fixes all issues i=
n
>>>> RTDM (one of them hit us in the field) and the recently reported
>>>> overflow in /proc/xenomai/heap. Moreover, Wolfgang started the lengt=
hy
>>>> conversion of the registry by introducing a new seq_file-based inter=
face
>>>> and already moving the native skin over.
>>>>
>>>> The future belongs to seq_file, so some of the patches are strictly
>>>> spoken not yet required. But we better start this effort before the =
last
>>>> legacy interface user was converted and the old interface is suddenl=
y
>>>> dropped from the kernel. This may not be that far away. A patch of m=
ine
>>>> to improve error reporting of the old interface was rejected with
>>>> "->read_proc is going to be removed, so there is no point."
>>> Did you already have a chance to look into this series?
>> Not yet, that is a big series. With a high potential for kernel crashe=
s,
>> memory leaks and other things like that. I am trying to find a way to
>> test it. Maybe we can try and run it with kmemcheck?
>>
>=20
> Looking at this series, I eventually made my mind about the kind of
> support I'd wish in this area. It boils down to:
>=20
> - getting rid of the PAGE_SIZE limitation on read as this series does,
> - reducing the impact on latency of large outputs,
> - hiding discrepancies between linux kernel
> releases, regarding the proper way to export kernel object states
> to userland (like the planned deprecation of read procs).
> - providing a common encapsulation to do that, which brings all the
> previous properties in a normalized way, and helps removing direct
> dependencies of other core code on PROC_FS
> - rebasing the registry support on top of this feature, so that skins
> are automatically feature-enabled when going through the registry to
> export stuff to userland (as they should).
>=20
> To this end, I came up with the so-called "virtual file" (aka vfile)
> support for the nucleus, and have toyed with those ideas here:=20
> git://git.xenomai.org/xenomai-rpm.git	queue/vfile
>=20
> This is still early work in progress, not all the codebase was converte=
d
> to use the vfiles (registry and native API were), and I tested the
> result only in a very limited manner; so this is not for inclusion into=

> 2.5.x given the amount of code that touches anyway. But I will likely
> submit this for inclusion at some point into any upcoming 2.6.x, if
> vfiles turn out to fit the job.
>=20

Looks good on first sight to simplify all our revision-based list walks
(and those that should better work like that). To make it a universal
abstraction for /proc/xenomai (or what ever it will be in the future), I
think just a bit more flexibility is required.

Specifically, we a way to modify the locking and data acquisition
strategy. We have nodes that do not require any locking at all but still
want to use the seq_file pattern. And we have some nodes that use
different locks, including Linux semaphores/mutexes. I think if you
allow to specify the lock to be used and its type (xnlock or Linux mutex
- BTW, a good chance to wrap away semaphores for legacy kernels), all
required use cases should be covered:
 - xnlock -> revision-based ahead-of-print data acquisition
 - Linux mutex -> simply hold the lock while printing
 - NULL -> provide lockless seq_file printing

Jan


--------------enigDF5DC396AA4CE697F50A60CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvae/4ACgkQitSsb3rl5xQBQgCeMzh0pMMwVRQc3TgE8FLrlHUD
DHkAoIYUQrWBFUXAIhQp3Y6xzEboUaZH
=LU/o
-----END PGP SIGNATURE-----

--------------enigDF5DC396AA4CE697F50A60CC--

