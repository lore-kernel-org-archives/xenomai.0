Message-ID: <53FD899D.4080609@xenomai.org>
Date: Wed, 27 Aug 2014 09:32:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <443DA8ED-FBAA-4DE6-814A-317E04D56407@gatech.edu>
In-Reply-To: <443DA8ED-FBAA-4DE6-814A-317E04D56407@gatech.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Overrun error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>, xenomai@xenomai.org

On 08/27/2014 05:22 AM, Yogi A. Patel wrote:
> Hi -
> 
> I have ubuntu 14.04 running kernel 3.8 patched with xenomai 2.6.3.
> 
> I have the kernel configured with:
> 
> Processor type -> core 2/newer xenon Preemption model -> low-latency
> desktop ACPI -> Processor (disabled)
> 
> When I run the latency test, things are great (for hours at a time).
> Average latencies are 1-1.3us and no overruns.
> 
> These latency results remain even when I run my own real time
> software.
> 
> However, the moment I open Firefox or chrome, I start seeing
> overruns.
> 
> This is confusing - I would think applications like web browsers
> would not have any reason to cause overruns.

What graphic driver do you use? What version of the I-pipe patch? If
Intel, ipipe-core-3.8.13-x86-4.patch contains a fix for latency issues
observed on this hardware.

> 
> It's very likely I don't understand how the overruns occur in such a
> situation and what causes an overrun.
> 
> Has anyone else seen similar issues?

Yes, this happens from time to time, and a "generic" workaround is even
in our troubleshooting guide:
http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#the_latency_test_shows_high_latencies

> 
> Also, when reading the output of the latency test, why do the overrun
> values never go back to zero between printouts of the latency test?

Because the count of overruns is cumulative, as are all the counters 
after the count of overruns (msw, lat best, lat worst). When you have 
observed overruns, you usually want the information to stick, so that 
you see it when you stop the test.

-- 
                                                                Gilles.

