Message-ID: <4624D598.5070203@domain.hid>
Date: Tue, 17 Apr 2007 16:11:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221037@domain.hid>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C603221037@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Perfs and rt alarms questions.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

RAKOTOSALAMA, Nirilanto wrote:
> Hello everybody.
> 
> I managed to compile a stable kernel (the Scalability O(1) scheduler options seems to make my system freeze)
> xenomai 2.3.1 and vanilla 2.6.20.4, gcc 4.1.1 on FC6.
> 
> I'm programming and testing a xenomai support for a timer library using rt_alarm. The test program
> lauches the timer periodically and calculate the precision (difference between theoretical and practical results).
> 
> When I launch the latency test, the max latency I have doesn't exceed 10us. So I supposed the precision shouldn't 
> exceed 10 to 20us as well, No ? But sometimes, the precision exceed 30 to 60us. Is it normal ?
> Something wrong in the way I use rt alarms ? in the kernel configuration ?
> 
> I attach : 
> 	- .config
> 	- tests results with overtime with this actual config
> 	- tests results without overtime I had with an old config (unfortunately I cannot restore it). The precision was less than 
> 		8us, I didn't enable xeno debug option. I haven't managed to get such high precision since I recompiled my kernel.
> 	- test program test_stability_trace.c
> 	- xenomai timer library support implementation support_xenomai.c
> 
> Thanks in advance.

You should use pthread_setschedparam instead of sched_setscheduler.

-- 
                                                 Gilles Chanteperdrix

