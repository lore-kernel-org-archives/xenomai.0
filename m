Message-ID: <54C283D9.8020403@xenomai.org>
Date: Fri, 23 Jan 2015 18:24:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <129277905.Ag2XebZWbK@soho> <54C27115.7030901@xenomai.org>
 <1498823.b61P0cr1E8@indiana>
In-Reply-To: <1498823.b61P0cr1E8@indiana>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On 01/23/2015 06:02 PM, Leopold Palomo-Avellaneda wrote:
> El Divendres, 23 de gener de 2015, a les 17:04:37, Philippe Gerum va escriure:
>> On 01/23/2015 01:09 PM, Leopold Palomo-Avellaneda wrote:
>>> Hi,
>>>
>>> now that I have some kernel to boot, I would like to ask some aspects of
>>> Xenomai-3 in order to package it.
>>>
>>> Reading the documentation, now the new libxenomai could use two kind of
>>> kernels: the patched one (Cobalt) or the preempt_rt (Mercury).
>>
>> Mercury does not require preempt-rt. In some cases, one may want the API
>> emulation capabilities without actually having real-time requirements.
> 
> Ops, Philippe  the documentation [1] says that Mercury:
> 
>> Your kernel should at least provide high resolution timer support 
> (CONFIG_HIGH_RES_TIMERS), and likely complete preemption (PREEMPT_RT) if your 
> application requires short and bounded latencies.
> 
> if your application .. it's not mandatory, right?. So, you can use it in any 
> kernel that at least has CONFIG_HIGH_RES_TIMERS

Yes. Complete preemption is only required to meet real-time requirements.

> 
>>> 1) Is it possible to have _only_ one library (binary) that uses one or
>>> another kernel in function which is running?
>>
>> No. Definitely not.
> 
> Ok, it's too difficult to have it? Same lib that in runtime select the interface 
> to use? So, then someone could provide a binary, that depends on the kernel 
> will work with cobalt or mercury. The packagers would have the life better.
> 

Sure, but the maintainers would go nuts, which would not help the
packagers in the end. Not to speak of the crappy performances on low-end
hardware, due to the extra levels of encapsulation/indirection required.
I don't see any reasonable way to implement this sanely and efficiently.
We are chasing micro-second level optimization in some cases in the
code, for running on CPUs with not-that-fast caches. In this user vs
packager/maintainer trade-off, user must prevail.

>>
>>> 2) If not, as we must recompile the library, all the programs linked
>>> against must be recompiled or if it's binary compatible?
>>
>> Can't have the same ABI. Two separate builds are required. 
> 
> :-( it makes sense if they have different names? -c vc -m or whatever?

The same way we don't have /lib/libc64.so but /lib64/libc.so, I would
rather suggest to use a different install root.

>>
>>> 3) Comparing the files generated (xenomai-2.x vs xenomai-3.x, if you bump
>>> the sonames of libanalogy, libpsos and libvxworks you could have (I
>>> guess) both binary versions installed in the same box.
>>
>> This would make sense, but only for libs. 
> 
> of course.
> 
>> Scripts, includes would conflict.
> 
> another package shared is possible? (xenomai-tools, xenomai-scripts, ....)
> 
> If you have different library names, pkg-config could solve that.
> 
> 
>>> 4) Why the libvxworks has lower soname version in 2.6.4 than in 3.0.0?
>>
>> Because it has been entirely rewritten over the copperplate interface
>> and extended in terms of emulated services.
> 
> Ok, so please use another name so that will no confusion.
> 

Why that? It is still the one and only VxWorks emulator shipped with
Xenomai.

-- 
Philippe.

