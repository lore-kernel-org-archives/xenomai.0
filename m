Message-ID: <4CD67A92.5090009@domain.hid>
Date: Sun, 07 Nov 2010 11:08:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	 <4CD1DE12.5010309@domain.hid>	
	<4CD1E890.5010702@domain.hid>	 <4CD1EC2F.4040603@domain.hid>	
	<4CD1ED16.8030103@domain.hid>	 <4CD1EDA8.10007@domain.hid>	
	<4CD1F33C.5070208@domain.hid>	 <4CD1F3F5.5080505@domain.hid>	
	<4CD1F4FE.9020908@domain.hid>	 <4CD1F69B.9070100@domain.hid>	
	<4CD1F906.1070703@domain.hid>	 <4CD1FABD.1080301@domain.hid>	
	<4CD2612C.2070507@domain.hid>	 <4CD279F7.7070502@domain.hid>	
	<4CD27C46.8010302@domain.hid>	 <4CD27DC2.7060607@domain.hid>	
	<4CD2A96B.3080001@domain.hid>	 <4CD2B2A7.9010900@domain.hid>	
	<4CD2C50F.1090604@domain.hid>	 <4CD32E76.3080004@domain.hid>	
	<4CD33F0C.1050403@domain.hid>	 <4CD340AA.60002@domain.hid>	
	<4CD34355.5020304@domain.hid>	 <4CD35DC7.1000507@domain.hid>	
	<4CD3DAC5.6000400@domain.hid>	 <4CD4A0EF.1@domain.hid>	
	<4CD5B9FC.6050602@domain.hid>	 <4CD5BC82.6060106@domain.hid>
	<1289083796.1842.239.camel@domain.hid>	 <4CD5FA26.4090504@domain.hid>
	<4CD663F2.2080704@domain.hid> <1289124227.1842.283.camel@domain.hid
	shift>
In-Reply-To: <1289124227.1842.283.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig00F0D1A44537E08742EFA0BD"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig00F0D1A44537E08742EFA0BD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 07.11.2010 11:03, Philippe Gerum wrote:
> On Sun, 2010-11-07 at 09:31 +0100, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>>>> Anyway, after some thoughts, I think we are going to try and make t=
he
>>>>> current situation work instead of going back to the old way.
>>>>>
>>>>> You can find the patch which attempts to do so here:
>>>>> http://sisyphus.hd.free.fr/~gilles/sched_status.txt
>>>> Ack. At last, this addresses the real issues without asking for
>>>> regression funkiness: fix the lack of barrier before testing XNSCHED=
 in
>>>
>>> Check the kernel, we actually need it on both sides. Wherever the fin=
al
>>> barriers will be, we should leave a comment behind why they are there=
=2E
>>> Could be picked up from kernel/smp.c.
>>
>> We have it on both sides: the non-local flags are modified while holdi=
ng
>> the nklock. Unlocking the nklock implies a barrier.
>=20
> I think we may have an issue with this kind of construct:
>=20
> xnlock_get_irq*(&nklock)
> 	xnpod_resume/suspend/whatever_thread()
> 		xnlock_get_irq*(&nklock)
> 		...
> 		xnlock_put_irq*(&nklock)
> 	xnpod_schedule()
> 		xnlock_get_irq*(&nklock)
> 			send_ipi
> 			=3D=3D=3D=3D=3D> xnpod_schedule_handler on dest CPU
> 		xnlock_put_irq*(&nklock)
> xnlock_put_irq*(&nklock)
>=20
> The issue would be triggered by the use of recursive locking. In that
> case, the source CPU would only sync its cache when the lock is actuall=
y
> dropped by the outer xnlock_put_irq* call and the inner
> xnlock_get/put_irq* would not act as barriers, so the remote
> rescheduling handler won't always see the XNSCHED update done remotely,=

> and may lead to a no-op. So we need a barrier before sending the IPI in=

> __xnpod_test_resched().

That's what I said.

And we need it on the reader side as an rmb().

Jan


--------------enig00F0D1A44537E08742EFA0BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzWepIACgkQitSsb3rl5xSppwCfQ12nzSdWqO1XBlr1iOzx2zTM
TqoAoOmCV0A4kI1T9wlaRA40ygsdr613
=mHFX
-----END PGP SIGNATURE-----

--------------enig00F0D1A44537E08742EFA0BD--

