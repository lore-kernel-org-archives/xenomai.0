Message-ID: <4B8B7540.609@domain.hid>
Date: Mon, 01 Mar 2010 09:05:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Nl4tX-0001N9-Hb@domain.hid>
	<4B881E9D.1050101@domain.hid>	<4B88203F.2020907@domain.hid>
	<4B8903E1.3020805@domain.hid>
In-Reply-To: <4B8903E1.3020805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE1CD0CF35DD5DEFDE767B5A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : RTDM+POSIX: Avoid
 leaking binding objects on errors
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE1CD0CF35DD5DEFDE767B5A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> GIT version control wrote:
>>>> diff --git a/ksrc/skins/posix/mq.c b/ksrc/skins/posix/mq.c
>>>> index 11f47c0..a896031 100644
>>>> --- a/ksrc/skins/posix/mq.c
>>>> +++ b/ksrc/skins/posix/mq.c
>>>> @@ -1283,6 +1283,7 @@ int pse51_mq_select_bind(mqd_t fd, struct xnse=
lector *selector,
>>>>  	return 0;
>>>> =20
>>>>        unlock_and_error:
>>>> +	xnfree(binding):
>>>>  	xnlock_put_irqrestore(&nklock, s);
>>>>  	return err;
>>>>  }
>>> Ok. Will pull. But I really need to fix that.
>>>
>> Ack - now that I see it myself.
>>
>=20
> I fixed this in my branch and added another patch to transform EIDRM
> into EBADF when selecting a (half-)deleted RTDM device. Please merge.
>=20

Wait! When the sync object behind some file descriptor is deleted but
the descriptor itself is still existing, we rather have to return that
fd signaled from select() instead of letting the call fail. I beed to
look into this again.

Jan


--------------enigEE1CD0CF35DD5DEFDE767B5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuLdUcACgkQitSsb3rl5xQRMACgtp0ekbEmyRn/t4AoAv8rA8cT
e5UAoNrhV6TfafBBOombxdn04oOiKARt
=xbWx
-----END PGP SIGNATURE-----

--------------enigEE1CD0CF35DD5DEFDE767B5A--

