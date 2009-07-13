MIME-Version: 1.0
Date: Mon, 13 Jul 2009 09:31:28 +0200
Message-ID: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] ARM: userspace apps result in Segmentation fault
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

Hi all,

I have a problem with running apps that are linked with the xenomai
userspace libraries. At the startup of the apps, when loading these
libraries the result is a segmentation fault.

I am using Xenomai version 2.4.8, but also tried the previous 2.4.7.
The ARM platform is basically the same as the at91sam9263ek board. The
Linux distribution is build with the OpenEmbedded (x11-image,
Angstrom) cross-compile environment, 2.6.28 kernel.

Note: I have been able to run a kernel RTDM driver with success.

While debugging I have been able to trace untill the
XENOMAI_DO_SYSCALL() in ./src/include/asm/xenomai

Any help is appreciated.

Thanks, Henri

