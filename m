Message-ID: <47B43B64.2050506@domain.hid>
Date: Thu, 14 Feb 2008 14:00:20 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <000001c86190$df7e4b40$9e7ae1c0$@edu>	<200801281957.10873.Sebastian.Smolorz@domain.hid>
	<000601c86eb2$3a7fd7b0$af7f8710$@edu>
In-Reply-To: <000601c86eb2$3a7fd7b0$af7f8710$@edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [Xenomai-Help] Recommanded CAN Board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?67CV7J6s7ZuI?= <lordpark@domain.hid>
Cc: xenomai@xenomai.org

=EB=B0=95=EC=9E=AC=ED=9B=88 wrote:
> Hello.
>=20
> I have problem with my CAN communication board (PCM-3680).=20
>=20
> I couldn=E2=80=99t see any response on my board.=20
>=20
> So, I want to buy another board that work surely in xenomai. (Because I=
 spent so many times already, and I have no time..TT)
>=20
> Is there any recommended CAN communication board with pc/104 interface(=
except PCM-3680)?

We use the eNET-CAN card by Phytec (www.phytec.de). We have several of=20
them and they work flawlessly. I originally developed the RTDM CAN=20
driver for the SJA1000 for this card. So consider the Xenomai RTDM CAN=20
driver for it as very well tested. ;-)

--=20
Sebastian

