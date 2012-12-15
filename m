Message-ID: <50CC634B.3020307@xenomai.org>
Date: Sat, 15 Dec 2012 12:47:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50CB2610.6010905@gmail.com> <50CBA44C.5090402@xenomai.org>
In-Reply-To: <50CBA44C.5090402@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How does the adeos and xenomai project stay
 synchronized with the linux kernel project?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: hauptmech <hauptmech@gmail.com>, xenomai@xenomai.org

On 12/14/2012 11:12 PM, Philippe Gerum wrote:

> On 12/14/2012 02:13 PM, hauptmech wrote:
>>
>> I've used and followed Xenomai off and on since it forked from RTAI.
> 
> It did not. A fork happens when you diverge from a common code base, 
> which does not apply to Xenomai wrt RTAI. Both used to be independent 
> projects before they joined forces, then split as we failed to actually 
> merge both real-time cores. Portions of Adeos might still be shared by 
> both projects, but incidentally, it is a Xenomai-originated 
> contribution. Please check 
> https://www.xenomai.org/index.php/Xenomai:History for facts.
> 
>   I'm
>> building a new xenomai x86 system after a few years of doing other
>> things. I'm noticing that the adeos patches are few and relatively old
>> compared to the kernel for the x86 architecture.
> 
> We published 990 official Adeos patches since 2001, with more than half 
> of them targeting the x86_32 and _64 architectures. I would not call 
> these a few. Please check download.gna.org/adeos/patches for more 
> information.
> 
>   Kernel version 3.2 has
>> moved from .21 to .35 for instance.
>>
> 
> We never updated the Adeos patches for minor linux releases routinely, 
> this has never been our policy, and will likely never be the case. This 
> would just involve way too much work for our bandwidth. We are focusing 
> on major releases. So you seem to be expecting something we never 
> delivered in the past anyway.
> 
> However, the pace of our Adeos updates for major kernel releases has 
> slowed down over the past three years, definitely. This said, we have 
> support for kernel 3.4 and in some cases 3.5, for the main architecture 
> ports we maintain, it's not lagging that far behind.
> 
>> So my question is (with the deepest respect for the effort it must take)
>> why?
>>
> 
> Because we all have to deal with priorities and available resources, 
> this is no different for the Xenomai maintainers.


Speaking for myself here, porting the I-pipe patch (for the ARM
architecture in my case) to new versions of Linux is the most boring
part of the job, and since I do it on my free time, I tend to
procrastinate. Which is why for instance the I-pipe patch for 3.5 has
been available since august, and I did the port to the ARM architecture
only last week-end (shame on me...).

Anyway, I think the real problem for an end user is the frequency of
Xenomai releases, not of the I-pipe patches, because we probably should
have made a release of Xenomai as soon as the patch for 3.4 has been
available on all architectures. But on the other hand, if you look at
the core-3.4 branch in the git repository, you will see that staying
some time on that patch allowed us to fix many issues.

As for the typos which prevent compilation in some cases, the problem
has been the same for years: the maintainers use kernel configurations
optimized for their use case (fast compilation time, good latencies for
one platform) and the users use opposite configuration options (kernels
as generic as possible). As I said several time, I would like, with the
next release of Xenomai, to release a kernel as a Debian package, so, we
would also test a "Debian-like" configuration. Another situation unique
to the I-pipe patch for Linux 3.2 is that it is based on a new architecture.

-- 
                                                                Gilles.

