Message-ID: <4B20D066.5070904@domain.hid>
Date: Thu, 10 Dec 2009 11:41:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EA8B423DB69FD24FA233008019A052AE016689FC@zue-s-15.zue.zwick.de>
In-Reply-To: <EA8B423DB69FD24FA233008019A052AE016689FC@zue-s-15.zue.zwick.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with gettimeofday
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Soboljew, Patrick" <Patrick.Soboljew@domain.hid>
Cc: xenomai@xenomai.org

Soboljew, Patrick wrote:
> Hello all,
> 
> I have a problem concering the system time in xenomai 2.4.9.1 kernel
> 2.6.30. The framework I use calls gettimeofday() to get the absolute
> system time which is then passed to pthread_cond_timedwait. The problem
> is that when I add for example 1ms wait time the pthread_cond_timedwait
> waits much longer. I've checked /proc/xenomai/sched and I can see that
> the timeout is far too large. So I wrote a small test program to isolate
> the problem. I compared the results (only the seconds which is enough to
> show the problem) and there is a huge difference.
> 
> On my system (Intel Core2, 1,6 GHz) the output of the test program shows
> the following output:
> Time1: 1260437136
> Time2: 1145908535
> 
> The curious thing is: I have a vmware image with a xenomai kernel (same
> version). The problem cannot be reproduced here. 
> 
> Anybody an idea?

You should be using clock_gettime(CLOCK_REALTIME). In case you insist on
using gettimeofday, see:

http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Timing_services.

-- 
                                          Gilles


