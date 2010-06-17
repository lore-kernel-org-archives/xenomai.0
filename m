Message-ID: <4C19E104.2010208@domain.hid>
Date: Thu, 17 Jun 2010 10:47:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>	<1274047063.2972.1.camel@domain.hid>	<2319761F7FA0D1479BA77EC2E0A8E7BCE8A603@domain.hid>	<1275033915.27918.31.camel@domain.hid>
	<2319761F7FA0D1479BA77EC2E0A8E7BCEDCE09@domain.hid>
	<4C191D07.4050203@domain.hid>
	<2319761F7FA0D1479BA77EC2E0A8E7BCEDCE75@domain.hid>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCEDCE75@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Abhijit Majumdar <abhijit.majumdar@domain.hid>
Cc: xenomai@xenomai.org, Steve Deiters <SteveDeiters@domain.hid>

Abhijit Majumdar wrote:
> Hi Gilles
> 
> I attached the kernel configuration.
> 
> Actually I sent whatever error message I saw in the console. However
> next couple of times I saw different error messages.
> 
> One time I saw --
> 
> WARNING: at
> /home/travis/projects/customers/pivotal_systems/workspace/linux-2.6.28-x
> enomai-pivotal/kernel/sched.c:4382 add_preempt_count+0x84
> /0x98()
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000c
> 
> 
> Another time ---
> 
> Xenomai: fatal: zombie thread ROOT (c03a0d10) would not die...
>  CPU  PID    PRI      TIMEOUT  STAT      NAME
>>  0  0       -1      0        00400080  ROOT
>    0  971      0      0        00200380  sleep_test
>    0  972     90      0        00200188  sleep_test
> Master time base: clock=91270892

Apparently, I have not made myself clear, so, I am going to try again.

So, from your configuration, I see that the ARM you are using is an
AT91SAM9G20.

First, try Xenomai 2.5.3 to see if you still get the bug.

If you still get the bug, then include in your full report the full
serial console log, from the boot up to the bug.

-- 
					    Gilles.

