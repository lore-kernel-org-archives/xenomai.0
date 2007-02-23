Message-ID: <45DEA6D9.6010306@domain.hid>
Date: Fri, 23 Feb 2007 09:33:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <451C586A.7020309@domain.hid>
	<1159628606.5014.33.camel@domain.hid>	<4522A377.5030503@domain.hid>
	<45DDCC6D.6020908@domain.hid> <45DDCEE0.7070901@domain.hid>
	<45DDD478.7070403@domain.hid>
In-Reply-To: <45DDD478.7070403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF1913B8AE764E46FD8F064C1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: [Xenomai-core] possible future conflict w
	LOCAL_APIC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Jan_R=FCdiger?= <ruediger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1913B8AE764E46FD8F064C1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan R=FCdiger wrote:
> Jan Kiszka wrote:
>> Jan R=FCdiger wrote:
>>> Hello
>>>
>>> Few months ago there was a discussion about disabling local apic in t=
he
>>> kernel. The last point in this discussion was:
>>>
>>>> update:
>>>>
>>>> Ingo Molnar has voiced strong preference that the config option rema=
in,
>>>> citing 60kb growth in its removal.  So its probably safe for now ;-)=

>>> Now i have the problem that i cant disable the X86_UP_APIC anymore wh=
en
>>> building the kernel 2.6.19. Normally this isn't a problem since it is=

>> ???
>>
>> There is no "select X86_UP_APIC" in kbuild that would make this mandat=
ory.
>=20
> Thanks for your fast reply. Actually the option X86_UP_APIC is missing
> when doing "make menuconfig" under "Processor type and Feature" and als=
o
> in the .config file. Thats why i can't disable it.
> As far as i understood it, this option was taken away an replaced with
> the possibility to have noapic flag at boot time.
> With this, however, xenomai ist still build with APIC enabled and
> refuses to run.

Do you happen to have SMP on? It takes away the choice of UP_APIC,
because it assumes to find an APIC in any case.

>=20
> My 2.6.19.2 kernel was downloaded from kernel.org. All i did was "make
> cloneconfig" and then enabling xenomai and a few other things
> (preemption etc.)

Unless you need it otherwise, CONFIG_PREEMPT is not required for good
Xenomai latencies.

Jan


PS: Please take care of CC, I re-added xenomai-help.


--------------enigF1913B8AE764E46FD8F064C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3qbaniDOoMHTA+kRApTPAJ0TEw6+dwpRXbwT94zUksFPMMzTKQCfcZuW
oxZ0lag0UrLksXZK+3efo/M=
=WegJ
-----END PGP SIGNATURE-----

--------------enigF1913B8AE764E46FD8F064C1--

