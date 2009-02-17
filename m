Message-ID: <499A9DCE.3040000@domain.hid>
Date: Tue, 17 Feb 2009 12:21:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <9c789a000902160455k7dcae1d2tc151b12df6140ec0@domain.hid>
	<200902170940.54910.peter.soetens@domain.hid>
	<499A8636.5020100@domain.hid>
	<200902171208.07297.peter.soetens@domain.hid>
In-Reply-To: <200902171208.07297.peter.soetens@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Comedi drivers in Xenomai porting/integration
	status ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Peter Soetens <peter.soetens@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Peter Soetens wrote:
> On Tuesday 17 February 2009 10:41:10 Jan Kiszka wrote:
>> Peter Soetens wrote:
>>> These are the facts we observed:
>>>
>>> * The Xenomai/Comedi port breaks the complete Comedi API, user space
>>> *and* kernel space. (We thought/assumed that only the user space
>>> interface would go over RTDM and that once that was done, the kernel
>>> modules could be almost copy/pasted into the new framework.)
>> Maybe you have a list of the major differences. Then please share it so
>> that the motivation can be discussed here and maybe clarified (it's a
>> blurred topic for me as well).
> 
> Damn. I should have posted back then :-) Our main lead was the Doxygen pages, 
> from which we went on to see how things were done in code. Unfortunately (?), 
> I'm not a Comedi developer, I twiddled only with one Comedi driver. Once. I 
> can't really compare to the bone. But what was clear immediately was that both 
> user API and kernel API were different. 
> 
> User ('Library') API was cleaned up and streamlined, we could live with that 
> for new applications. I'm sure there are still issues, but they'll only come 
> up once people start using this branch. I like the separation between a low 
> level 'instruction' api and a high level 'function' api. Something upstream 
> comedi mixes to much.
> 
> For kernel ('Driver') API, a new data transfer mechanism is in place, which 
> requires the 'porting' of all drivers. I genuinely can't estimate how 
> drastically this changes existing drivers, but the API is quite huge and works 
> with the 'inversion of control' paradigm: Each driver must implement a series 
> of hooks, and the Comedi/RTDM framework will call these when necessary.
> 
> Another fact I shouldn't have omitted:
> 
> * The Xenomai/Comedi layer is very well documented and allows anyone to learn 
> from it, even the upstream maintainers.
> * Seen from my little device driver knowledge, the technical implementation 
> looks ok for synchronous/asynchronous reading and writing. Memory mapped IO is 
> not available, it seems, and the classical comedi_config, inp,outp,... family 
> isn't complete yet either.

The latter point surprises me given that Alexis worked a lot with/on the
related RTDM services for memory mapping.

> 
>>> * The Xenomai/Comedi port is not supported by 'upstream' (what you call
>>> 'legacy'). It's not discussed on their ML, they don't send in patches or
>>> feedback.
>>> * There aren't any (?) device drivers ported to the Xenomai/Comedi
>>> project (public trunk)
>>>
>>> This is what we concluded:
>>>
>>> * Xenomai/Comedi has no future as long as it ignores (or is ignored by)
>>> upstream. Even after a port of a device driver, pulling fixes from
>>> upstream will be hard due to the changed kernel API.
>> IMHO, that heavily depends on the use cases both projects are able to
>> cover. If there are major RT design issues upstream that this variant
>> solves, then people may be willing to live with the differences
>> (including a smaller driver set downstream). It wouldn't be the first time.
> 
> I see the short term profits as well. I'm fearing a maintenance nightmare in 
> the long term.

No question, that remains an important aspect!

> 
>>> * As GKH puts it: all device drivers belong in the Linux kernel. Upstream
>>> is doing this right now, which makes acceptance of Xenomai/Comedi
>>> unlikely, which makes its life expectations uncertain.
>> I don't think anyone expect to see the RT drivers here and around in
>> mainline Linux in the foreseeable future. That's not the primary goal.
>> At the same time, it's still unclear how serious mainline is about RT
>> redesigns of existing drivers or frameworks. And I recall from earlier
>> threads on the comedi list that at least the current comedi maintainers
>> consider RT use at best as a niche and not an important scenario.
> 
> That's what I recall as well. But I was wondering how the RT issue was 
> overtaken by reality: running plain comedi in a preemptible kernel.

As we know (or learned painfully): Just switching the kernel doesn't
always make its users RT-safe. :)

> 
>>> * We're now actually considering Preempt/RT as the kernel to use in
>>> combination with the original Comedi. We might be stupid, but then again,
>>> it might just work.
>>> * We believe the name Xenomai/Comedi is strongly misleading.  It suggests
>>> a painless transition path, but it's a completely different software
>>> project, different interfaces, different maintainer(s ?).
>> I agree. If reasons for significant differences in the user API remain,
>> then a different name would be appropriate, too. Looks like this is not
>> Socket-CAN vs. RT-Socket-CAN here?
> 
> Most functions and structs have been renamed and have modified arguments, 
> although there could be a 1:1 mapping (1 old function -> 1 new function).
> 
> I believe Alexis can defend his design better than anyone else, and it's not 
> the design I wanted to tackle. It's how he plans to maintain it.
> 
> Peter
> 

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

