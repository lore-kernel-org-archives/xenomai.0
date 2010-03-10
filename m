From: "Charlton, John" <john.charlton@domain.hid>
Date: Wed, 10 Mar 2010 10:46:07 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE20076A70F4CC@us194mx002.tycoelectronics.net>
References: <4B97B141.4080703@domain.hid> <4B97B298.4080304@domain.hid>
In-Reply-To: <4B97B298.4080304@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-core] xeno-config --skin=posix --ldflags
	lacks	wrapping switches
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This change was causing us some problems with posix threads using an rtcan =
socket for CAN communications.  The error being returned was: Operation not=
 permitted.  When I reverted to the old version using --posix-ldflags the e=
rror went away.

Thanks,
--
John

-----Original Message-----
From: xenomai-core-bounces@domain.hid [mailto:xenomai-core-bounces@domain.hid] On=
 Behalf Of Gilles Chanteperdrix
Sent: Wednesday, March 10, 2010 9:54 AM
To: Jan Kiszka
Cc: xenomai-core
Subject: Re: [Xenomai-core] xeno-config --skin=3Dposix --ldflags lacks wrap=
ping switches

Jan Kiszka wrote:
> Hi Gilles,
>=20
> in contrast to --posix-ldflags, the new --skin=3Dposix --ldflags does=20
> not include the wrapping switches - intentionally? If yes, what is the=20
> official way to obtain them now?

No, that is completely unintentional.

--=20
					    Gilles.

_______________________________________________
Xenomai-core mailing list
Xenomai-core@domain.hid
https://mail.gna.org/listinfo/xenomai-core

