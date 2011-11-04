Message-ID: <4EB43B3E.806@domain.hid>
Date: Fri, 04 Nov 2011 20:21:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1320433713.81220.YahooMailNeo@domain.hid>
In-Reply-To: <1320433713.81220.YahooMailNeo@domain.hid>
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

On 11/04/2011 08:08 PM, Tom Z wrote:
> Hi All,
> 
> I am trying to measure the CPU time consumed by a function foo(), and
> here is how I do it:
> 
> void foo(){ struct timespec tp1, tp2; 
> clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tp);
> 
> //Computation goes here
> 
> 
> clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tp2); //The CPU time is
> given between the difference between tp2 and tp 1
> 
> }
> 
> 
> The program is running on Ubuntu 10.10, and the kernel is 2.6.37
> patched with Xenomai 2.5.6
> 
> 
> Here is what I observed:
> 
> 1) If foo() is running in the Linux domain (i.e., called by a regular
> Linux process), the CPU time obtained by the above method looks
> normal, and the mean CPU time of 25000 invocations of foo() is 10
> ms.
> 
> 2) If foo() is running in the primary domain (i.e., called by a
> Xenomai task spawned by rt_task_create() and rt_task_start()), then
> *most of the time*, the CPU time also looks as normal as the result
> in 1), and the mean CPU time is also about 10 ms. However, I also
> noticed that sometimes the CPU time obtained by the above method is
> 0. This zero value did not appear often, and out of 25000 invocations
> of foo(), I noticed that there is only 1 invocation of foo() where
> the CPU time is 0. BTW, the Xenomai task's priority is 99.
> 
> What causes this 0 CPU time in the primary domain? Is there something
> wrong with my method to measure the CPU time?

We do not know what skin you use, we will assume that you use Xenomai
posix skin, so, compile with the right flags.

CLOCK_PROCESS_CPUTIME_ID is not implemented for xenomai posix skin, so,
clock_gettime probably returns an error, and the struct timespec is
unchanged.

If somehow the glibc clock_gettime is used, and this call does not cause
a system call, then all bets are off, and even a lockup could happen.

-- 
                                                                Gilles.

