Message-ID: <4EB45AF6.60304@domain.hid>
Date: Fri, 04 Nov 2011 22:36:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1320433713.81220.YahooMailNeo@domain.hid>
	<4EB43B3E.806@domain.hid>
	<1320440601.64091.YahooMailNeo@domain.hid>
In-Reply-To: <1320440601.64091.YahooMailNeo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] 0 CPU time problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tom Z <tomz30@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/04/2011 10:03 PM, Tom Z wrote:
> > We do not know what skin you use, we will assume that you use
> > Xenomai posix skin, so, compile with the right flags.
>
> Here is how I
> build my program, say, fooTest: gcc -I/usr/xenomai/include
> -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ -lnative
> -L/usr/xenomai/lib -lxenomai -lpthread -lnative -lrtdk fooTest.c -o
> fooTest

You are using the native skin then.

> > CLOCK_PROCESS_CPUTIME_ID is not implemented for xenomai posix skin,
> > so, clock_gettime probably returns an error, and the struct timespec
> > is unchanged. If somehow the glibc clock_gettime is used, and this
> > call does not cause a system call, then all bets are off, and even a
> > lockup could happen.
>
> Thanks for explaining this. So can I trust the
> CPU time I obtained with my method when the function is running in
> the primary mode? It seems you explanation implies that the results I
> obtained are not reliable, if so, are there other reliable ways to
> obtain the CPU time?

No, CLOCK_PROCESS_CPUTIME is a clock implemented by the Linux kernel,
so, it does not see the time spent in primary mode. If the foo function
does not suspend, you can use rt_timer_tsc(), but the answer is no,
there is currently no way to get the cpu time used when in primary mode.

-- 
                                                                Gilles.

