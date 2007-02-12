Message-ID: <45D0704D.9000304@domain.hid>
Date: Mon, 12 Feb 2007 14:49:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] trunk: screwed Linux irq state
References: <45CF951B.8080404@domain.hid>	<1171233732.5035.24.camel@domain.hid>	
	<17871.41373.425284.839228@domain.hid>	
	<1171237780.5035.30.camel@domain.hid>	
	<17871.45750.434103.944040@domain.hid>	<45CFB49F.1050000@domain.hid>	
	<45CFBE7B.3050906@domain.hid> <45D05431.10409@domain.hid>	
	<45D068C0.8090208@domain.hid> <1171287998.5001.4.camel@domain.hid>
In-Reply-To: <1171287998.5001.4.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB1960A706CA17AB3281C3929"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1960A706CA17AB3281C3929
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2007-02-12 at 14:16 +0100, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>
>>>> 2.6.19 didn't magically start to work as well. Instead I have a back=

>>>> trace now, see attachment.
>>>>
>>>> I included a full set of 16k points, but the thrilling things are ar=
ound
>>>> -73 to -25: Some Linux process with IRQs on gets preempted by an RT-=
IRQ
>>>> (RTnet NIC). That triggers an RT kernel thread to run for a while (R=
Tnet
>>>> stack manager, prio 98). But when returning to Linux again, its IRQs=

>>>> remain masked now. The reason must be that weird exception at -62. D=
on't
>>>> know where it comes from and why is there no report about THAT issue=
 in
>>>> the kernel logs.
>>>
>>> The cause of this page fault will get tracked down later today, but t=
he
>>> way it is handled already causes some doubts to me. To make discussio=
n
>>> easier, here is the relevant excerpt from the trace:
>> Maybe this fault is due to the No-cow patch ? Before the no-cow patch,=

>> vmalloced areas were added to all processes page directories, now they=

>> are added only to the page directories of processes with the VM_PINNED=

>> flag. So, if ipipe_test_root tries to access some module memory area
>> over the context of a non-realtime thread, a fault will occur.
>>
>=20
> Yes, it's a minor fault occurring due to on-demand memory mapping, this=

> is why we don't get any alarming message in the kernel log.
>=20

Looks like it's something that should never happen, for sure. But are we
fine with screwing up the Linux IRQ state nevertheless? In other words,
are we seeing one or two ipipe issues here?


--------------enigB1960A706CA17AB3281C3929
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0HBNniDOoMHTA+kRAszqAJ44jJ6uLhWsRIkl7bgkHFlxK9M0bgCfcJ2/
Qax80HyfKrl1miakfg53y8o=
=H5s4
-----END PGP SIGNATURE-----

--------------enigB1960A706CA17AB3281C3929--

