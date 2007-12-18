Message-ID: <4767FA80.1060403@domain.hid>
Date: Tue, 18 Dec 2007 18:51:12 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
References: <0C9896A4B6D338488AD6FFFE58BAEF1001DB8EEF@serveur3.lgm.com>
	<4762A57F.2020909@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF1001EECC33@domain.hid>
In-Reply-To: <0C9896A4B6D338488AD6FFFE58BAEF1001EECC33@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] CP-118U RTDM Driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DOURNES Guillaume <Guillaume.DOURNES@lgm.fr>
Cc: xenomai@xenomai.org

DOURNES Guillaume =D0=C9=DB=C5=D4:

>=20
> modprobe xeno_16550A io=3D0xba30 irq=3D5
> FATAL: Error inserting xeno_16550A (/lib/modules/2.6.23-xenomai/kernel/=
drivers/xenomai/serial/xeno_16550A.ko): Device or resource busy
>=20
> The modprobe work only if I remove the mxser driver by rmmod mxser
you should rmmod mxser


> In this case, the captain example is running correctly, but the rxevent=
 never happens, whereas this example work correctly with mother board por=
t.
Do not forget about *baud_base* parameter:=20
http://www.xenomai.org/index.php/16550A


--=20
________________________________________
Maksym Veremeyenko

