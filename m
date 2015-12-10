Date: Thu, 10 Dec 2015 16:01:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151210150110.GA20328@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70DB46@mb2010-1.intra.tut.fi>
 <20151208201331.GA3667@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A70DC03@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A70DC03@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Loose determinism when reading pcap and sending as
 raw ethernet packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Dec 10, 2015 at 01:20:47PM +0000, Umair Ali wrote:
> Hi Gilles,

Hi,

> 
> Thanks for understanding my problem.
> 
> >- for a program to run in primary mode only, pthread_setschedparam
> should be called with a priority higher than 1 for the SCHED_FIFO
> (or SCHED_RR) policy;
> 
> I have been doing the same already but i did not copy that part of code in the email.
> 
> >- when you call a function which returns a value, like send or
> nanosleep, you should always check the return value for errors;
> - if you want to send a message on average every 5us then
> nanosleep(5us) is not what you should be using, you should be using
> clock_nanosleep with an absolute date, or the easier but less
> portable timerfd;
> 
> I have used the clock_nanosleep with absolute time, but i could
> not find the absolute date. With clock_nanosleep i have found the
> same problem as described in the last email.

You compute the next absolute date. But the point is to add 5us to
the absolute date, instead of using now + 5us, so that the packets
are really sent every 5us on average. This should not solve the
problem you have, only ensure that the messages are sent every 5us
on average.

> I have looked the
> file timerfd.h. What i have understand is that by using timerfd i
> will create the dedicated timer with unique ID and then use the ID
> to get the time by using timerfd_gettime(). The time is added with
> amount of delay and passed to clock_nanosleep() function to
> achieve the required sleep time period. Am i doing it right with
> timerfd?

With timerfd, you would set up the timer with timerfd_settime() to
tick every 5us, then the read() system call to wait for the timer
next expiration.

> 
> >  what you observe is the jitter, you can measure the timer
> interrupt jitter with the "latency" test, but I bet that maybe the
> latency may be higher than 5us;
> - if you really really need to reduce the jitter, then using kernel
> timers instead of sleeping in a user-space thread is recommended,
> 
> Yes, you are right that what i have observed is the jitter. I have
> gone through the links which you have provided me in the last
> email. I am building my application using POSIX skin. In the
> links, they have used the rtdm_timer_start(). Now my question is
> that can i use the rtdm functions in the application compiling
> with posix skin, if yes then how. Do i have to change the skin for
> comilation in order to use the rtdm functions. Please refer me
> some guide for using the Xenomai Kernel timers with posix skin in
> order to avoid the jitter. Last thing do i need to made a kernel
> module in order to use the kernel timers. I am confused. Please
> guide me.

If you want to use kernel-space, you need to write a driver, running
in kernel spaces, and drivers use the RTDM API. The POSIX API is for
the application.

-- 
					    Gilles.
https://click-hack.org

