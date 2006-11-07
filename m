Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
Date: Tue, 7 Nov 2006 14:22:10 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB014DEFF0@domain.hid>
In-Reply-To: <45509220.1050506@domain.hid>
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
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
=20
> The first message seems not to go out to the wire and the second send
> blocks because the TX done interrupt of the first message has not yet
> occured (no TX hardware slot free). Is there a CAN node able to
> receive the message?  =20

Yes, there is an IO unit which normally reacts on that message
=20
> Likely, you have a problem with your clock setting, TX/RX routing or
> cabeling (termination etc.).=20


I would suspect it is the clock setting, as we have also problems with
clock_nanosleep() running 4 times too fast. I assume then that the IPB
clock frequency is wrong ?


How do you setup your CAN network for a test ? Which commands do you use
?

Best regards,

Daniel Schnell.

