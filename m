Message-ID: <499A8636.5020100@domain.hid>
Date: Tue, 17 Feb 2009 10:41:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <9c789a000902160455k7dcae1d2tc151b12df6140ec0@domain.hid>	<200902170000.00900.berlemont.hauw@domain.hid>
	<200902170940.54910.peter.soetens@domain.hid>
In-Reply-To: <200902170940.54910.peter.soetens@domain.hid>
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
Cc: xenomai@xenomai.org

Peter Soetens wrote:
> On Tuesday 17 February 2009 00:00:00 Alexis Berlemont wrote:
>> Hi,
>>
>>> Hello all! I would like to know what is the current status of the Comedi
>>> port to Xenomai.
>>>
>>> Should all the specific Comedi drivers (ni_pcimio, ni_mite) be available
>>> for testing (by me or someone with a supported DAQ card) and (if ok) for
>>> futher integration ?
>> I am still working on that port. It is a long work and I am wondering at
>> each line whether I should rewrite any part of code which does not comply
>> with common coding constraints. Unfortunately, I currently do not have a
>> lot of spare time. Anyway, most of the ni subdevices drivers have been
>> ported (mite, tio, mio, 8255). I am trying to finalize the global driver
>> port.
>>
>> By the way, in the middle of january, I noticed that the legacy Comedi
>> branch found its way into the mainline (through the staging tree). I do not
>> know what will be the future of such a package in mainstream. I assume the
>> main goal is the definition of a global framework for acquisition boards
>> like V4L2 is for video cards.
> 
> I'm not sure I understand where this is going. We did a review of the 
> Xenomai/Comedi code integration a few weeks ago. 
> 
> These are the facts we observed:
> 
> * The Xenomai/Comedi port breaks the complete Comedi API, user space *and* 
> kernel space. (We thought/assumed that only the user space interface would go 
> over RTDM and that once that was done, the kernel modules could be almost 
> copy/pasted into the new framework.)

Maybe you have a list of the major differences. Then please share it so
that the motivation can be discussed here and maybe clarified (it's a
blurred topic for me as well).

> * The Xenomai/Comedi port is not supported by 'upstream' (what you call 
> 'legacy'). It's not discussed on their ML, they don't send in patches or 
> feedback. 
> * There aren't any (?) device drivers ported to the Xenomai/Comedi project 
> (public trunk)
> 
> This is what we concluded:
> 
> * Xenomai/Comedi has no future as long as it ignores (or is ignored by) 
> upstream. Even after a port of a device driver, pulling fixes from upstream 
> will be hard due to the changed kernel API.

IMHO, that heavily depends on the use cases both projects are able to
cover. If there are major RT design issues upstream that this variant
solves, then people may be willing to live with the differences
(including a smaller driver set downstream). It wouldn't be the first time.

> * As GKH puts it: all device drivers belong in the Linux kernel. Upstream is 
> doing this right now, which makes acceptance of Xenomai/Comedi unlikely, which 
> makes its life expectations uncertain.

I don't think anyone expect to see the RT drivers here and around in
mainline Linux in the foreseeable future. That's not the primary goal.
At the same time, it's still unclear how serious mainline is about RT
redesigns of existing drivers or frameworks. And I recall from earlier
threads on the comedi list that at least the current comedi maintainers
consider RT use at best as a niche and not an important scenario.

> * We're now actually considering Preempt/RT as the kernel to use in 
> combination with the original Comedi. We might be stupid, but then again, it 
> might just work.
> * We believe the name Xenomai/Comedi is strongly misleading.  It suggests a 
> painless transition path, but it's a completely different software project, 
> different interfaces, different maintainer(s ?).

I agree. If reasons for significant differences in the user API remain,
then a different name would be appropriate, too. Looks like this is not
Socket-CAN vs. RT-Socket-CAN here?

> 
> Sorry for flaming, and please correct me where I'm wrong.

Sometime "flaming" can even be helpful... :)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

