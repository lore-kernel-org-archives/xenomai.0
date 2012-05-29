Message-ID: <4FC52AF0.6040006@piments.com>
Date: Tue, 29 May 2012 22:00:48 +0200
From: xenophile <xenophile@piments.com>
MIME-Version: 1.0
References: <mailman.0.1338320469.1537.xenomai@xenomai.org>
	<4FC52889.8050002@piments.com> <4FC528F0.2070307@xenomai.org>
In-Reply-To: <4FC528F0.2070307@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] What is the Xenomai time limit?
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

On 05/29/12 21:52, Gilles Chanteperdrix wrote:
> On 05/29/2012 09:50 PM, xenophile wrote:
>> On 05/29/12 21:41, xenomai-owner@xenomai.org wrote:
>>>
>>> On 05/29/12 16:43, Philippe Gerum wrote:
>>>>
>>>> x86-wise, there is some more issues to keep an eye on:
>>>>
>>>> - Hyperthreading (not nice to -rt requirements)
>>>> - SMI sources (causing IRQ-disabling BIOS code to be invoked directly by
>>>> special interrupts not going through the programmable interrupt
>>>> controller, so we can't block them, and don't know when they happen).
>>>> - Some graphic card adapters (causing hw stalls to favor their own
>>>> throughput)
>>>> - Some graphic card drivers, most often proprietary, disabling
>>>> interrupts for too long.
>>>> - Some cycle-hungry x86 cache invalidation instructions (wbinv).
>>>> - The legacy x86 PIT (i8254) when used, which goes through a legacy ISA
>>>> bus, as expensive as ~1.5-2.5 us for each I/O access (you need at least
>>>> two of them to program the next clock tick). Fortunately, you won't need
>>>> it on a modern x86 platform, unless really unlucky.
>>>>
>>>> Oh well, other that that, x86 is almost fine for -rt stuff.
>>>>
>>>
>>
>> So what would be the best kind of x86 hardware to use for RT?
>>
>>    Hyperthreading comes with multicore processors I think.
>>
>>    What systems least SMI code ?
>>
>>    My guess is that fast 32 bit x86 hardware like top of range AMD Athlon
>>    processors would be good (better than multicore 64 bit ) but I'm only
>>    guessing.
>>
>>    Are fast graphics cards better, so long as they can be run without
>>    proprietary drivers ?
>>
>>    I'm sure there's no hard and fast answer but can you offer any guide
>> lines?
>>
>>    Thx.
>
> The address of the mailing list is xenomai@xenomai.org, not
> xenomai-owner@xenomai.org
>

Sorry,  I got a bounce because I originally sent the msg from the wrong 
email account my end  (that bounce came from "owner").

I replied to the bounce with the correct sender,  thinking it would go 
to the list , I did not notice that it was from xenomai-owner.

So hopefully both sender and recipient are now correct and this will 
appear on the list.

Phew.






