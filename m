Message-ID: <44EA096D.9080208@domain.hid>
Date: Mon, 21 Aug 2006 21:28:45 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CBFFAD9F@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CBFFAD9F@is-hdq-exchange.marel.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Re: [Socketcan-users] send error: permission denied
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <danielsch@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, socketcan-users@domain.hid

Hi Daniel,

Daniel Schnell wrote:
> Hi,
>=20
> =20
>=20
> I am new to socket can.
>=20
> =20
>=20
> I wanted to test the rtcan driver in combination with Linux and Xenomai=
=20
> and made a little program according to the rtcansend program but with=20
> some response time measurements.
>=20
> =20
>=20
> However after setting up the socket I get =96EPERM when trying to send =
a=20
> packet to the can device. As the documentation doesn=92t state anything=
=20
> about this error when calling rt_dev_send() I wonder why the error if a=
t=20
> all doesn=92t appear earlier if I try to setup the socket. The test=20
> program already ran nicely when I tested the peak can drivers for linux=
.=20
> I just changed the driver specific calls.
>=20
> =20
>=20
> Attached you find the complete test file, the function task() is the on=
e=20
> to blame.
>=20
> =20
>=20
> I am a bit stuck with this, so maybe someone can give me a slight hint=20
> in what i am doing wrong.

I tried your program on my system and got the same error. The problem=20
is, that rt_dev_send() is called from non-RT context, which is illegal.
At a first glance, it's not obvious to me why. Therefore I added the=20
Xenomai Help ML to the CCs.

Wolfgang.

