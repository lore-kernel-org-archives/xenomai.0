Message-ID: <4AF2DF52.6060805@domain.hid>
Date: Thu, 05 Nov 2009 15:21:06 +0100
From: Pierre Ficheux <pierre.ficheux@domain.hid>
MIME-Version: 1.0
References: <96eea0c80911042105r19d11a70w1d47de4427c00e58@domain.hid>
In-Reply-To: <96eea0c80911042105r19d11a70w1d47de4427c00e58@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] real-time parallel port communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Peter Pastor a =E9crit :
> Hello there,
>=20
> I need to get real-time communication over a parallel port working. I
> got the serial port to run in real-time using the drivers provided by
> xenomai. However, I haven't found similar drivers for the parallel port
> yet. Does the new analogy branch contain real-time drivers for the
> parallel port ??
>=20
> I would be happy for any hints. Also, would be cool if somebody could
> point me to some example programs.
>

I wrote a sample RTDM driver based on outb (char, 0x378). What do you
want to do with // port? input? output? interrupt? somthing like old
style "Centronics" ?

regards


--=20
Pierre FICHEUX -/- CTO OW/OS4I, France -\- pierre.ficheux@domain.hid
                                         http://www.os4i.com
                                         http://www.ficheux.org
I would love to change the world, but they won't give me the source code



