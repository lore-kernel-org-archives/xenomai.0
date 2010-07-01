Message-ID: <4C2C3D93.9080504@domain.hid>
Date: Thu, 01 Jul 2010 09:02:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>	<4C289319.4050807@domain.hid>	<4C289FF2.6010208@domain.hid>
	<4C28A71F.8030902@domain.hid> <4C2BB70E.7020309@domain.hid>
In-Reply-To: <4C2BB70E.7020309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C1DE68E19177B6EBDC4C108"
Sender: jan.kiszka@domain.hid
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
--------------enig7C1DE68E19177B6EBDC4C108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Stefan Kisdaroczi wrote:
>>> Salut Gilles,
>>>
>>> i need to jump in.
>>>
>>> Am 28.06.2010 14:18, schrieb Gilles Chanteperdrix:
>>>> Nape Ibrahim Lentsoane wrote:
>>>>> Hello,
>>>>>
>>>>> I've been having this problem for some time now and I hope someone =
from
>>>>> the Xenomai community can help.
>>>>> Basically, my kernel does not want to boot with PMC card. I have ma=
naged
>>>>> to use console redirection of messages
>>>>> to the serial port and I can see the error messages. From what I ca=
n
>>>>> see, there is a problem with '/xnintr_irq_handler/' due
>>>>> to this message at boot time: /Xenomai: xnintr_irq_handler: IRQ10 n=
ot
>>>>> handled. Disabling IRQ line./
>>>> As repeated many times, disabling ACPI has been known to cause such
>>>> issues. So, you should keep ACPI enabled, only ACPI_PROCESSOR needs =
to
>>>> be disabled.
>>>>
>>>> For IRQ conflicts, see:
>>>> http://www.xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_L=
inux_devices_share_the_same_IRQ.3F
>>> I had to consult this wiki already multiple times (every time I get a=
 new box...)
>>> It's ok, but there is not really a solution. Currently I have one pci=
-card
>>> and a rtdm driver. I got my unshared realtime IRQ after disabling the=
 soundcard.
>>>
>>> At the end of the year I need to be able to use three of these cards =
and
>>> five realtime serial connections in one machine. I already have sleep=
less
>>> nights ;-) and hope I understood something wrong...
>>>
>>> AFAIK with 2.6.31 "threaded IRQ's" were merged to mainline. Would it =
be possible
>>> now for IPIPE to pass down the IRQ's to linux so that the IRQ is hand=
led, but
>>> the IRQ-Thread is not started ? Or something like ?
>>>
>> It's still not that simple. Threaded IRQs per se do not solve the issu=
e,
>> neither in upstream nor for Xenomai.
>>
>> What they do, though, is to lay the ground for slowing enabling RT-saf=
e
>> IRQ-sharing in more and more Linux drivers: Given a proper split-up
>> between top-half and threaded handler, you now have the means (with
>> upstream) or at least the blueprint (for Xenomai) how to quickly silen=
ce
>> an IRQ line at device level. For Xenomai, these handler would have to =
be
>> made co-scheduling-safe and could then be registered against RTDM as
>> shared RT-IRQs. Still, this issue cannot be addressed automatically, i=
t
>> has to be developed driver by driver.
>=20
> If what you want is run the top-half ahead of the pipeline, you do not
> need RTDM. I-pipe can do it (the way we do interrupts demultiplexing on=

> embedded platforms).

No, the idea would be to have yet some more RTDM drivers that properly
hook into the existing full-featured IRQ sharing framework of Xenomai
but just have really tiny IRQ handlers in the higher domain and no
real-time user interface.

>=20
> I am not sure we want the issue to be addressed automatically, it looks=

> dangerous for the determinism.

I would never be an automatic solution. At the bare minimum, you would
have to identify the affected drivers and enable RTDM top-halves for the
them. But determinism would not suffer more than with "real" RTDM IRQ
sharing.

Anyway, I are discussing this option for 4 or 5 years now. Today we even
have MSI as true solution at hand in many cases. I'm not sure it's worth
investing much here.

Jan


--------------enig7C1DE68E19177B6EBDC4C108
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwsPZYACgkQitSsb3rl5xSLjQCgjCt9Ffb/Yj+NxtyZjm2w9QDO
9N8An2LhTZLgR6CVx55Q01LjImGrB8JZ
=RzER
-----END PGP SIGNATURE-----

--------------enig7C1DE68E19177B6EBDC4C108--

