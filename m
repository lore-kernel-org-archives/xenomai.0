Message-ID: <4CB72B5D.1070304@domain.hid>
Date: Thu, 14 Oct 2010 18:10:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CB06CE9.9090204@domain.hid>
	<1287070938.1628.20.camel@domain.hid>
In-Reply-To: <1287070938.1628.20.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC728955F4879F9AB4EDB0634"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [forge] irqbench removal
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC728955F4879F9AB4EDB0634
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 14.10.2010 17:42, Philippe Gerum wrote:
> On Sat, 2010-10-09 at 15:23 +0200, Jan Kiszka wrote:
>> Philippe,
>>
>> irqbench does not inherently depend on a third I-pipe domain. It is a
>> useful testcase, the only in our portfolio that targets a peripheral
>> device use case. In fact, it was only of the first test cases for Nati=
ve
>> RTDM IIRC.
>>
>> Please revert the removal and then cut out only the few parts that
>> actually instantiate an additional domain (i.e. mode 3.
>=20
> So, what do we do with this? Any chance we move to arch-neutral code fo=
r
> this test?

Arch-neutral is impossible due to the inherent hardware dependency. But
I'm waiting on some comments by Wolfgang on their work as that's
probably the best requirements source for multi-arch support.

For now the existing test should not cause any harm if cleaned up from
the domain stuff and not built on non-x86 archs (which is already
properly guarded for user space, the kernel driver may deserve an
additional dependency).

Jan


--------------enigC728955F4879F9AB4EDB0634
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAky3K2EACgkQitSsb3rl5xRQsACeIjGwBmeX3rBTRzp7WmfIEyId
dksAni3w1bMxy7lp+wCJViw0HwDcZgqV
=vCcO
-----END PGP SIGNATURE-----

--------------enigC728955F4879F9AB4EDB0634--

