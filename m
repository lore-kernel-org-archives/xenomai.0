Message-ID: <5046294C.7070102@xenomai.org>
Date: Tue, 04 Sep 2012 18:16:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50461A66.6070805@ruggedcom.com> <504621AB.3000402@xenomai.org>
	<20120904155339.GZ1237@csclub.uwaterloo.ca>
	<504627A4.90505@xenomai.org>
In-Reply-To: <504627A4.90505@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Powepc 8360 interrupt timing question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 09/04/2012 06:09 PM, Philippe Gerum wrote:
> On 09/04/2012 05:53 PM, Lennart Sorensen wrote:
>> On Tue, Sep 04, 2012 at 05:43:39PM +0200, Philippe Gerum wrote:
>>> - which I-pipe version exactly? Seven different patches were released
>>> for 3.0.x/powerpc over time.
>>>
>>> - which Xenomai release? 2.6.0, 2.6.1, current HEAD?
>>
>> xenomai 2.6.0, kernel 3.0.22, ipipe 3.0.8-powerpc-2.13-04
>>
>>> You seem to be rehashing an old question. The answer at that time was:
>>>
>>> - there was an issue with processing cascaded interrupts in the former
>>> pipeline architecture. This has been solved in recent patches with the
>>> introduction of the pipeline "core" series (core-3.2 and above, commit
>>> a4b909ccf80c5a).
>>
>> Hmm, I wonder if that would apply reasonably cleanly on top of the
>> 3.0.8 patch.  Might be worth a try.
> 
> I see no showstopper in doing this, many if not most issues will be
> related to name changes. However, the implementation of the low level
> IRQ dispatcher is different between the core series and the former one.
> So there will be some glue logic to provide. Understanding the way
> __ipipe_dispatch_irq works with respect to handling cascaded IRQs should
> provide enough insight to match the related code in
> arch/powerpc/include/asm/qe_ic.h.

You will need these too:
eb3ce2324618
f2ca3c2baf58b

> 
>>
>>> - handling level IRQs in userland is generally a bad idea.
>>
>> Unfortunately edge IRQs don't really share well.
>>
> 
> No, but if the level IRQ is shared between the two domains, the
> situation is even worse with handling the RT one in userland.
> 


-- 
Philippe.

