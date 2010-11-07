Message-ID: <4CD678AA.8010804@domain.hid>
Date: Sun, 07 Nov 2010 11:00:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	
	<4CD1E890.5010702@domain.hid>	<4CD1EC2F.4040603@domain.hid>	
	<4CD1ED16.8030103@domain.hid>	<4CD1EDA8.10007@domain.hid>	
	<4CD1F33C.5070208@domain.hid>	<4CD1F3F5.5080505@domain.hid>	
	<4CD1F4FE.9020908@domain.hid>	<4CD1F69B.9070100@domain.hid>	
	<4CD1F906.1070703@domain.hid>	<4CD1FABD.1080301@domain.hid>	
	<4CD2612C.2070507@domain.hid>	<4CD279F7.7070502@domain.hid>	
	<4CD27C46.8010302@domain.hid>	<4CD27DC2.7060607@domain.hid>	
	<4CD2A96B.3080001@domain.hid>	<4CD2B2A7.9010900@domain.hid>	
	<4CD2C50F.1090604@domain.hid>	<4CD32E76.3080004@domain.hid>	
	<4CD33F0C.1050403@domain.hid>	<4CD340AA.60002@domain.hid>	
	<4CD34355.5020304@domain.hid> <4CD35DC7.1000507@domain.hid>	
	<4CD3DAC5.6000400@domain.hid> <4CD4A0EF.1@domain.hid>	
	<4CD5B9FC.6050602@domain.hid> <4CD5BC82.6060106@domain.hid>
	<1289083796.1842.239.camel@domain.hid> <4CD5FA26.4090504@domain.hid>
	<4CD663F2.2080704@domain.hid> <4CD6756A.4040806@domain.hid>
	<4CD67825.2080004@domain.hid>
In-Reply-To: <4CD67825.2080004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD41211E6D2E990B6BD42B385"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD41211E6D2E990B6BD42B385
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 07.11.2010 10:57, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Am 07.11.2010 09:31, Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>>>> Anyway, after some thoughts, I think we are going to try and make =
the
>>>>>> current situation work instead of going back to the old way.
>>>>>>
>>>>>> You can find the patch which attempts to do so here:
>>>>>> http://sisyphus.hd.free.fr/~gilles/sched_status.txt
>>>>> Ack. At last, this addresses the real issues without asking for
>>>>> regression funkiness: fix the lack of barrier before testing XNSCHE=
D in
>>>> Check the kernel, we actually need it on both sides. Wherever the fi=
nal
>>>> barriers will be, we should leave a comment behind why they are ther=
e.
>>>> Could be picked up from kernel/smp.c.
>>> We have it on both sides: the non-local flags are modified while hold=
ing
>>> the nklock. Unlocking the nklock implies a barrier.
>>
>> I think this does not work if nklock is used nested, ie. hold across
>> xnsched_set_resched and the next xnpod_schedule.
>=20
> Ok. There is a race here, even without nesting, we need a barrier befor=
e
> sending the IPI.
>=20
>>>> I do not understand the split logic - or some bits are simply not ye=
t
>>>> migrated. XNHDEFER, XNSWLOCK, XNKCOUT are all local-only as well, no=
?
>>>> Then better put them in the _local_ status field, that's more consis=
tent
>>>> (and would help if we once wanted to optimize their cache line usage=
).
>>> Maybe the naming is not good the. ->status is everything which is
>>> modified under nklock, ->lstatus is for XNINIRQ and XNHTICK which are=

>>> modified without holding the nklock.
>>
>> And this is not a good clustering IMHO as it makes no difference for a=

>> local-only flag if it is protected by nklock or not (as long as IRQs a=
re
>> off, of course). What makes a difference it the CPU using the related
>> field. If we group according to local and remote usage, less cache lin=
e
>> bouncing can be achieved (of both fields are also cache line aligned,
>> but that is a second step that only helps if the first is made).
>=20
> The two status are in the same cache line.
>=20

Which can (and likely should) be changed - if the fields are logically
separated first.

Jan


--------------enigD41211E6D2E990B6BD42B385
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzWeKoACgkQitSsb3rl5xQxEACgvlRLn4TuAz47l3X+igZPUQPu
FMAAnRadnGvr2Fo5d6JXZKh9ZPXLLeG3
=krp9
-----END PGP SIGNATURE-----

--------------enigD41211E6D2E990B6BD42B385--

