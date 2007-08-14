Message-ID: <46C15F20.7070504@domain.hid>
Date: Tue, 14 Aug 2007 09:52:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid>
	<46C07AF2.60402@domain.hid>	<46C07D73.7070302@domain.hid>
	<46C080C8.10906@domain.hid>	<46C0835E.8010105@domain.hid>
	<46C0B036.3030306@domain.hid>	<46C0B1DF.6090509@domain.hid>
	<46C0B9F7.9060103@domain.hid> <46C0D686.6000007@domain.hid>
	<46C14FE2.8000507@domain.hid> <46C15CBA.8010804@domain.hid>
In-Reply-To: <46C15CBA.8010804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig76FDDF469FD987DA7BBEB113"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtcan bufferoverflow but no evidence
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig76FDDF469FD987DA7BBEB113
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
>>> Recall that up to Xenomai 2.4 RTDM device/socket closing may fail (wi=
th
>>> -EAGAIN) when some other thread is currently using it and doesn't
>>> release it immediately when being "asked". That means for now you sho=
uld
>>> loop over [rt_dev_]close as long as EAGAIN is returned.
>>
>> Roland, could you please check the return code of [rt_dev_]close.
>> Nevertheless, I'm still puzzled why the socket shows up in
>> /proc/rtcan/sockets because rtcan_raw_close() is called before returni=
ng=20
> I have been battling with this all morning. I close with
>=20
> do{
>     ret=3Drt_dev_close(can_fd);
>     //printf("%d",ret)
> while(ret!=3D-9)
>=20
> but this only works (without fail) if I uncomment the printf line. I
> have now tried to put in a sleep(1) command instead but due to the cras=
h
> caused  by commenting out hte crash (does not come out of loop) I am no=
w
> trying to save my filesystem. :( :(.
>=20

That really sounds like this issue, just applied on CAN:

http://sourceforge.net/mailarchive/forum.php?thread_name=3D9203.194.114.6=
2.34.1186585293.squirrel%40webmail.krokoworld.de&forum_name=3Drtnet-users=


If yes, you would have found a second reason to look at 2.4... ;)

Jan


--------------enig76FDDF469FD987DA7BBEB113
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwV8gniDOoMHTA+kRApSlAJwM15UA0p21AQim1P03peKJRpP7ywCfYZQ3
k63uGGDBuAccQpdxNEvva74=
=PoIU
-----END PGP SIGNATURE-----

--------------enig76FDDF469FD987DA7BBEB113--

