Message-ID: <45F31AB6.2050503@domain.hid>
Date: Sat, 10 Mar 2007 21:53:10 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN errors and real-time behaviour (IRQ raise
	forever and may lock system)
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>	<E1HOEOb-0000Hu-1R@mailer.emlix.com>
	<45EC4D36.2000600@domain.hid> <E1HOW5u-0006Ap-EW@mailer.emlix.com>
In-Reply-To: <E1HOW5u-0006Ap-EW@mailer.emlix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
>>> St=E9phane ANCELOT wrote:
>>>> Sebastian Smolorz wrote:
>>>>> Note that the current implementation of RT-Socket-CAN shows this
>>>>> behaviour on purpose. See also [1] ("may flood!"). Whether this is =
the
>>>>> right handling or not may be discussed here. I admit that the curre=
nt
>>>>> implementation forces an application developer to take more
>>>>> responsibility but that is not a bug of the underlying driver/stack=
 per
>>>>> se. Look, you don't connect anything to the CAN bus, start a
>>>>> *real-time* application which sends a message to a non-existent CAN
>>>>> node. This is an error situation an it is more than ever for a
>>>>> real-time task. So the proper reaction for a RT-application would b=
e to
>>>>> handle those errors and e.g. shut down the CAN interface which in t=
his
>>>>> case will force the CAN hardware to stop its endless attempts to se=
nd
>>>>> the message.
>>>> I agree and this is what I was doing , however this does not seem to
>>>> work as expected in the driver.
>>> What does not work? The shutdown and stopping transmitting the CAN
>>> messages?
>>>
>>> --
>>> Sebastian
>> Yes, this is exactly what has happened to me and rolland problem , one
>> rtcansend launched and BEI interrupt come always....
>=20
> Yes, I know. But when you stop the CAN interface in such a situation th=
e=20
> interrupts must disappear because the controller does not try to send t=
he=20
> message any more.
>=20
>> since the error management shoudl be done by appplication process, I
>> think that BUS ERROR INTERRUPT can be reported however the ECC reading
>> must not be done by the interrupt routine.
>=20
> I don't think that reading the ECC is the critical point, rather the in=
terrupt=20
> flodding is.
>=20
>> Since it permits  a next bus error interrupt. the ECC reading should b=
e
>> left to user application eg through an ioctl.
>=20
> Error reporting in RT-Socket-CAN is the same as in Socket-CAN for plain=
 Linux.
> It is done via error frames sent to the application. So  your suggestio=
n would=20
> break the API here and frankly is not necessary. You have several=20
> possibilities to detect a bus error due to a disconnected bus and can h=
andle=20
> the situation properly (e.g. restart the interface). If a series of err=
or=20
> frames are generated which shows you TX bus errors with missing=20
> acknowledgments you can be quite sure that no other node is connected t=
o the=20
> bus.
>=20
>> This  may be an option or a error mode selectable by the programmer at
>> startup .
>>
>> what do you think ?
>=20
> Last summer we had a discussion about the BEI issue on the socketcan-ML=
. Two=20
> additional handling policies popped up:
> 1. The interface could restart itself after an amount of BEIs, thus tak=
ing=20
> responsibility from the user application.
> 2. The BEI could be completely disabled if no one is interested in this=
 type=20
> of error frame.

I personally prefer 2. More below...

>=20
> Maybe it is time to think about the implementation of these policies as=
 more=20
> and more users seem to run into the BEI issue with a disconnected bus.=20
> Wolfgang, Jan, what is your opinion?

Just trying to catch up with this issue. As you mention, it has already=20
been discussed on the Socket-CAN mailing list. Just follow=20
https://lists.berlios.de/pipermail/socketcan-core/2006-July/000215.html.
I realized as well, that it is easily possible, to flood the system with=20
BIE interrupts, especially on low end systems. The problem gets worse,=20
when the error frames are delivered to the socket or even printk debug=20
messages are generated due to buffer overflows. The latter can be=20
suppressed by disabling RTCAN debugging (via XENO_DRIVERS_CAN_DEBUG).=20
Then the system normally will _not_ hang because the interrupt rate is=20
not critical. Nevertheless, this issue should be re-discussed on the=20
Socket-CAN mailing list. I will not accept a rt-only only solution.

Wolfgang.




