Message-ID: <5179D2A5.7050906@xenomai.org>
Date: Fri, 26 Apr 2013 03:04:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFByoKzbx1pMd7dauwoOyKODBOP4q_b=4qtC4H8uNWRwmhgtuA@mail.gmail.com>	<51778026.6080803@xenomai.org>	<5177865E.4060206@xenomai.org>
	<CAFByoKxqCXxzB37+S7cqvEf_+=taatJ2CDDVwatTKYn-OKtHsA@mail.gmail.com>
In-Reply-To: <CAFByoKxqCXxzB37+S7cqvEf_+=taatJ2CDDVwatTKYn-OKtHsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] problem about task scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kidd <gong.kidd@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 04/26/2013 02:59 AM, kidd wrote:

> Hi Gilles
>     You are right about the reason to generate the problem above. When
> "main" function of latency started "latency_task", the "latency" funciton
> would call "rt_task_set_periodic" function, and then
> "xntimer_start_aperiodic" finally. The "xntimer_start_aperiodic" funciton
> returns -ETIMEDOUT, Error.
>     I found that the reason to this error is the data returned from
> "__ipipe_tsc_get".("__ipipe_tsc_get" is defined in
> "arch/arm/kernel/armv-entry.S" under Linux source code directory, and the
> function returns 0 directly, I think the reason of problem is the function
> returns 0 directly)


If you enable IPIPE_ARM_KUSER_TSC, you need to register a tsc with
__ipipe_tsc_register, as described here:
http://xenomai.org/index.php/I-pipe-core:ArmPorting#High_resolution_counter

Otherwise, you need to implement the function __ipipe_mach_get_tsc() as
described here:
http://xenomai.org/index.php/I-pipe:ArmPorting#Implementing_a_high-resolution_counter.

For the third time, please take the time to read the I-pipe porting
guide(s), in order to understand what you are doing.

The next private mail you send me will remain unanswered.

-- 
                                                                Gilles.

