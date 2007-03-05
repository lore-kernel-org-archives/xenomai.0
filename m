Message-ID: <45EC4D36.2000600@domain.hid>
Date: Mon, 05 Mar 2007 17:02:46 +0000
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN errors and real-time behaviour (IRQ raise
	forever and may lock system)
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HOBKy-0000tp-Kt@domain.hid> <45EC2FCF.70601@domain.hid>
	<E1HOEOb-0000Hu-1R@mailer.emlix.com>
In-Reply-To: <E1HOEOb-0000Hu-1R@mailer.emlix.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> St=E9phane ANCELOT wrote:
>> Sebastian Smolorz wrote:
>>> Note that the current implementation of RT-Socket-CAN shows this
>>> behaviour on purpose. See also [1] ("may flood!"). Whether this is the
>>> right handling or not may be discussed here. I admit that the current
>>> implementation forces an application developer to take more
>>> responsibility but that is not a bug of the underlying driver/stack per
>>> se. Look, you don't connect anything to the CAN bus, start a *real-time*
>>> application which sends a message to a non-existent CAN node. This is an
>>> error situation an it is more than ever for a real-time task. So the
>>> proper reaction for a RT-application would be to handle those errors and
>>> e.g. shut down the CAN interface which in this case will force the CAN
>>> hardware to stop its endless attempts to send the message.
>> I agree and this is what I was doing , however this does not seem to
>> work as expected in the driver.
>=20
> What does not work? The shutdown and stopping transmitting the CAN messag=
es?
>=20
> --
> Sebastian
>=20
>=20
Yes, this is exactly what has happened to me and rolland problem , one=20
rtcansend launched and BEI interrupt come always....


since the error management shoudl be done by appplication process, I=20
think that BUS ERROR INTERRUPT can be reported however the ECC reading=20
must not be done by the interrupt routine.
Since it permits  a next bus error interrupt. the ECC reading should be=20
left to user application eg through an ioctl.

This  may be an option or a error mode selectable by the programmer at=20
startup .

what do you think ?
Regards
steph

