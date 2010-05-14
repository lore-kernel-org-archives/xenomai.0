From: Travis Stratman <tstratman@domain.hid>
In-Reply-To: <4BEDC668.40708@domain.hid>
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D72A@alpine.pivotalsys.com>
	<4BED7D5B.6050605@domain.hid>
	<1273866035.6334.435.camel@domain.hid>
	<4BEDC668.40708@domain.hid>
Date: Fri, 14 May 2010 17:17:06 -0500
Message-Id: <1273875426.6334.461.camel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_mutex created prior to main causes board
	to	freeze?
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
Cc: xenomai@xenomai.org

 
> > Using strace I was able to determine that the first statements in main()
> > were not even reached. The strace output would generally stop on access
> > to /dev/rtheap or rt_sigaction(SIGXCPU...). My suspicion was the global
> > object instantiation calling rt_mutex_create().
> 
> I would suspect an issue with the fast mutexes, since they require a
> shared heap to have been mapped prior to the mutex creation. But if you
> say you saw the same issue on 2.4.8, it must be something completely
> different. I will try and reproduce the issue ASAP.
> 

Thanks! Come to think of it I don't recall ever seeing access to rtheap
on the 2.4.8 traces, just the rt_sigaction. BTW the code is being
cross-compiled using gcc-4.2.4 arm-linux-gnueabi-g++ with -march=armv5te
-mtune=arm926ej-s flags. Let me know what else I can provide that will
be helpful.

-Travis


