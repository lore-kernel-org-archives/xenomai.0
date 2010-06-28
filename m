Message-ID: <4C289FF2.6010208@domain.hid>
Date: Mon, 28 Jun 2010 15:13:22 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>
	<4C289319.4050807@domain.hid>
In-Reply-To: <4C289319.4050807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC4F673B00C33BD1362EF8DD4"
Subject: Re: [Xenomai-help] IRQ conflict issues with and ESD PMC card.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC4F673B00C33BD1362EF8DD4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Salut Gilles,

i need to jump in.

Am 28.06.2010 14:18, schrieb Gilles Chanteperdrix:
> Nape Ibrahim Lentsoane wrote:
>> Hello,
>>
>> I've been having this problem for some time now and I hope someone fro=
m
>> the Xenomai community can help.
>> Basically, my kernel does not want to boot with PMC card. I have manag=
ed
>> to use console redirection of messages
>> to the serial port and I can see the error messages. From what I can
>> see, there is a problem with '/xnintr_irq_handler/' due
>> to this message at boot time: /Xenomai: xnintr_irq_handler: IRQ10 not
>> handled. Disabling IRQ line./
>=20
> As repeated many times, disabling ACPI has been known to cause such
> issues. So, you should keep ACPI enabled, only ACPI_PROCESSOR needs to
> be disabled.
>=20
> For IRQ conflicts, see:
> http://www.xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linu=
x_devices_share_the_same_IRQ.3F

I had to consult this wiki already multiple times (every time I get a new=
 box...)
It's ok, but there is not really a solution. Currently I have one pci-car=
d
and a rtdm driver. I got my unshared realtime IRQ after disabling the sou=
ndcard.

At the end of the year I need to be able to use three of these cards and
five realtime serial connections in one machine. I already have sleepless=

nights ;-) and hope I understood something wrong...

AFAIK with 2.6.31 "threaded IRQ's" were merged to mainline. Would it be p=
ossible
now for IPIPE to pass down the IRQ's to linux so that the IRQ is handled,=
 but
the IRQ-Thread is not started ? Or something like ?

Regards Stefan

> Also, to be sure that the problem you have is not a configuration issue=
,
> try the Xenomai-patched linux kernel, with exactly the same
> configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE turned off. If=

> it does not boot, then the issue is not caused by Xenomai.
>=20
> If it does boot, then please send another mail, including, this time:
> - the version of the Linux kernel you use;
> - the Adeos and Xenomai versions you use;
> - the contents of /proc/interrupts and /proc/xenomai/irq;
> - the full serial log, from the boot up to the bug;
> - the two .config file, the one which boots, the one which does not.
>=20



--------------enigC4F673B00C33BD1362EF8DD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFMKJ/3IPTw9rIdn6oRAqexAJ4tmXenznopjj6k+37c88bjfkM80QCeMOQZ
BcrIFV8RSfb4qDpFmoB8LqY=
=hLxu
-----END PGP SIGNATURE-----

--------------enigC4F673B00C33BD1362EF8DD4--

