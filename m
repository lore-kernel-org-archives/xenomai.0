From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] Re: [Socketcan-users] send error: permission denied
Date: Mon, 21 Aug 2006 21:52:24 +0200
References: <DD39B5C3F4963040ADC9768BE7E430CBFFAD9F@is-hdq-exchange.marel.net>
	<44EA096D.9080208@domain.hid>
In-Reply-To: <44EA096D.9080208@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200608212152.25158.Sebastian.Smolorz@domain.hid>
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
Cc: socketcan-users@domain.hid, Daniel Schnell <danielsch@domain.hid>

Wolfgang Grandegger wrote:
> Hi Daniel,
>
> Daniel Schnell wrote:
> > Hi,
> >
> >
> >
> > I am new to socket can.
> >
> >
> >
> > I wanted to test the rtcan driver in combination with Linux and Xenomai
> > and made a little program according to the rtcansend program but with
> > some response time measurements.
> >
> >
> >
> > However after setting up the socket I get =96EPERM when trying to send a
> > packet to the can device. As the documentation doesn=92t state anything
> > about this error when calling rt_dev_send() I wonder why the error if at
> > all doesn=92t appear earlier if I try to setup the socket. The test
> > program already ran nicely when I tested the peak can drivers for linux.
> > I just changed the driver specific calls.
> >
> >
> >
> > Attached you find the complete test file, the function task() is the one
> > to blame.
> >
> >
> >
> > I am a bit stuck with this, so maybe someone can give me a slight hint
> > in what i am doing wrong.
>
> I tried your program on my system and got the same error. The problem
> is, that rt_dev_send() is called from non-RT context, which is illegal.
> At a first glance, it's not obvious to me why. Therefore I added the
> Xenomai Help ML to the CCs.

In short: Here we have a real time driver, and the send and receive routine=
s=20
are the time critical ones. They use synchronisation services of the=20
underlying RTOS which must not be called from a normal Linux task (e.g.=20
rtdm_sem_timeddown).

If you really want to send or receive CAN messages from non-RT context - us=
e=20
the Socket-CAN patch available for normal NRT-Linux from which the RTDM CAN=
=20
profile is derived from.

Sebastian

