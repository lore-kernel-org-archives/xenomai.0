Message-ID: <462C7DF4.9060002@domain.hid>
Date: Mon, 23 Apr 2007 11:35:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46265FC8.1070207@domain.hid> <1176926837.5010.90.camel@domain.hid>
	<46268879.30507@domain.hid>
In-Reply-To: <46268879.30507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDFDA6831A73E3EDF4D860206"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
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
--------------enigDFDA6831A73E3EDF4D860206
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Wed, 2007-04-18 at 20:13 +0200, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> here is an explanation of the scalable scheduler issue I face on x86_=
64
>>> under different gcc compilers:
>>>
>>>         unsigned long x =3D 0;
>>>         int n =3D 32;
>>>
>>>         x |=3D 1 << n;
>>>
>>> The last instruction translates to:
>>>
>>> 	mov    0xfffffffffffffffc(%rbp),%ecx
>>> 	mov    $0x1,%eax
>>> 	shl    %cl,%eax
>>> 	cltq
>>> 	or     %rax,0xfffffffffffffff0(%rbp)
>>>
>> Blast. Good spot.
>>
>>> That means we only shift with 32-bit precision although the target ty=
pe
>>> is 64 bit. We find such code for setting the queue usage bits in
>>> addmlq(), but probably elsewhere too. This variant lets gcc generate =
the
>>> desired code:
>>>
>>> 	x |=3D (unsigned long)1 << n;
>>>
>>> Compiler issue, x86_64-specific oddity, or generic 64-bit problem we =
may
>>> have across the ipipe and Xenomai code (ppc64, ia64?)?
>>>
>> A brief look at the I-pipe code base shows that most shift expressions=

>> have righthand sides limited to small values (at least always < 32), a=
nd
>> when they don't, the lefthand side is properly cast to long long value=
s,
>> so this should be ok.
>>
>> BUT, it's a general 64bit port issue for Xenomai, which is not specifi=
c
>> to the multi-level queue implementation. We have the same issue going =
on
>> with at least:
>>
>> - the posix registry
>> - the message pipe support from the nucleus
>> - the vrtx id generator
>>
>> Gentlemen, it's time for bug hunting.
>>
>>> After patching nucleus/queue.h appropriately, my oopses disappear, bu=
t
>>> RT threads still do not run (no CSW to the threads latency creates).
>>> Jan
>>>
>>>
>>> PS: If you are interested, I could post a modified qemu patch that
>>> enables gdb kernel debugging under x86_64.
>>>
>> Yes please. I would have a look to the remaining issue I have here
>> exclusively over qemu, which seems unrelated to the multi-level queue
>> issue though.
>>
>=20
> Attached. A post to qemu-devel is also on the way. I wonder way the
> original patch by Jason Wessel, posted last September, or a variant of
> it still didn't make it into a qemu release or at least its CVS. Anyway=
=2E
>=20

A few iteration later, a new version of my qemu patch (now with more
registers...):

http://article.gmane.org/gmane.comp.emulators.qemu/17315


BTW, with latest SVN trunk and scalable sched, the oopses are gone but
latency still doesn't start up:

root@domain.hid :/root# cat /proc/xenomai/sched=20
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT
  0  930      0      0          0          master    R          display-9=
28
  0  931     99      0          0          master    R          sampling-=
928
root@domain.hid :/root# cat /proc/xenomai/stat =20
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          0          0     00500080  100.0  ROOT
  0  930    0          0          0     00300188    0.0  display-928
  0  931    0          0          0     00300188    0.0  sampling-928
  0  0      0          207        0     00000000    0.0  IRQ296: [timer]

This doesn't happen with !CONFIG_XENO_OPT_SCALABLE_SCHED.

Jan


--------------enigDFDA6831A73E3EDF4D860206
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLH30niDOoMHTA+kRAunVAJ9LsshVbeBieF+6Lm/dEh49bdwyGACeJayQ
l5Q/mDZMKlxtzhSCsJ9bqy4=
=WQZj
-----END PGP SIGNATURE-----

--------------enigDFDA6831A73E3EDF4D860206--

