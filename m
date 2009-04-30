Message-ID: <49FA28F7.3060405@domain.hid>
Date: Thu, 30 Apr 2009 15:40:55 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <200904301508.29432@domain.hid> <200904301509.13094@domain.hid>	
	<200904301510.8382@domain.hid> <200904301511.15875@domain.hid>	
	<200904301512.9035@domain.hid> <200904301513.12716@domain.hid>	
	<200904301514.6099@domain.hid> <200904301515.16182@domain.hid>	
	<200904301516.696@domain.hid> <49F9B123.7080203@domain.hid>
	<1241103352.26544.177.camel@domain.hid>
In-Reply-To: <1241103352.26544.177.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>, "Lockhart, Thomas G" <thomas.g.lockhart@domain.hid>

> Xenomai always tells the kernel that blocking (Xenomai) syscalls
> _should_ be restarted when interrupted by a Linux signal (i.e.
> -ERESTARTSYS is passed down to the kernel by the Xenomai core in that
> case), and the kernel will actually restart that (Xenomai) syscall if no
> handler was installed for such signal, or if SA_RESTART is set in the
> sigaction() flags for the signal.

Thanks for the clarification. I was hoping my reply would expose my lack 
of understanding :)

So I'm getting what I think are great results on my system with my 
Xenomai-enabled software (a few usec jitter, ~10usec latency or offset 
without anything special done when building or calibrating Xenomai. The 
system is a fairly modern dual-processor Xeon desktop machine and 
Xenomai is 2.4.7; kernel is 2.6.26 (needed for a third party device 
driver which breaks with 2.6.27).

When running at a very low rate (10Hz) every 30 seconds or so there is a 
latency spike of around 50usec. Not bad (and acceptable for my system 
even at kHz rates), but it certainly stands out from the usual case.

Could this occasional extra latency be due to this signal interrupt and 
transparent restart? Or should I dig around elsewhere?

TIA

                           - Tom

