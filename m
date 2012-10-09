Message-ID: <50749349.5070900@xenomai.org>
Date: Tue, 09 Oct 2012 23:12:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>	
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>	
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>	
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>	
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>	
	<506F402A.9030102@xenomai.org>	
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>	
	<506F6283.2040901@xenomai.org>	
	<5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>	
	<506FFDDC.60104@xenomai.org>
	<1349816136.25350.426.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1349816136.25350.426.camel@ENG-09-LX.emacinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Warren <wwarren@emacinc.com>
Cc: xenomai@xenomai.org

On 10/09/2012 10:55 PM, Wayne Warren wrote:

> 
> 
> On Sat, 2012-10-06 at 11:46 +0200, Gilles Chanteperdrix wrote:
>> On 10/06/2012 06:29 AM, Wayne Warren wrote:
>>
>>> Gilles,
>>>
>>> I should have mentioned this earlier... I did as you mentioned in one of
>>> your previous e-mails and added DEBUG_LL_OMAP3(3, am3517evm) after finding
>>> that this string corresponds to the processor id passed to the linux
>>> kernel from u-boot (unless I am misunderstanding how that works). This
>>> applies to all the kernels I built and tested as described in my previous
>>> two e-mails.
>>>
>>> Thanks for your patience, and sorry for the confusion!
>>
>>
>> Ok, but for some reason, that is probably what is not working. Are you
>> sure that:
>> - the am3517 uart has the same address and registers as an omap3 uart?
> 
> I verified this using the AM3517 (which apparently used to be called the
> OMAP3517...I think) Technical Reference Manual.  
> 
>> - that the serial console is on UART3 ?
> 
> Yes, I just re-verified this looking at the product schematic.


There may be a trap in arch/arm/plat-omap/include/mach/serial.h: the
constants OMAP3_UARTx_BASE are numbered starting from 1. So, if the
hardware UART are numbered from 0, you should pass 4 instead of 3 to the
DEBUG_LL_OMAP3 macro.

> 
>> - the uart registers range is mapped where the code in debug-macro.S
>> expects it?
> 
> Not sure how to check this, will probably have to read the tech ref
> manual more in-depth. 


No, you will have to check the code and find the place where the I/O
mapping is done.


> 
>>
>> I never had to debug this, but if I had to, I would try to find what are
>> the values used by the decompressor for the uart physical and virutal
>> addresses and check whether the virtual adress is really mapped.
> 
> One thing I spent some time on Friday night was trying to figure out
> what exactly was happening in the assembly code (which I have little
> familiarity with, but am learning more as I go) to translate physical to
> virtual and back again.


The idea is that printascii should work whether the MMU is enabled or
not. If the MMU is not enabled the physical address is used directly,
if the MMU is enabled, the virtual address is used. However, for this to
work, a mapping, presumably static, should have been defined for the
UART registers, still presumably somewhere in the .map_io callback for
your board. I have to admit that I could not find where this happens for
the omap3 based board I use, where printascii works.

-- 
                                                                Gilles.

