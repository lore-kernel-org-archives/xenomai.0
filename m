Message-ID: <464C51F7.3000407@domain.hid>
Date: Thu, 17 May 2007 15:00:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <17996.15540.824415.263562@domain.hid>	<464C4DE4.1040402@domain.hid>
	<17996.20586.564091.503622@domain.hid>
In-Reply-To: <17996.20586.564091.503622@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B19C311240EA908608D4751"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] Use tsc for implementation of
	clock_gettime.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B19C311240EA908608D4751
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Hi,
>  > >=20
>  > > here comes, for review, a patch which reduces the overhead of
>  > > clock_gettime by directly reading the tsc in user-space for
>  > > architectures that support it.
>  >=20
>  > Highly welcome. But I have one concern: How and when do you propagat=
e
>  > wallclock_offset changes to user space?
>=20
> Since clock_settime is not implemented, never, but if clock_settime was=

> implemented, clock_settime would re-issue the __xn_sys_info syscall.

This excludes automatic clock adjustment, something I'm convinced we
will have to provide in the future.

>=20
>  >=20
>  > I think we need some vsyscall-alike approach for this, some read-onl=
y
>  > page that is mapped into every RT process, containing things like a
>  > regularly updated offset (seqlock fashioned) or other read-only
>  > information (shadow mode? cpu id?).
>=20
> As I said yesterday, having a page mapped at a different address in
> kernel-space and user-space is not an option on ARM, because each
> mapping of this page would have a separated cache.
>=20

Hmm, what about the kernel writing directly to the (current) user
address? We then only need to keep track of the per-mm address and have
not fixed kernel equivalent. At least on arm, other archs may handle
this differently at compile time.

Jan


--------------enig0B19C311240EA908608D4751
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGTFH3niDOoMHTA+kRApmvAJ9dEyjyRw1Wo+4eKP/Th4E8LLXfOACePdXR
gBQxVLITole38l+MABipOAk=
=tYSf
-----END PGP SIGNATURE-----

--------------enig0B19C311240EA908608D4751--

