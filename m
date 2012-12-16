Message-ID: <50CDCF87.2010207@gmail.com>
Date: Sun, 16 Dec 2012 14:41:27 +0100
From: hauptmech <hauptmech@gmail.com>
MIME-Version: 1.0
References: <50CB2610.6010905@gmail.com> <50CBA44C.5090402@xenomai.org>
	<50CC634B.3020307@xenomai.org>
In-Reply-To: <50CC634B.3020307@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


I'm coming to the documentation with relatively fresh eyes. If you give 
me a user on the wiki I'm happy to do a little gardening. Things like 
the [getting started] page which is useful but not linked to anymore. 
Perhaps a buffer page between the wiki and the git page with a little 
description of the repos and how they fit into the development workflow 
(where a link to denx could go).

I have made xenomai source packages for pacman (Archlinux + a few 
others) for arm last year and just now x86. However since archlinux 
tends to use a minimally patched vanilla kernel it's not as exciting as 
debian.

More embedded below...

On 12/15/2012 12:47 PM, Gilles Chanteperdrix wrote:
> On 12/14/2012 11:12 PM, Philippe Gerum wrote:
>
>> We never updated the Adeos patches for minor linux releases routinely,
>> this has never been our policy, and will likely never be the case. This
>> would just involve way too much work for our bandwidth. We are focusing
>> on major releases. So you seem to be expecting something we never
>> delivered in the past anyway.
Ok, I wasn't expecting anything. I just didn't understand.

>>
>> However, the pace of our Adeos updates for major kernel releases has
>> slowed down over the past three years, definitely. This said, we have
>> support for kernel 3.4 and in some cases 3.5, for the main architecture
>> ports we maintain, it's not lagging that far behind.
The availability of ipipe for 3.4/3.5 (x86) is not apparent from the 
website nor the patches in the xenomai source.
>>
>>> So my question is (with the deepest respect for the effort it must take)
>>> why?
>>>
>> Because we all have to deal with priorities and available resources,
>> this is no different for the Xenomai maintainers.
>
> Speaking for myself here, porting the I-pipe patch (for the ARM
> architecture in my case) to new versions of Linux is the most boring
> part of the job, and since I do it on my free time, I tend to
> procrastinate. Which is why for instance the I-pipe patch for 3.5 has
> been available since august, and I did the port to the ARM architecture
> only last week-end (shame on me...).
Does all the work involve expertise with the kernel? I realize that 
having a inexpert 'helper' for a lot of tasks just creates extra work 
but if that's not the case here, perhaps a help-wanted post on the wiki 
and some documentation on the process would attract someone wanting to 
learn or help.
>
> Anyway, I think the real problem for an end user is the frequency of
> Xenomai releases, not of the I-pipe patches, because we probably should
> have made a release of Xenomai as soon as the patch for 3.4 has been
> available on all architectures. But on the other hand, if you look at
> the core-3.4 branch in the git repository, you will see that staying
> some time on that patch allowed us to fix many issues.
I look forward to the release when it does happen.

-hauptmech






