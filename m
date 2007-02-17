Message-ID: <45D73EC0.2030601@domain.hid>
Date: Sat, 17 Feb 2007 18:43:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][PATCH 1/2] real-time print library
References: <45D6C4B6.7010302@domain.hid> <1171714345.18347.25.camel@domain.hid>
In-Reply-To: <1171714345.18347.25.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB1A511A64B5F8F659CFD3B11"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1A511A64B5F8F659CFD3B11
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2007-02-17 at 10:02 +0100, Jan Kiszka wrote:
>> This is a stand-alone real-time library for printf services. It is
>> embedded into the Xenomai user space part but actually doesn't depend
>> on any Xenomai service, just using plain Linux POSIX.
>>
>> The librtprint API looks much like the printf(3) man page:
>=20
> [...]
>=20
>> Further features:
>>  o Explicit or on-demand thread buffer creation
>>  o Override of default buffer size and polling period via environment
>>    variables ("RT_PRINT_BUFFER" and "RT_PRINT_PERIOD")
>>  o Support for buffer names (useful for the following patch e.g.)
>>  o Target output stream can be specified for each print invocation
>>  o Breaks all builds except for x86 (missing ubarrier.h headers) :o)
>>
>=20
> ubarrier.h is redundant. include/asm-*/atomic.h is already there for
> such purpose.

Guess you mean Xenomai's atomic.h, not the kernel ones. I didn't
realised that it is also used from user space already. OK, will #define
something like xnarch_rmb/wmb (or xnarch_read_memory_barrier?) in that
file instead.

>=20
>> The code is stuffed into src/rtprint for now as patch 2/2 will need th=
is
>> lib to be built before the skin libraries. Better suggestions are
>> welcome though.
>=20
> I basically agree that we need to provide more
> co-scheduler-based-rt-safe services, so a non-intrusive print out
> support should be welcome. A few things more:

Actually, rt-safe printing is independent of co- vs. native scheduling.
Even with a fully preemptible kernel, the worst-case complexity of
normal printf may not be acceptable. I think rt_printf is generally
useful in real-time programs.

>=20
> - looking beyond print out, we will probably want to iron more ANSI
> services in the future. In order to prevent API proliferation, let's
> consider the hardened print out support as the beginning of some
> libansi_rt service collection.

I was already considering to include the TLSF memory allocator for
real-time malloc/free into some Xenomai library, but there were still
technical issues with its lacking 64-bit support e.g., preventing some
quick-hack.

What further services do you have on your radar? My impression is that
there will not be a lot beyond printing and memory allocation.

>=20
> - the same way libpthread_rt shadows 1003.1c services to iron them over=

> a co-scheduler, we should do the same for the ironed ANSI services. In
> that sense, there is no need for rt_printf, rt_vsprintf and so on, we
> just need to shadow printf, vsprintf and friends the same way we did fo=
r
> pthread_create and such for substituting the 1003.1c support. Again, AP=
I
> proliferation, especially of non-orthogonal stuff, needs to be fought
> now. The bonus is that we would not have to ask people to rely on cruft=
y
> preprocessor tricks in order to compile their code in either real-time
> layers X3 is going to provide (i.e. I-pipe-based co-scheduler and nativ=
e
> preemption). This would be consistent with the all-time Xenomai's
> mantra, i.e. "integrate as seamlessly as you can, don't get uselessly
> peculiar".
>=20

Think of RTDM: we have transparent overloading with the POSIX skin, but
all others use the explicit selection via rt_dev prefix. I forgot to
mention this, but my plan was to apply the same pattern for librtprint
services.

I don't think we should overload every printf outside the POSIX skin's
scope automatically. Well, at least for the native skin, which is in my
opinion quite a lot about _explicit_ real-time programming, I would
really prefer to keep it like it is even under Xenomai 3.

Jan


--------------enigB1A511A64B5F8F659CFD3B11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1z7EniDOoMHTA+kRAr3GAJ42bDR9ewjgQ1ObGX/5yj2Mxh8AWQCcCbJ9
N5Mon+1iD6AI0ozZ78oeoME=
=atyg
-----END PGP SIGNATURE-----

--------------enigB1A511A64B5F8F659CFD3B11--

