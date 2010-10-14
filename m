Message-ID: <4CB743FA.20504@domain.hid>
Date: Thu, 14 Oct 2010 19:55:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CB06CE9.9090204@domain.hid>	
	<1287070938.1628.20.camel@domain.hid>
	<4CB72B5D.1070304@domain.hid>
	<1287073013.1628.25.camel@domain.hid>
In-Reply-To: <1287073013.1628.25.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig000363461786AC2FA7BD4F0A"
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
--------------enig000363461786AC2FA7BD4F0A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 14.10.2010 18:16, Philippe Gerum wrote:
> On Thu, 2010-10-14 at 18:10 +0200, Jan Kiszka wrote:
>> Am 14.10.2010 17:42, Philippe Gerum wrote:
>>> On Sat, 2010-10-09 at 15:23 +0200, Jan Kiszka wrote:
>>>> Philippe,
>>>>
>>>> irqbench does not inherently depend on a third I-pipe domain. It is =
a
>>>> useful testcase, the only in our portfolio that targets a peripheral=

>>>> device use case. In fact, it was only of the first test cases for Na=
tive
>>>> RTDM IIRC.
>>>>
>>>> Please revert the removal and then cut out only the few parts that
>>>> actually instantiate an additional domain (i.e. mode 3.
>>>
>>> So, what do we do with this? Any chance we move to arch-neutral code =
for
>>> this test?
>>
>> Arch-neutral is impossible due to the inherent hardware dependency. Bu=
t
>> I'm waiting on some comments by Wolfgang on their work as that's
>> probably the best requirements source for multi-arch support.
>=20
> I mean that the bulk of the code could be made arch-neutral, with only
> callouts to solve the arch-dependent/uart issues. Typically, 16550's ar=
e
> not uncommon on powerpc, but we obviously don't program them via
> ioports. A second level of indirection could provide the entire chip
> handling, to fit other uarts, maybe?

If there are suitable UARTs around, refactoring the code accordingly and
maybe adding support for one of them as reference would be a good next
step. But first I would like to understand (or recall - I think Wolfgang
once explained it) the motivations for not going this path with the
gpiobench test and learn its requirements to avoid doing refactorings
twice or more.

Jan


--------------enig000363461786AC2FA7BD4F0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAky3RAUACgkQitSsb3rl5xQ+dQCZAUhMa83jECA9BUAFY93bW6Pn
6aMAoLNeHoHuaHDbVYuVrgJi61opqJWU
=/VtF
-----END PGP SIGNATURE-----

--------------enig000363461786AC2FA7BD4F0A--

