Message-ID: <44466D75.5060605@domain.hid>
Date: Wed, 19 Apr 2006 19:03:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Where did my interrupts go?
References: <444502A6.7020402@domain.hid> <44451CF9.8020201@domain.hid>
	<44465782.6090102@domain.hid>
In-Reply-To: <44465782.6090102@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA7C1942AE72246CE0FAFD5C2"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA7C1942AE72246CE0FAFD5C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sean McGranaghan wrote:
> Hello Jan,
>=20
> Comments are inline below...
>=20
> FYI - I now have two Pentium II machines exhibiting the same behavior. =
Both are=20
> configured with a vanilla 2.6.16.5 kernel with Xenomai trunk snapshot. =
(Rev=20
> 941). One machine has the local APIC enabled in the kernel, one does no=
t.=20
> Xenomai user space is configured with --enable-x86-tsc and --enable-x86=
-sep.
>=20
> Thanks,
> Sean
>=20
> Jan Kiszka wrote:
>> Sean McGranaghan wrote:
>>  =20
>>> Hello all,
>>>
>>> I have been writing an RTDM driver for an ISA (PC/104) based DAQ boar=
d. I had=20
>>> the initial driver working under a very old trunk snapshot (Rev 464).=
 This=20
>>> morning I upgraded to the latest trunk. I put a few small fixes into =
my driver=20
>>> and test application to take care of some deprecated functions and co=
nstants.=20
>>> (rt_queue_recv() and RT_IRQ_ENABLED). It appears that my driver is no=
 longer=20
>>> receiving interrupts. I can see the irq line go active on the oscillo=
scope but=20
>>> it is never cleared and it appears my interrupt handler is never call=
ed.
>>>
>>> I ran the test suite including xeno-test with no problems. Attached a=
re output=20
>>> files from dmesg, xeno-config and xeno-test outputs. My kernel config=
 file is=20
>>> also attached.
>>>
>>> At this point I think I need to turn on some debugging in the kernel.=
 Which=20
>>> debug options would be appropriate here?.
>>>
>>>    =20
>>
>> First of all, what does /proc/xenomai/irq tell you about your DAQ IRQ?=

>> Is it registered correctly? Are there any arrivals noted?
>>
>>  =20
> The counters in /proc/xenomai/irq do not appear to be incrementing. I c=
an see my=20
> irq number allocated while the device is open, and removed when the dev=
ice is=20
> closed. The interrupt number does not increment.
>=20
> Also, the oscilloscope shows the interrupt going active (hi) but never =
in-active=20
> (lo). Is it never acknowledged via IPIPE or Linux?

Then you should at least see a single event in the stats under /proc, do
you?

What about rtdm_irq_enable, do you call it after requesting the line?

>> Then double-check if you pass the correct code on return from the IRQ
>> handler: either RTDM_IRQ_HANDLED (if that IRQ was for you - standard),=

>> or RTDM_IRQ_NONE. Nothing else (RT_IRQ_ENABLE is "native stuff", i.e.
>> violates the rule to keep your driver clean from non-RTDM APIs).
>>
>>  =20
> I verified that I am returning RTDM_IRQ_HANDLED.
>> Regarding debugging options: CONFIG_XENO_OPT_DEBUG_RTDM is highly
>> recommended for drivers under development.
>>
>>  =20
> Now enabled.
>> Jan
>>
>>  =20

Jan


--------------enigA7C1942AE72246CE0FAFD5C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERm11niDOoMHTA+kRAnHWAJ0ekWpf8NvGPbS+j2yX9DS1ZehnpACcCTCn
mbKLREAifYQ9w+DiwZhrf1U=
=PkKh
-----END PGP SIGNATURE-----

--------------enigA7C1942AE72246CE0FAFD5C2--

