From: Anders Bach Madsen <abm@domain.hid>
Date: Wed, 10 Nov 2010 15:32:07 +0100
Message-ID: <169292FFF5F27141906C787A21B56C402E4320954C@RD01.rd.local>
References: <169292FFF5F27141906C787A21B56C402E4320953C@RD01.rd.local>
	<201011101343.19148.smolorz@domain.hid>
In-Reply-To: <201011101343.19148.smolorz@domain.hid>
Content-Language: da-DK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Socket can devices?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thank you very much for the clarification, but this just raises my next que=
stion. How can I use canFestival and the RTDM socket api? I can't seem to f=
ind any information on this, not on the xenomai page or on the canfestival =
page.=20

Are there anybody who is using canfestival together with RTDM can drivers? =
And can you provide a pointer to where I can find more information or provi=
de some. That you be of great help.

/Anders

-----Oprindelig meddelelse-----
Fra: Sebastian Smolorz [mailto:smolorz@domain.hid
Sendt: 10. november 2010 13:43
Til: Anders Bach Madsen
Cc: xenomai@xenomai.org
Emne: Re: [Xenomai-help] Socket can devices?

Anders Bach Madsen wrote:
> We have installed a Xenomai system on a Atom based computer, which runs
> fine. We have connected a CAN card, which should be supported by the
> RT-Socket-CAN drivers in Xenomai. The card is also identified during
> boot and the proper kernel modules are loaded. We are however unable to
> create device nodes for this card, as we cannot find it in the list of
> devices!
>=20
> Any suggestions on how to create the device files /dev/rtcan0 and
> /dev/rtcan1 ?

There are no device nodes for RT-Socket-CAN devices. You are supposed to us=
e=20
the RTDM socket API. See the Xenomai examples and utils for usage examples:

http://www.rts.uni-hannover.de/xenomai/lxr/source/src/utils/can/rtcansend.c

--=20
Sebastian


