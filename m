Message-ID: <506DCF21.2000606@xenomai.org>
Date: Thu, 04 Oct 2012 20:02:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>		<506B5D6B.80005@xenomai.org>
	<506B5E0E.5050900@xenomai.org>	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
	<506DC2DA.5000105@xenomai.org>
In-Reply-To: <506DC2DA.5000105@xenomai.org>
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

On 10/04/2012 07:09 PM, Gilles Chanteperdrix wrote:

> On 10/04/2012 06:57 PM, Wayne Warren wrote:
>> Gilles,
>>
>> Thanks for your help!
>>
>> The ArmPorting guide is helpful, but unfortunately the first tip and
>> trick did not reveal any boot messages. I had to add a function
>> declaration for "printascii" to get the code to compile. I have
>> CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_LL, and CONFIG_EARLY_PRINTK enabled
>> and have passed the boot parameter "earlyprintk" when attempting to
>> boot. 
> 
> Either you enable CONFIG_EARLY_PRINTK and pass earlyprintk on the
> command line, that is the "new" way.
> 
> Or, you do the printascii in printk trick, that is the "old" way.
> 
> If you do both, you should see everything printed twice.
> If you do not see anything, it probably means that printascii does not
> work for your platform. To get it working, you have to look at
> arch/arm/your-machine/include/mach/debug-macro.S
> And of course, your kernel has to be compiled for only one board, if the
> UART used by these macros depends on the board.


Ah, if it is an OMAP based processor, you need to add a call to
_DEBUG_LL_ENTRY for your processor in
arch/arm/plat-omap/include/plat/uncompress.h, it may be what is missing.


-- 
                                                                Gilles.

