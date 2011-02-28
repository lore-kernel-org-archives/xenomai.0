Date: Mon, 28 Feb 2011 19:46:09 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D6BA899.90600@domain.hid>
Message-ID: <alpine.DEB.1.10.1102281944470.12808@domain.hid>
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
	<4D6B9032.5060907@domain.hid>
	<alpine.DEB.1.10.1102281325340.12109@domain.hid>
	<4D6B92C8.3070505@domain.hid>
	<alpine.DEB.1.10.1102281342180.12109@domain.hid>
	<4D6B97E5.5030901@domain.hid>
	<alpine.DEB.1.10.1102281353490.12109@domain.hid>
	<4D6BA899.90600@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] More blackfin kernel oops under heavy load
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> I do not really understand what we are talking about. Are we talking
> about Linux select/accept or Xenomai select/accept? Why not using the

Linux select/accept. Using the blocking accept() would have changed the
behaviour somewhat compared to the original design. Anyway, I think that doesn't
actually matter much.

I have meanwhile derived a much smaller RTDM driver kernel module, test
application with blocking accept() ;) plus Makefile that do not depend on any
particular external hardware anymore: A SPORT interface (SPORT1 receiver) is
configured with internal clock and frame sync generation and so on itself
generates a lot of interrupts, and this alltogether quite quickly reproduces
the problem on my system. The files together are less than 1000 lines, 20kb.

I'd really appreciate if you or someone could take a look at it and maybe try
the code on his own bf537 system whether the same faults occur, and why. May I
post the files here (as a zipped attachment? inline)? I've already uploaded
a copy at

> http://www.ixo.de/tmp/till20110228.tgz

If I can do anything to make it more comfortable to try this, please let me know.

Short docs: The modt.c is derived from a larger "real" driver. I tried to strip
much processing code from it. It doesn't configure the SPORT interface to
really act reasonable anymore, just to generate a lot of interrupts, including
overflow error interrupts. After putting the path to the kernel into the
Makefile it should compile the module out-of-tree if you simply start "make".

The test application "till" starts one thread that continously contacts the
modt driver via ioctl. This ioctl does nothing but waits for an event that
is raised by the interrupts. The original application uses this ioctl()
to receive a pointer to a single received packet in mapped memory. I modified
the original driver so that it just receives data in the same buffer where
the original used a setup with a ring of several buffers.

Another thread accept()s incoming connections on port 80 and emits a small
chunk of text, enough to satisfy a simple wget.

In the current configuration, the fault occurs immediately after loading the
module and starting "till" on my system. Probably the SPORT configuration causes
much too many interrupts, but the fault still exactly looks like what I experience
in my real system. Previous setups required me to actually contact the server
and get some data, e.g. with

> while true; do wget http://host -O /dev/null ; done

1000x thanks for taking a look in advance... 
Kolja








