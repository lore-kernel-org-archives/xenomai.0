Message-ID: <4C076C10.3070708@domain.hid>
Date: Thu, 03 Jun 2010 10:47:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C0692A9.2080806@domain.hid> <4C06953D.90003@domain.hid>	
	<4C0751FC.8050009@domain.hid>
	<1275553646.18250.65.camel@domain.hid>
In-Reply-To: <1275553646.18250.65.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB4F433F9A044A03B2851F8B1"
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
--------------enigB4F433F9A044A03B2851F8B1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2010-06-03 at 08:55 +0200, Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Hi all,
>>>>
>>>> here is the first apparently working prototype for getting hold of
>>>> endless user space loops in RT threads. A simple test case of mine n=
ow
>>>> receive a SIGDEBUG even if it does "while (1);".
>>>>
>>>> The design follows Gilles' suggestion to force a SEGV on victim thre=
ad
>>>> but restore the patched PC before migrating the thread after this fa=
ult.
>>>> The only drawback of this approach: We need to keep track of the
>>>> preempted register set at I-pipe level. I basically replicated what
>>>> Linux does these days as well and exported it as ipipe_get_irq_regs(=
)
>>>> (the second patch).
>>> You already have the regs in xnarch_fault_info.
>>>
>> We only pass this around for exceptions.
>=20
> And for a good reason, exceptions are always delivered synchronously
> upon receipt, not IRQs, given the deferred dispatching scheme. Your
> ipipe_get_irq_regs interface is inherently broken for anything which is=

> not a wired-mode timer IRQ, since you could pass the caller a reference=

> to an unwound stack frame.

It may not work for certain deferred IRQs, true, but then it will return
NULL. The user of ipipe_get_irq_regs has to take this into account. And
most consumers will be wired IRQ handler anyway.

>=20
> You have to resort to __ipipe_tick_regs, and obviously only use this in=

> the context of a timer-triggered code, like the watchdog handler, which=

> saves your day.

Doesn't work if the timer IRQ is not the host tick AND doesn't help us
modifying the return path.

Granted, the former scenario is already broken in I-pipe (try using an
x86 host with an MSI-capable HPET...), but the latter is definitely a no-=
go.

Jan


--------------enigB4F433F9A044A03B2851F8B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwHbBUACgkQitSsb3rl5xShxwCdEWMZSgWps7yhnLUXySp7YhQB
NYwAoLcyZogJiousx7VYrWnTndtpPflW
=qxN7
-----END PGP SIGNATURE-----

--------------enigB4F433F9A044A03B2851F8B1--

