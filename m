Message-ID: <50CBA44C.5090402@xenomai.org>
Date: Fri, 14 Dec 2012 23:12:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50CB2610.6010905@gmail.com>
In-Reply-To: <50CB2610.6010905@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: hauptmech <hauptmech@gmail.com>
Cc: xenomai@xenomai.org

On 12/14/2012 02:13 PM, hauptmech wrote:
>
> I've used and followed Xenomai off and on since it forked from RTAI.

It did not. A fork happens when you diverge from a common code base, 
which does not apply to Xenomai wrt RTAI. Both used to be independent 
projects before they joined forces, then split as we failed to actually 
merge both real-time cores. Portions of Adeos might still be shared by 
both projects, but incidentally, it is a Xenomai-originated 
contribution. Please check 
https://www.xenomai.org/index.php/Xenomai:History for facts.

  I'm
> building a new xenomai x86 system after a few years of doing other
> things. I'm noticing that the adeos patches are few and relatively old
> compared to the kernel for the x86 architecture.

We published 990 official Adeos patches since 2001, with more than half 
of them targeting the x86_32 and _64 architectures. I would not call 
these a few. Please check download.gna.org/adeos/patches for more 
information.

  Kernel version 3.2 has
> moved from .21 to .35 for instance.
>

We never updated the Adeos patches for minor linux releases routinely, 
this has never been our policy, and will likely never be the case. This 
would just involve way too much work for our bandwidth. We are focusing 
on major releases. So you seem to be expecting something we never 
delivered in the past anyway.

However, the pace of our Adeos updates for major kernel releases has 
slowed down over the past three years, definitely. This said, we have 
support for kernel 3.4 and in some cases 3.5, for the main architecture 
ports we maintain, it's not lagging that far behind.

> So my question is (with the deepest respect for the effort it must take)
> why?
>

Because we all have to deal with priorities and available resources, 
this is no different for the Xenomai maintainers.

> Is
>
>
>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

