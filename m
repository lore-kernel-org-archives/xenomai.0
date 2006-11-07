Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
Date: Tue, 7 Nov 2006 14:45:35 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB014DF00D@is-hdq-exchange.marel.net>
In-Reply-To: <455099B2.5030402@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
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

Wolfgang Grandegger wrote:

> On a Rev. B you normally set the CAN system clock to 33MHz via kernel
> configuration parameter. Is CAN TX/RX on PSC2?=20

Yes 33 MHz was the magic number. Hmmm, shouldn't that not be set
automatically if MPC5200B is selected ?
The CAN in our case is on I2C1/TMR01


>> How do you setup your CAN network for a test ? Which commands do you
>> use ?
>=20
> Your setup with rtcanconfig was OK, or what do you mean.

I mean physically. E.g. for a MPC5200B with two CAN ports you could make
a send/receive ping/pong with a sort of nullmodem cable. Additionally
you need a test case. Just wanted to know how your test setup looks
like.


> Do you have terminators on both ends of the cable?

Yes everything is fine here.


Best regards,

Daniel.

