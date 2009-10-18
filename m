Message-ID: <4ADB100B.1060300@domain.hid>
Date: Sun, 18 Oct 2009 14:54:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AD8A87C.4040706@domain.hid> <1255799737.2862.15.camel@domain.hid>
In-Reply-To: <1255799737.2862.15.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9121B32C412C9DEE14A8237E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Native: Fixing auto-cleanup
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
--------------enig9121B32C412C9DEE14A8237E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2009-10-16 at 19:08 +0200, Jan Kiszka wrote:
>> Hi,
>>
>> our automatic object cleanup on process termination is "slightly" brok=
en
>> for the native skin. The inline and macro magic behind
>> __native_*_flush_rq() blindly calls rt_*_delete(), but that's not
>> correct for mutexes (we can leak memory and/or corrupt the system heap=
),
>> queues and heaps (we may leak shared heaps).
>=20
> Please elaborate regarding both queues and heaps (scenario).

Master creates heap, slave binds to it, master wants to terminate (or is
killed, doesn't matter), heap cannot be released as the slave is still
bound to it, slave terminates but heap object is still reserved on the
main heap =3D> memory leak (just confirmed with a test case).

I'm not sure if that object migration to the global queue helps to some
degree here (it's not really useful due to other problems, will post a
removal patch) - I've build Xenomai support into the kernel...

>=20
>> I'm in the process of fixing this, but that latter two are tricky. The=
y
>> need user space information (the user space address of the mapping bas=
e)
>> for ordinary cleanup, and this is not available otherwise.
>>
>> At the time we are called with our cleanup handler, can we assume that=

>> the dying process has already unmapped all its rtheap segments?
>=20
> Unfortunately, no. Cleanup is a per-skin action, and the process may be=

> bound to more than a single skin, which could turn out as requiring a
> sequence of cleanup calls.
>=20
> The only thing you may assume is that an attempt to release all memory
> mappings for the dying process will have been done prior to receive the=

> cleanup event from the pipeline, but this won't help much in this case.=


That's already very helpful!

> This attempt may fail and be postponed though, hence the deferred
> release callback fired via vmclose.

I already started to look into the release callback thing, but I'm still
scratching my head: Why do you set the callback even on explicit
rt_heap/queue_delete? I mean those that are supposed to fail with -EBUSY
and then to be retried by user land? What happens if rt_heap_unbind and
retried rt_heap_delete race?

Anyway, auto-cleanup of heap and queue must be made none-failing, ie.
the objects have to be discarded, just the heap memory deletion has to
be deferred. I'm digging into this direction, but I'm still wondering if
the none-automatic heap/queue cleanup is safe in its current form.

Jan

PS: Mutex cleanup leak is fixed now.


--------------enig9121B32C412C9DEE14A8237E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrbEBEACgkQitSsb3rl5xRR6wCeNfgywgHSewJofA5VWy1c6qTL
qSwAmQG8mI++ehsg1Pmjg4wCxexCgVV0
=SDpm
-----END PGP SIGNATURE-----

--------------enig9121B32C412C9DEE14A8237E--

