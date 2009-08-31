Message-ID: <4A9BE7CF.3030406@domain.hid>
Date: Mon, 31 Aug 2009 17:10:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0908281050l56343b26g45a8f66b87c839e9@domain.hid>	<4A981B54.4020908@domain.hid>
	<4A981C1E.8000904@domain.hid>	<7a15153d0908281209i5b133c53l4fa816993df7d0eb@domain.hid>	<4A982D08.4050802@domain.hid>
	<7a15153d0908310753s68f36dffg817df3cb9a16db06@domain.hid>
In-Reply-To: <7a15153d0908310753s68f36dffg817df3cb9a16db06@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PXA + Xenomai] Latency program
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

Felipe Castro wrote:
> hi !
> 
> I apllied the patch that you sent me, but there are some weird!
> When i run latency program the result is:
> 
> root@domain.hid$ /usr/xenomai/bin/latency
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:02  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|      83.384|     146.769|     189.538|    1803|      83.384|    
> 189.538

100us is to short a period for an ARM without FCSE enabled. Actually it
is also too short for an ARM with FCSE. Look at the latency: you are
asking a 100us period whereas the latency is 150us on average, don't you
see the problem?

You can try a period of 1ms, it is more reasonable. If you want periods
of 70us, you can not use an ARM.

> 
> 
> And than the program just freeze, and the kernel trace:
> 
> [  780.136217] Xenomai: Switching display-343 to secondary mode after
> exception #5 from user-space at 0x93e0 (pid 345)

That is another problem which should be fixed in the next Xenomai
release, which should happen real soon now.

-- 
                                          Gilles


