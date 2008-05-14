MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18475.13143.765607.783126@domain.hid>
Date: Wed, 14 May 2008 20:45:43 +0200
In-Reply-To: <752338162@domain.hid>
References: <752338162@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Cross-Compile Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joachim Meyer <Jogi95@domain.hid>
Cc: xenomai@xenomai.org

Joachim Meyer wrote:
 > Hi
 > 
 > First I'd like to thank everybody who helped.
 > I think it works now (more or less).
 > I found someone who had the root passwort, so I could "make devices" for testing.
 > The tests in the testsuite also give out some things. 
 > 
 > Can anyone give me hints where to find documents for the following two things:
 > 
 > 1. Something about what should be the result of the tests in the testsuite or some documents about the testsuite at all.

Since the integration of Xenomai in the Debian distribution, Xenomai
testsuite programs have manual pages (but I do not think stable
releases have them yet). Anyway, we try to give tests names which
suggest what they do.

 > 
 > I get things like that:
 > 
 > bash-3.00# ./switchbench
 > == Sampling period: 100 us
 > == Do not interrupt this program
 > RTH|     lat min|     lat avg|     lat max|        lost
 > RTD|      -25970|       30476|       49003|       12491

switchbench measures (user-space) context switches time.

 > 
 > bash-3.00# ./latency
 > == Sampling period: 100 us
 > == Test mode: periodic user-mode task
 > == All results in microseconds
 > warming up...

latency measures latencies (user-space dispatch latency, kernel-space
dispatch latency, kernel-space interrupt latency, depending on the
argument passed to the -t option). Note that to run latency -t 1 or
latency -t 2, you will need to select the timerbench driver in kernel
configuration (Menu real-time subsystem/drivers/testing).

 > 
 > the result of the cycletest is, that the system freezes.

Well, maybe you run it with a too tight period ?

 > 
 > bash-3.00# modprobe xeno_irqbench
 > FATAL: Could not load /lib/modules/2.6.23xlnx/modules.dep: No such file or directory

Not Xenomai fault. You likely installed kernel modules incorrectly.

 > 
 > bash-3.00# ./switchtest
 > XSysAce: Queue is plugged
 > == Testing FPU check routines...
 > Illegal instruction
 > 
 > My PPC405 (on an Virtex 2 pro) has no FPU, I believe.

Well, then run switchtest with the -n flag. switchtest tries many kind
of context switches. It is probably only of some interest when debugging
context switch (and FPU switch) routines.

 > I haven't installed any modules yet, but I need modules for xenomai, do I?

This explains the failed modprobe xeno_irqbench. Whether or not you need
modules depends on what you decided to build inside the kernel and to
build as a module in the kernel configuration.

 > 
 > 
 > 2. Some Beginners Howto for programming with Xenomai

See the native API tour:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-rev-C.pdf
or other articles at:
http://www.xenomai.org/index.php/Publications

 > 
 > Thx 
 > Joachim
 > _____________________________________________________________________
 > Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
 > http://smartsurfer.web.de/?mc=100071&distributionid=000000000066
 > 


-- 


					    Gilles.

