Message-ID: <894886ec0810012245i679ab8f7o44ae6f50efcc853f@domain.hid>
Date: Wed, 1 Oct 2008 22:45:42 -0700
From: "Rob Wheeler" <wheeler@domain.hid>
In-Reply-To: <48D62445.6090305@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7ed3bc8b0809171347j6744978ck69959990435942ea@domain.hid>
	<48D176F0.7060805@domain.hid>
	<894886ec0809181640t3d413a73h5c02da73dc3000c9@domain.hid>
	<48D34936.7090206@domain.hid>
	<894886ec0809191008m3b1eac19s45a1d67316eba626@domain.hid>
	<48D62445.6090305@domain.hid>
Subject: Re: [Xenomai-help] Xenomai IRQ Disable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: soa@domain.hid, xenomai@xenomai.org

Jan (or anyone else "in the know"),

If I don't have the irqpoll option set for my kernel, then I can't
even boot my machine with a USB keyboard and mouse attached.  The boot
hangs complaining about disabling IRQ #19.  Unfortunately, I don't
have a good setup to capture the output from the boot because it
scrolls off the screen too quickly, the keyboard is non-functional
after IRQ #19 is disabled, and the machine I'm running on (AOpen XC
mini) doesn't even have a serial port for a remote console.

Once the machine is up and running (with irqpoll option enabled) we
see flaky behavior from other drivers.  Occasionally the USB network
adapter dies, sometimes the video driver mysteriously stops supporting
the monitor we are using.  None of this behavior is evident on the
same hardware platform running a plain vanilla kernel.

We'd really like to figure out how to move forward with Xenomai on our
platform, but the current issues are definite showstoppers.  Any
advice on how I can proceed and debug the problem?

-R

