Message-ID: <551679A2.20508@xenomai.org>
Date: Sat, 28 Mar 2015 10:51:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CACreCVLijm5Wup7aTrRTq=SHBmEUQY5D2pYpXThWXSrGqpcuqw@mail.gmail.com>
 <20150318142119.GF24525@hermes.click-hack.org>
 <CACreCV+WajHg9wKp3HpxZ4uVdva5ADAWtOH6DDjPfWzcyNk2YQ@mail.gmail.com>
 <20150318145611.GG24525@hermes.click-hack.org>
 <CACreCV+VoYvYQbejhJ2RzU9ZJDUBExwZyRv-DFs3TzWtQvzZkg@mail.gmail.com>
 <20150325145730.GJ15125@hermes.click-hack.org>
 <CACreCVLQk_4i7OdMdOFBG6cLKxh3-qJLZGMoz9i_q4XoZPbdoA@mail.gmail.com>
 <20150325160852.GK15125@hermes.click-hack.org>
 <CACreCV+tYp1QConFh2uKWjnqVOQ4uA=xLmbyay_XT9mui0txfw@mail.gmail.com>
 <CACreCVLG=dtjriCzUUqYtOK1Pz+NqYoPFNLJZ4KrM-AccBoHPA@mail.gmail.com>
 <CACreCVKO35Xt9qgerZnw9V3GTRwnGPn_URkL+1C4ymeHUGfK5A@mail.gmail.com>
 <CACreCVLg5ufmVAK_+6P1KpYaQ0ShkkPw9m=5+A+Ao=xtA9tEDQ@mail.gmail.com>
In-Reply-To: <CACreCVLg5ufmVAK_+6P1KpYaQ0ShkkPw9m=5+A+Ao=xtA9tEDQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/28/2015 10:05 AM, GP Orcullo wrote:
> On Fri, Mar 27, 2015 at 8:12 PM, GP Orcullo <kinsamanka@gmail.com> wrote:
>> On Fri, Mar 27, 2015 at 6:19 PM, GP Orcullo <kinsamanka@gmail.com> wrote:
>>> What happens in between the clocksource switch and head domain registration?
>>>
>>> [    0.090129] DMA: preallocated 4096 KiB pool for atomic coherent
>>> allocations
>>> [    0.095333] Switching to clocksource ipipe_tsc
>>> [    0.122397] I-pipe: head domain Xenomai registered.
>>> [    0.124618] Xenomai: hal/arm started.
>>>
>>> I'm trying to trace the code to find out where it stops. I tried
>>> adding printk to to the set and request functions and the code never
>>> runs when CONFIG_SMP is enabled.
>>>
>>> Thanks,
>>>
>>> GP Orcullo
>>
>> It gets stuck on the call to ipipe_critical_enter:
>> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/timer.c?id=ipipe-core-3.10.32-arm-7#n279
>>
>> Which then gets stuck on ipipe_send_ipi:
>> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/core.c?id=ipipe-core-3.10.32-arm-7#n1533
>>
> 
> I've traced the issue to the ipipe_processor_id() function. It returns
> the value 512 for processor 0. This value comes from cpu node property
> of the DT file.
> 
> Changing ipipe_processor_id() to return 0 instead of 512 allows the
> kernel to boot but it fails the switchtest regression test.
> 
> Changing the cpu0 reg value on the DT file allows the kernel to boot
> and pass all the xenomai regression tests but it generates the
> following warning at boot:

No, this property for armv7 must match MPIDR[23:0], i.e. the physical id
of the core.

> What's the proper way of fixing this?
> 

By fixing ipipe_processor_id() in the CONFIG_LEGACY case, it's broken.
It assumes __cpu_logical_map[] is a hw->logical map, but it is actually
the opposite.

We may have been lucky until now because the physical mapping seems to
have always matched the logical order on the SMP SoCs people used with
Xenomai so far, it looks like your A5 core does not follow this order.

-- 
Philippe.

