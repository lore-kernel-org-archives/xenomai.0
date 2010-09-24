Message-ID: <4C9D0ACB.1000004@domain.hid>
Date: Fri, 24 Sep 2010 22:32:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim0ROW9R84M2cmxBOKc3m2EUuPOUK5og0p5ErcN@mail.gmail.com>
In-Reply-To: <AANLkTim0ROW9R84M2cmxBOKc3m2EUuPOUK5og0p5ErcN@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_start returns -38 (ENOSYS)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: martin mangard <martin@domain.hid>
Cc: xenomai@xenomai.org

martin mangard wrote:
> Hello
> 
> I installed Xenomai on a x86 machine (kernel 2.6.30 wih xenomai
> 2.4.10). In order to verify the installation I ran the
> latency-testprogram from the test-suite.
> The latency test program aborts with the error ENOSYS :
> 
> 
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> latency: failed to start display task, code -38
> 
> This output ist generated if the call err =
> rt_task_start(&display_task, &display, NULL); ---> fails.
> 
> As mentioned in the documentation this error occurs, if not all
> necesary modules are loaded or configured.
> 
> during the startup following messages occur:
> 
> .
> .
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/i386 started.
> Xenomai: real-time nucleus v2.4.10 (Flavor Crystal 7) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> Xenomai: starting RTAI emulator.
> .
> .
> 

Please send us the full logs, from the boot up to the point where your
program fails.

-- 
                                                                Gilles.

