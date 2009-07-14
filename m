Message-ID: <4A5CC870.3030208@domain.hid>
Date: Tue, 14 Jul 2009 20:03:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>
In-Reply-To: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM: userspace apps result in Segmentation fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Hi all,
> 
> I have a problem with running apps that are linked with the xenomai
> userspace libraries. At the startup of the apps, when loading these
> libraries the result is a segmentation fault.
> 
> I am using Xenomai version 2.4.8, but also tried the previous 2.4.7.
> The ARM platform is basically the same as the at91sam9263ek board. The
> Linux distribution is build with the OpenEmbedded (x11-image,
> Angstrom) cross-compile environment, 2.6.28 kernel.
> 
> Note: I have been able to run a kernel RTDM driver with success.
> 
> While debugging I have been able to trace untill the
> XENOMAI_DO_SYSCALL() in ./src/include/asm/xenomai

Do the Xenomai applications run?
Are you using gcc 4.3, if yes, switch to gcc 4.2, gcc 4.3 has a bug that
we can not workaround.
Have you built the kernel and xenomai user-space with compatible
settings with regard to EABI?


-- 
					    Gilles.

