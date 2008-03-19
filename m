Message-ID: <d6c8ef150803190410l48c36687odd494d3966407a8@domain.hid>
Date: Wed, 19 Mar 2008 12:10:37 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <2ff1a98a0803180723i17d6d6e1p619b9c8948b6e542@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803180527h71adc568o612fec284f8d096@domain.hid>
	<2ff1a98a0803180723i17d6d6e1p619b9c8948b6e542@domain.hid>
Subject: Re: [Xenomai-help] Handling irq
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

OK, thanks. I'll try that.

I have another problem. I have a task (kernel thread) that sleeps and
wakes up every (almost) 1ms (actually, task is reading sync timers
from EtherCAT and calculate how long should sleep). It is the only RT
task. After some time measuring different things it looks to me that
my task is interrupted from time to time (I can acknowledge that it is
interrupted every second time in different stages). I've measured time
needed for one single memcpy (I set one pin on microcontroller to 1
before memcpy, and set to 0 after it, using __raw_writel). Usually it
takes a few us, but, some times, time for memcpy just grows to 50us.
Is it possible that timer interrupt handler is stopping my task? How I
can mask/disable "all" interrupt handlers during that RT task
execution?

Thanks again! :)

Kind regards,
Bosko

