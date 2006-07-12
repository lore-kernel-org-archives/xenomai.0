Message-ID: <44B4B7FD.2060302@domain.hid>
Date: Wed, 12 Jul 2006 10:51:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>	
	<44B341E2.9040506@domain.hid>	
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>	
	<4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>	
	<44B35346.2070200@domain.hid>	
	<4546494d0607110043x45804030td009ed790040420b@domain.hid>	
	<4546494d0607111851t3d432f80offde2c1a2ef37689@domain.hid>	
	<44B497FE.9090207@domain.hid>	
	<4546494d0607120034l3635fb89yda1c79bcbd6c196b@domain.hid>	
	<44B4AA17.2050708@domain.hid>
	<4546494d0607120124t6a38b19dp8e9f4514c64309a2@domain.hid>
In-Reply-To: <4546494d0607120124t6a38b19dp8e9f4514c64309a2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD88ECB65582BDBC2DD0C2C33"
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
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD88ECB65582BDBC2DD0C2C33
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> But how to handle the situation when, e.g, a normal Linux task( in kern=
el
> space) and a Xenomai task (in kernel space),
> they share a global data structure. The Linux task want to block the
> Xenomai
> task for a while when it handles this data structure, while
> at the same time HW interrupt is enabled? When the data is ready, Xenom=
ai
> task is waken up.

Simply turn the Linux task into a Xenomai task (set priority to 0 if the
task has otherwise no RT jobs) and use a mutex. That's far cleaner than
playing with suspend/resume anyway.

Jan


--------------enigD88ECB65582BDBC2DD0C2C33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtLf+niDOoMHTA+kRAgSaAJwMTUbW6Nc7sYWEolYjCzgHOXPdvgCeJEf/
2nnMJMLLoCAgWjfG5J9bbbs=
=/uBV
-----END PGP SIGNATURE-----

--------------enigD88ECB65582BDBC2DD0C2C33--

