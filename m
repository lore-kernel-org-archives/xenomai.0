Message-ID: <4C075206.80003@domain.hid>
Date: Thu, 03 Jun 2010 08:56:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C0692A9.2080806@domain.hid>
	<1275512284.18250.56.camel@domain.hid>
In-Reply-To: <1275512284.18250.56.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBD948338AA0AF4D8FF0BDE08"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC] Break out of endless user space loops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD948338AA0AF4D8FF0BDE08
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2010-06-02 at 19:19 +0200, Jan Kiszka wrote:
>> Hi all,
>>
>> here is the first apparently working prototype for getting hold of
>> endless user space loops in RT threads. A simple test case of mine now=

>> receive a SIGDEBUG even if it does "while (1);".
>>
>> The design follows Gilles' suggestion to force a SEGV on victim thread=

>> but restore the patched PC before migrating the thread after this faul=
t.
>> The only drawback of this approach: We need to keep track of the
>> preempted register set at I-pipe level. I basically replicated what
>> Linux does these days as well and exported it as ipipe_get_irq_regs()
>> (the second patch).
>>
>> This is an x86-64-only draft which clearly needs more love. I'm open f=
or
>> suggestions of different abstractions wherever you see a need.
>=20
> What if you have no MMU ?

Then you either have an MPU detecting NULL pointer accesses or you can
actually redirect the PC to some kernel function containing some other
invalid, exception-raising instruction.

Jan


--------------enigBD948338AA0AF4D8FF0BDE08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwHUgYACgkQitSsb3rl5xQk8QCg4dlLTrME4VOpr6zafshmTsQ+
238AoM3HKwnpO+rn76lGrus2LD6SnFyy
=txmG
-----END PGP SIGNATURE-----

--------------enigBD948338AA0AF4D8FF0BDE08--

