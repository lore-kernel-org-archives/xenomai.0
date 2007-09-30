Message-ID: <46FF81BA.1020506@domain.hid>
Date: Sun, 30 Sep 2007 13:00:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46F9167F.20008@domain.hid> <1190756271.26427.0.camel@domain.hid>	
	<46FA26ED.4070505@domain.hid> <46FF78DF.7090104@domain.hid>
	<1191149545.5989.7.camel@domain.hid>
In-Reply-To: <1191149545.5989.7.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigED81365597DBB135FB856342"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Non-APIC setup broken for 2.4-SVN?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED81365597DBB135FB856342
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2007-09-30 at 12:22 +0200, Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> On Tue, 2007-09-25 at 16:09 +0200, Jan Kiszka wrote:
>>>>> Hi,
>>>>>
>>>>> to make it short has anyone or could anyone try latest SVN over ker=
nel=20
>>>>> 2.6.20 (i-pipe for 2.6.22 is instable) _without_ LAPIC? It works fo=
r me,=20
>>>>> but exposes milliseconds of latencies. Same setup with LAPIC enable=
d is=20
>>>>> fine and obviously stable. Before digging into this (time is short =

>>>>> anyway), I would like to exclude problems of my notebook hardware.
>>>>>
>>>> Not confirmed here. Everything looks ok.
>>> Yes, I found a second box working fine with a comparable (though not =

>>> identical) config. I suspect some hw issue of my notebook now, but I =

>>> will try to look into this a bit deeper once time permits.
>> It was a correlation between trying to use the PIT while Linux fiddled=

>> with the HPET (when HPET is in use, the PIT cannot be programmed). See=

>> my attached warning patch which may prevent others from pulling hairs.=

>>
>=20
> Yes, this one looks better than the previous attempt to prevent HPET
> +Xenomai globally which would create unwanted situations with x86_64
> IIRC. I'll test this, and will probably merge.

Great.

>=20
>>> More important is to understand and fix the consistent 2.6.22 issues =
I=20
>>> see. Only works in qemu for me, all real i386 boxes lock up sooner or=
=20
>>> later. :-/
>> I'm on this. Multiple bugs are involved, at least one of them is visib=
le
>> already with vanilla on my work notebook.
>=20
> Do you work with 2.6.22 baseline, or the latest stable update?

2.6.22.7 and .23-rc8. Both hang hard when I play with the backlight keys
of my Fujitsu-Siemens Lifebook, while this works fine (with and without
Xenomai) under 2.6.20.20. Weird.

>=20
>>  Another one is related to
>> Xenomai not dealing with the lapic device being in
>> CLOCK_EVT_MODE_SHUTDOWN whenever the NMI watchdog is in use.
>=20
> Btw, I have a patch for the latest issue we talked about regarding
> kernel-disabled LAPIC. It changes the generic inner interface a bit for=

> other archs too, so I will commit this asap.

Looking forward!

>=20
>>  And a third
>> one only gives me "Detected illicit call from domain Xenomai" before t=
he
>> box reboots. :(
>=20
> Grmff... Do you run with your smp_processor_id() instrumentation in?

Yes, but I suspect this is just a symptom of some severe memory
corruption that (also?) hits I-pipe data structures. I just put in some
different instrumentation, and that warning is gone, the box just hangs
hard at a different point. Very unfriendly.

Jan


--------------enigED81365597DBB135FB856342
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG/4G6niDOoMHTA+kRAm8xAJ9wEJQZhkrk+REZBGn9mPnNeaT+LACfZdiY
usSB7WzOYhtrJuRawpkdRSk=
=YJjy
-----END PGP SIGNATURE-----

--------------enigED81365597DBB135FB856342--

