Message-ID: <4417CCD3.1070905@domain.hid>
Date: Wed, 15 Mar 2006 09:14:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid> <4417C14A.2010900@domain.hid>
	<4417C74D.3060203@domain.hid>
In-Reply-To: <4417C74D.3060203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0ED6365CCCC62A77D0F331F3"
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0ED6365CCCC62A77D0F331F3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>
>>> Hi,
>>>
>>> for those who haven't followed the endless "RTDM and Timer functions"=

>>> thread: we are currently discussing a way to provide high-resolution
>>> timestamps in periodic mode for RTDM users. It was suggested to use t=
he
>>> TSC for this, but I noted that this source will not be in sync with t=
he
>>> periodic system timer and may even be out of sync across multiple CPU=
s.
>>>
>>> A straight-forward approach to overcome this might be to record the
>>> current TSC value together with the current jiffies in
>>> xntimer_do_tick_periodic(). This tuple (per CPU) could then be provid=
ed
>>> to skin implementers in order to let them offer a high-resolution
>>> timestamp source even in periodic mode. Hmm, sounds too simple actual=
ly,
>>> so I'm waiting now for someone pointing out the pitfalls.
>>
>>
>> Likely too simple: The periodic IRQ seems to pop up on every CPU so th=
at
>> the TSC could be recorded, but will this happen synchronously? At leas=
t
>> we will see (IRQ) jitters, and those jitters could already create in t=
he
>> single-CPU case a non-monotonic clock...
> Returning a struct with { jiffies, cpu#, tsc, clockscaling, ... } and
> routines to compare ( lt | equal | gt | unordered ) and calculate
> differences { diff, accuracy }. And then people (of course) will send
> them over the network and compare items emanating from different system=
s!
>=20

Well, I think it's more obvious that timestamps taken on box A will not
necessarily match timestamps of box B. Moreover, tasks on box A will not
that often get migrated automatically to box B, while this can happen
inside SMP boxes if you do not explicitly bind to a certain CPU.

For the local usage I have this scheme in mind:

local_irqs_off();
read_cpu_tsc();
get_last_cpu_tsc_offset();
local_irqs_on();
calc_corrected_time();

So, nothing has to be exported to the skin user.

Or did I misunderstand what you wanted to express?

Jan


--------------enig0ED6365CCCC62A77D0F331F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFEF8zTniDOoMHTA+kRAvN3AJdUVH/1anGeoFxEXK1ODqerjan7AJ0W/QLM
HM1qtxk0w8gC7+zpg4t1pg==
=F1z+
-----END PGP SIGNATURE-----

--------------enig0ED6365CCCC62A77D0F331F3--

