Message-ID: <463A197D.2000106@domain.hid>
Date: Thu, 03 May 2007 19:18:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46360605.4020901@domain.hid>
	<17043901.1177943488672.JavaMail.ngmail@domain.hid>
	<5626198.1178177559304.JavaMail.ngmail@domain.hid>
In-Reply-To: <5626198.1178177559304.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig371F0043B4E635440D02A3F3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RTnet-users] Xenomai/rtnet vs. 2.6.21 realtime
	preempt patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig371F0043B4E635440D02A3F3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
>>> I have tried the latest 2.6.21 kernel + Ingo Molnar's realtime preemp=
t
>> patch
>>> (see: http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO)
>>>
>>> And I am really amazed about the results.
>>> On my Pentium 4D (dual core) system, 3.2 GHz, I ran the cyclictest
>>> application (which is something similar to the "latency" application =
of
>> Xenomai/RTAI)
>>> and I get values below 15 microseconds on my PC (for a single task ru=
nning
>> with 200 microseconds).
> ....
>>> Currently, my application is working quite nice using Xenomai/rtnet
>> however there are some
>>> drawbacks like the issue with limited IRQs: Sharing of IRQs between
>> Ethernet-Drivers of rtnet
>>> and non-realtime drivers is not possible (at least I did not manage
>> that...).
>>> A smooth usage of real time features from a "standard" kernel could h=
elp
>> here!
>>
>> Nope, not really. As I think to have explained earlier, IRQ sharing
>> between drivers that are designed for real-time and others that are no=
t
>> will never work deterministically. That has nothing to do with the
>> design of your RTOS underneath. Actually, the same issue once came up
>> for -rt over some ARM board that did poor IRQ line sharing as well.
>>
>> Jan
> I agree, the best is actually to have separate IRQs for real time and n=
on real time drivers.
> However, reality shows me, that this is very hard to get with standard =
PCs.

MSI? -- Oh, damn... ;)

> I can plug in one or two PCI boards to have an unique IRQ for them. How=
ever, if I want
> to use more PCI boards IRQ sharing cannot be avoided.

Agreed. Theory is nice, but practice often rules.

> As with the preempt patch, the duration of non-realtime IRQ routines se=
ems to be fairly short.

You got it: "seems". This approach might be fine for some applications,
but not for all.

> From this, I think it is at least an option to share IRQs between real =
time and non real time drivers
> even if the IRQ routine of the non real time driver may lead to a delay=
 of the real time IRQ routine.
> It is a question of acceptable delays for the IRQs.

It is a question of acceptable delays in the actual (analysed and
measured) worst case vs. "probable" (more or less blindly measured)
worst case. If you know the driver that will sit on the same IRQ line
like eg. your RT NIC, you can decide on a case-by-case analysis for each
kernel release if its behaviour is acceptable for your scenario. But
then you could also go the clean way and establish a trampoline for that
non-RT driver (as I suggested a few years back).

I more and more think we should try to formalise the latter procedure
and help system developers to realise this by modified or additional
features of the API (RTDM, I-pipe). I just had a private thread with
some other guy from industry about a related issue. I will try to wrap
up my latest "shiny" ideas and come back with a proposal next week or so.=


Jan


--------------enig371F0043B4E635440D02A3F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOhl9niDOoMHTA+kRAm+BAJ9bQaPy5Yf/nuhfOvN0vVEbPRWwjACaAlDb
TyKZ4Gdg0YskkfjY4JrsFWU=
=w3Lr
-----END PGP SIGNATURE-----

--------------enig371F0043B4E635440D02A3F3--

