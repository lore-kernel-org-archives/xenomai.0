From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN errors and real-time behaviour (IRQ raise
	forever and may lock system)
Date: Tue, 6 Mar 2007 10:36:40 +0100
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HOEOb-0000Hu-1R@mailer.emlix.com> <45EC4D36.2000600@domain.hid>
In-Reply-To: <45EC4D36.2000600@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <E1HOW5u-0006Ap-EW@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?iso-8859-1?q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai@xenomai.org

St=E9phane ANCELOT wrote:
> Sebastian Smolorz wrote:
> > St=E9phane ANCELOT wrote:
> >> Sebastian Smolorz wrote:
> >>> Note that the current implementation of RT-Socket-CAN shows this
> >>> behaviour on purpose. See also [1] ("may flood!"). Whether this is the
> >>> right handling or not may be discussed here. I admit that the current
> >>> implementation forces an application developer to take more
> >>> responsibility but that is not a bug of the underlying driver/stack p=
er
> >>> se. Look, you don't connect anything to the CAN bus, start a
> >>> *real-time* application which sends a message to a non-existent CAN
> >>> node. This is an error situation an it is more than ever for a
> >>> real-time task. So the proper reaction for a RT-application would be =
to
> >>> handle those errors and e.g. shut down the CAN interface which in this
> >>> case will force the CAN hardware to stop its endless attempts to send
> >>> the message.
> >>
> >> I agree and this is what I was doing , however this does not seem to
> >> work as expected in the driver.
> >
> > What does not work? The shutdown and stopping transmitting the CAN
> > messages?
> >
> > --
> > Sebastian
>
> Yes, this is exactly what has happened to me and rolland problem , one
> rtcansend launched and BEI interrupt come always....

Yes, I know. But when you stop the CAN interface in such a situation the=20
interrupts must disappear because the controller does not try to send the=20
message any more.

> since the error management shoudl be done by appplication process, I
> think that BUS ERROR INTERRUPT can be reported however the ECC reading
> must not be done by the interrupt routine.

I don't think that reading the ECC is the critical point, rather the interr=
upt=20
flodding is.

> Since it permits  a next bus error interrupt. the ECC reading should be
> left to user application eg through an ioctl.

Error reporting in RT-Socket-CAN is the same as in Socket-CAN for plain Lin=
ux.
It is done via error frames sent to the application. So  your suggestion wo=
uld=20
break the API here and frankly is not necessary. You have several=20
possibilities to detect a bus error due to a disconnected bus and can handl=
e=20
the situation properly (e.g. restart the interface). If a series of error=20
frames are generated which shows you TX bus errors with missing=20
acknowledgments you can be quite sure that no other node is connected to th=
e=20
bus.

>
> This  may be an option or a error mode selectable by the programmer at
> startup .
>
> what do you think ?

Last summer we had a discussion about the BEI issue on the socketcan-ML. Tw=
o=20
additional handling policies popped up:
1. The interface could restart itself after an amount of BEIs, thus taking=
=20
responsibility from the user application.
2. The BEI could be completely disabled if no one is interested in this typ=
e=20
of error frame.

Maybe it is time to think about the implementation of these policies as mor=
e=20
and more users seem to run into the BEI issue with a disconnected bus.=20
Wolfgang, Jan, what is your opinion?

=2D-=20
Sebastian

