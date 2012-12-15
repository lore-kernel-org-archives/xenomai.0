Message-ID: <50CC690C.9040806@xenomai.org>
Date: Sat, 15 Dec 2012 13:11:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF8BDEF87A.CA8542D0-ON80257AD2.00581CFA-80257AD2.005A5994@test.alstom.com>
In-Reply-To: <OF8BDEF87A.CA8542D0-ON80257AD2.00581CFA-80257AD2.005A5994@test.alstom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Timer support in user-space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dave.joynson@alstom.com
Cc: xenomai@xenomai.org

On 12/12/2012 05:26 PM, dave.joynson@alstom.com wrote:

> Hi,
> I have recently started to use Xenomai on Raspberry Pi. My experience with 
> Linux Kernel building etc. is zero so I downloaded the pre-built image 
> from powet.eu. I have successfully created a cross compile environment to 
> create user-space applications using the Posix skin. While tracking down 
> some mode changes I came across the limitation of Posix skin Timers in 
> that the timer expiry creates a signal which causes a mode switch.


Yes that is a shame. To finish the posix timers implementation, we need
to implement signals for xenomai tasks. Thanks to the work made on the
watchdog code, we now have everything needed, but implementing signals
is trickier as it seems, in particular because it involves
saving/restoring fpu contexts, and we know by experience that we never
got code touching FPU right the first time.

So, in the mean time, you can use native skin timers.

> I have considered creating an application layer timer module using a pool 
> of threads that use nanosleep and a callback function on expiry. Careful 
> management of these threads using a custom timer API could fulfill my 
> requirements.
> While exploring the documentation for alternatives, I noticed that the 
> RTDM Driver Development API provides access to native timers that would 
> seem to perform the functionality that I need, On trying to use them in a 
> user-space application, however, it seems that they may only be used in 
> kernel-space. This leads me to the following question:
> 
>         Is the documentation incorrect for rtdm_timer_init() when it says 
> it may be used in user-space tasks?


>From what I understand, the only RTDM services available to user-space
tasks are the posix open/close/ead/write/ioctl services. So, everything
else happens in kernel-space, and when I read that an RTDM service is
available to user-space tasks, I understand that it is available on the
context of a user-space task running kernel-space code, such as a driver
callback. But I may be wrong, and it may be actually a cut and paste error.

-- 
                                                                Gilles.

