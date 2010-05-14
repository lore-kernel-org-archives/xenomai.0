Message-ID: <4BECE339.3060902@domain.hid>
Date: Fri, 14 May 2010 07:44:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question about getting system time
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
Cc: xenomai@xenomai.org

Abhijit Majumdar wrote:
> Hi folks
> 
>  
> 
> I am facing a strange problem in getting system time.
> 
>  
> 
> My requirement:
> 
>  
> 
>  In a hard real time task I need to get the current system time and
> store it in a structure. Later at some point of time a java application
> a windows system is supposed to convert it into user-readable date-time
> format. I am using rt_timer_tsc2ns(rt_timer_read()) to get the current
> time. 

You should be using rt_timer_ticks2ns(rt_timer_read()), rt_timer_tsc2ns
should be used with rt_timer_tsc().


> 
>  
> 
> Problem: 
> 
>  
> 
> However the java application prints a date in 1980 (I converted nanosec
> to millisec before using java API). I kind of expected rt_timer_tsc2ns
> to return nanoseconds from 1st Jan 1970 because it is common for
> programming tools and languages, although I must admit that I did not
> see that in the xenomai API documentation.
> 
>  
> 
> Am I doing something wrong? Should I have to compile the kernel with
> some specific parameter?

The problem you may have is that Xenomai clock is synchronized with
Linux clock when Xenomai starts, and it may happen at a time when Linux
clock is not yet set to the current time. If that is the case, you
should set xenomai's time during the boot process after Linux' time has
been set. Currently, the only service to do this is clock_settime,
implemented by the posix skin.

-- 
					    Gilles.

