Message-ID: <441C25DC.3090007@domain.hid>
Date: Sat, 18 Mar 2006 16:23:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] O(1) scheduler broken
References: <441B2204.1070406@domain.hid> <441BD80D.4030700@domain.hid>
	<441C1B9D.70107@domain.hid>
In-Reply-To: <441C1B9D.70107@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2F365591DCA357A309AC046D"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
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
--------------enig2F365591DCA357A309AC046D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>
>>> Hi,
>>>
>>> I just wanted to test how much the worst-cast jitters improve when
>>> running multiple timed threads over the O(1) scheduler instead of the=

>>> default one.=20
>>
>>
>> It really depends whether your threads actually wake up simultaneously=

>> or not.
>> The scalable scheduler solves the pathological case where your
>> application has
>> an insane number of threads _actually_ competing for the current CPU,
>> i.e. all being in a runnable state at the same time or within a short
>> window of time. IOW, it implements O(1) for the ready queue. We don't
>> use any sequential access for the suspended thread queue, and beyond
>> that, I'm even going to kill the latter since it's actually useless.
>>
>> Unfortunately, it already crashes my box with the standard
>>
>>> latency test. All debug stuff on and serial console attached still do=
es
>>> not give any output. Looks like a really fatal scheduler crash. :(
>>>
>>> Anyone any ideas?
>>
>>
>> It breaks with the development trunk/ because we are extending the
>> ability of
>> the core pod to provide a larger priority scale, so that we can provid=
e
>> VxWorks et al. with a native syscall interface. The new scale likely
>> messes up with the priority bitmaps used in the scalable sched. Will f=
ix.
>>
>=20
> This should fix the current issue.
>=20
> --- include/nucleus/queue.h    (revision 741)
> +++ include/nucleus/queue.h    (working copy)
> @@ -580,7 +580,7 @@
>=20
>  /* Multi-level priority queue */
>=20
> -#define XNSPQUEUE_PRIOS      (XNCORE_MAX_PRIO + 1)
> +#define XNSPQUEUE_PRIOS      (XNCORE_MAX_PRIO + 2)
>  #define XNSPQUEUE_BITMAPSIZE ((XNSPQUEUE_PRIOS + BITS_PER_LONG - 1) /
> BITS_PER_LONG)
>=20
>  typedef struct xnspqueue {
>=20

Cute :), but it works. Thanks.

Jan


--------------enig2F365591DCA357A309AC046D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHCXcniDOoMHTA+kRAsq6AJwIKwTA1GVm53Z7ZuHGz2cZJG/1nQCdEPpl
/DsZILfmFEQBbepR3QLM/L4=
=Sw3/
-----END PGP SIGNATURE-----

--------------enig2F365591DCA357A309AC046D--

