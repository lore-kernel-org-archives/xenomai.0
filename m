Message-ID: <4A2585AC.8040107@domain.hid>
Date: Tue, 02 Jun 2009 22:03:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A157FD9.40106@domain.hid> <4A23B35E.7010005@domain.hid>
	<4A23D8C7.4020208@domain.hid>
In-Reply-To: <4A23D8C7.4020208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5A2A7329DEAE0DFA202F71CE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] About HARD real time... and USB
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antoine Nourry <nourry@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A2A7329DEAE0DFA202F71CE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Antoine Nourry wrote:
>=20
>> The current roadmap is to let Xenomai 3 come in two flavors: one based=

>> on PREEMPT-RT (Xenomai/Solo), the other (Xenomai/Duo) using Adeos/I-pi=
pe
>> and a second scheduler like Xenomai 2 does, but supporting much less
>> legacy than the latter (no kernel 2.4, no in-kernel RT applications
>> etc.). So depending on your requirements and PREEMPT-RT's progress,
>> you'll be able to chose the fitting platform or even switch between th=
em
>> without too much effort.
>>
>> Jan
>>
>>  =20
> Thanks again Jan.
>=20
> Another point; for RT USB developers, do you think we could use Linux
> native USB stack with PREEMPT_RT in the same way as Xenomai / USB4RT ?

I haven't reviewed the code path of a typical urb in mainline recently,
but I bet the usual two issues exist:

 - Shared (soft-)IRQ and/or workqueue threads with uncritical code
   (either other USB drivers or even totally unrelated kernel
   subsystems). In order to achieve reasonable latencies, you need to
   boost their prios, but that can quickly cause priority inversion,
   thus other latencies.

 - No resource isolation, ie. dynamic buffer allocation which can hit
   temporary shortages or contentions, raising latencies or even
   letting some requests fail.

Moreover you may face troubles as mainline USB is (reasonably) concerned
about hotplug, thus may perform management jobs while you try to acquire
some data at high frequencies and react on the data in real-time.

>=20
> I'm pleased with this last solution but the USB4RT bug (need to send a
> command twice) is a real problem for performances (i'd like to increase=

> my acquisition rate within a fixed cycle). My only approach to real tim=
e
> for the moment is USB driver, and in the Open world i cannot find what
> could be the "right" or "best" solution...

It's a pity, this bug now exists for, hmm, 3 years? But as long as no
one feels the need to dive into it, understand and fix it, this won't
change. Maybe one could even analyze this inside QEMU/KVM, also looking
at the virtual host controller state when the problems shows up. But it
still takes someone to /do/ this.

Jan


--------------enig5A2A7329DEAE0DFA202F71CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkolhfEACgkQniDOoMHTA+k+nwCfYIKBznV80I3Bwelp+5wV2x0/
FRUAnirO5qV7XyzOI+bI6JMhMOn11nj0
=Jw25
-----END PGP SIGNATURE-----

--------------enig5A2A7329DEAE0DFA202F71CE--

