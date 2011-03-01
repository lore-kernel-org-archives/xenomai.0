Date: Tue, 1 Mar 2011 11:50:33 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1102281944470.12808@domain.hid>
Message-ID: <alpine.DEB.1.10.1103011145430.14165@domain.hid>
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
	<4D6B9032.5060907@domain.hid>
	<alpine.DEB.1.10.1102281325340.12109@domain.hid>
	<4D6B92C8.3070505@domain.hid>
	<alpine.DEB.1.10.1102281342180.12109@domain.hid>
	<4D6B97E5.5030901@domain.hid>
	<alpine.DEB.1.10.1102281353490.12109@domain.hid>
	<4D6BA899.90600@domain.hid>
	<alpine.DEB.1.10.1102281944470.12808@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] More blackfin kernel oops under heavy load
Reply-To: Kolja Waschk <xenoka09@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

>> http://www.ixo.de/tmp/till20110228.tgz

After verifying that no one yet checked, I updated the code in the archive to even better reflect the "real" situation. The main thread emits a number on stdout every second endlessly, waiting for SIGINT. To trigger the fault, it is necessary to contact the net server (with wget as I described) in a fast loop and after some time (about 2 seconds in my setup) the kernel fault occurs.

Parameters to tune the load on the system are the frame size (MODT_BUFLEN in modt.h) and a nop loop in till.c rtdm_loop() (line 84). The BF537 here is running with 133 MHz bus clock, 533 MHz system clock.

Kolja


