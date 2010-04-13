Message-ID: <4BC5056D.9030307@domain.hid>
Date: Wed, 14 Apr 2010 01:59:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100331143432.44386sa8ez2p2q2o@domain.hid>	<4BB34F3A.3060105@domain.hid>
	<20100413101346.17138iq2ov0lt2ns@domain.hid>
In-Reply-To: <20100413101346.17138iq2ov0lt2ns@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9E24F6B46FC4B1F67C36A150"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] netrpc
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E24F6B46FC4B1F67C36A150
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michel He wrote:
> Hello Jan,
>=20
>       Thank you for your answer so quickly. The last time, I find out  =

> that the IPC (Xenomai) has strong correlation to the rpc =20
> implementation but it lacks the network addressing. If we look into =20
> the codes, we can not specifiy the remote destination in a variable =20
> like the sipc_address(not existing). So I imagine that AF_IPC is =20
> something purely local like the shared memory or the queues. Is it =20
> possible to make a remote connection in xenomai with the ipc protocols?=


PF_RTIPC is primarily targeting local communication channels. If you
think that this programming model is already sufficient to distribute
xrtai-lab, it should also be possible to map it on other socket types
like UDP (provided by RTnet) - and then you have node addressability.

Jan

>=20
> thanks
>=20
> Jan Kiszka <jan.kiszka@domain.hid> a =E9crit :
>=20
>> Michel He wrote:
>>> Hello all,
>>>
>>>     I'm currently trying to port xrtai-lab to xenomai, inside of it
>>> there's the netrpc interface used to make communication between tasks=
=2E
>>> However, there is no equivalent for Xenomai, which makes the port
>>> quite impossible !
>> Nothing is impossible. :)
>>
>>> So is there any chance to fulfill that, and with/or
>>> without RTNet ? To do that, it should have something to do with socke=
t
>>> programming. Any experience encountered it is welcomed.
>> Well, you could start with mapping the existing RTAI API calls in
>> xrtai-lab on local Native calls. That will already give you a
>> non-distributed port.
>>
>> But there is also no magic behind netrpc. It just uses RTnet for remot=
e
>> calls, and that works for Xenomai at least equally well. You could
>> simply write a RPC API extension for libnative (a pure user space job)=
=2E
>> That lib would do the routing, encapsulate and forward non-local calls=

>> to some sockets provided via the RTDM API.
>>
>> BTW, the same should be feasible for a POSIX-based API extension, whic=
h
>> would have the advantage of making the result easier portable to plain=

>> Linux.
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT T DE IT 1
>> Corporate Competence Center Embedded Linux
>>



--------------enig9E24F6B46FC4B1F67C36A150
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvFBXIACgkQitSsb3rl5xQ7BwCeKV+KUaCMwdc/l5IPP/TTaM1n
iiYAoNfMOKN1PmLBfDt+Ds5tlSRjBKzq
=nDyc
-----END PGP SIGNATURE-----

--------------enig9E24F6B46FC4B1F67C36A150--

