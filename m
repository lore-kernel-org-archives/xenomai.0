Message-ID: <472F4763.3070003@domain.hid>
Date: Mon, 05 Nov 2007 17:40:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3d3b73870711050333y67cc2e1n98a5c96c3633c656@domain.hid>
In-Reply-To: <3d3b73870711050333y67cc2e1n98a5c96c3633c656@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-test failed to start in-kernel timer
 benchmark, code -25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hugo Braga <hugovaz@domain.hid>
Cc: xenomai@xenomai.org

Hugo Braga wrote:
> I ran xeno-test and I got the following failed message:
> 
> Seg Nov  5 10:30:38 BRT 2007
> running: ./run -- -sh -T 120 -t1 # latency
> *
> *
> * Type ^C to stop this application
> *
> *
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25

Before starting the test, make sure that the xeno_irqbench module is not
loaded (there are other workaround for this issue, but this one should
be the simplest). One day I really need to fix this, I'm afraid...

> 
> I enabled the following options as module in the kernel's configuration
> file:
> Real-time sub-system->Drivers->Testing drivers:
> *Timer benchmark driver
> * IRQ benchmark driver
> * Context switch unit testing driver
> 
> Also the system stopped when this message has been shown and I had to reboot
> the machine.
> My machine is:
> Intel Core 2 Duo 2.00GHz
> Intel Deskop Board D946GZIS
> I built linux 2.6.19.7 linux kernel with xenomai 2.3.4 and
> adeos-ipipe-2.6.19-i386-1.7-03.patch. I unchecked CPU frequency scaling,
> unchecked ACPI->Processor and unchecked APM.
> Please help me to solve the issue.
> 
> Thanks,
> Hugo
> 
> ps: Sorry if I made some mistakes in the statements above because I am
> learning English at this time.

No problem at all, your English is fine!

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

