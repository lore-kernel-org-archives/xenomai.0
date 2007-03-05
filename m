From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN errors and real-time behaviour (IRQ raise
	forever and may lock system)
Date: Mon, 5 Mar 2007 15:42:45 +0100
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HOBKy-0000tp-Kt@domain.hid> <45EC2FCF.70601@domain.hid>
In-Reply-To: <45EC2FCF.70601@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <E1HOEOb-0000Hu-1R@mailer.emlix.com>
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
> > Note that the current implementation of RT-Socket-CAN shows this
> > behaviour on purpose. See also [1] ("may flood!"). Whether this is the
> > right handling or not may be discussed here. I admit that the current
> > implementation forces an application developer to take more
> > responsibility but that is not a bug of the underlying driver/stack per
> > se. Look, you don't connect anything to the CAN bus, start a *real-time*
> > application which sends a message to a non-existent CAN node. This is an
> > error situation an it is more than ever for a real-time task. So the
> > proper reaction for a RT-application would be to handle those errors and
> > e.g. shut down the CAN interface which in this case will force the CAN
> > hardware to stop its endless attempts to send the message.
>
> I agree and this is what I was doing , however this does not seem to
> work as expected in the driver.

What does not work? The shutdown and stopping transmitting the CAN messages?

=2D-
Sebastian

