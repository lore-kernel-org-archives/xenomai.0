Message-ID: <47429113.9080705@domain.hid>
Date: Tue, 20 Nov 2007 08:47:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47374EF7.4070608@domain.hid> <4741CAEE.7020003@domain.hid>
In-Reply-To: <4741CAEE.7020003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB6E1AC576676390887B2E814"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] x86_64: cleanup IRQ on/off tracing
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6E1AC576676390887B2E814
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Tracing of IRQ on/off paths on x86_64 currently suffers from heavy
>> over-instrumentation.
>=20
> I understand the point of grouping ipipe_trace_begin/ipipe_trace_end
> statements inside the .interrupt macros and using a lightweight thunk
> code since we are already covered by the SAVE_ARGS prologue, but I find=

> the following hunk suspicious, since unlike i386, we do not virtualize
> inline sti/cli ops for x86_64. My concern is that removing this
> instrumentation would leave us naked in the cold the day some subtle
> upstream change introduces a hw masked section we don't immediately
> notice; such trace points would precisely help us spotting it.

The situation is not that different compared to i386:
 - we do not add or remove enabling/disabled points
 - we rely on the correctness of mainline here, so we are not on our own
   anyway
 - if things actually change in mainline, the tracer will probably be
   the last indicator for it (patching breaks and/or leaking clis will
   fairly visible impact)

On the other side, there was a good reason not to instrument cli/sti in
the assembly exit/entry code on i386, just like it is on x86_64: The
effort to get worthwhile outputs is noticeable. As you see, the current
approach is not very helpful due to loosing the caller context (thanks
to the thunks). And those points only mark uninteresting micro paths,
thus create a lot of noise in normal traces.

So, I see not good reason for fixing this instrumentation and still vote
for killing it.

Jan


--------------enigB6E1AC576676390887B2E814
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHQpETniDOoMHTA+kRAtJqAJ9IkljDiQWxT0jKNB42olmhIowKcwCfaMm0
TfjkHL15xYVuEy9n7XhbIX8=
=Y6VZ
-----END PGP SIGNATURE-----

--------------enigB6E1AC576676390887B2E814--

