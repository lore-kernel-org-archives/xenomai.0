Message-ID: <525FFE55.1030200@cantastic.org>
Date: Thu, 17 Oct 2013 17:12:21 +0200
From: Ralf Roesch <xenomai@cantastic.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>	<525E7D85.9020307@xenomai.org>	<525E81CD.6000603@steinkuehler.net>	<525E8665.8000705@steinkuehler.net>	<525E8A43.5090601@xenomai.org>	<525E8BFF.1060201@steinkuehler.net>	<525EAFFD.3010207@steinkuehler.net>	<525EB7A2.1050601@xenomai.org>
	<525EBAD4.3080100@steinkuehler.net>
	<525EEBE2.8080708@steinkuehler.net>
	<525F362F.6080109@steinkuehler.net> <525FADFA.2020009@xenomai.org>
	<525FDA89.60104@steinkuehler.net>
In-Reply-To: <525FDA89.60104@steinkuehler.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On Thu Oct 17 2013 14:39:37 GMT+0200, Charles Steinkuehler 
<charles@steinkuehler.net>  wrote:
> On 10/17/2013 4:29 AM, Gilles Chanteperdrix wrote:
>> On 10/17/2013 02:58 AM, Charles Steinkuehler wrote:
>>> On 10/16/2013 2:41 PM, Charles Steinkuehler wrote:
>>>> On 10/16/2013 11:12 AM, Charles Steinkuehler wrote:
>>>>> I'll test with ipipe disabled, go through the Arm Porting guide, and
>>>>> see
>>>>> where that gets me...
>>>> After building a patched kernel without ipipe or xenomai enabled:
>>>>
>>>> $ egrep '(IPIPE|XENO)' KERNEL/.config
>>>> # CONFIG_XENOMAI is not set
>>>> CONFIG_XENO_GENERIC_STACKPOOL=y
>>>> CONFIG_XENO_FASTSYNCH_DEP=y
>>>> CONFIG_XENO_FASTSYNCH=y
>>>> # CONFIG_IPIPE is not set
>>>>
>>>> ...the mmc issue seems fixed.  So according to the porting guide, this
>>>> indicates a likely problem with interrupts or the interrupt controller
>>>> (as Gilles indicated).
>>> Based on the ARM porting guide, the first thing I did was to disable IRQ
>>> muting by simply commenting out the two calls to:
>>>
>>>     ipipe_pic_muter_register
>>>
>>> ...in<linux>/drivers/gpio/gpio-omap.c
>>>
>>> This results in a kernel that DOES NOT HANG with ipipe enabled!
>> It does not really make sense: when I-pipe is enabled but Xenomai
>> disabled, the PIC muting is only used to tweak the interrupt controller
>> priority. Since there are only secondary mode irqs, they all should use
>> the same priority.
> I am confused as well, particularly by the fact that adding back the
> xenomai patches (but leaving the gpio IRQ masking disabled) gets me back
> to the hung mmc task.
>
>> Is arch/arm/mach-omap2/irq.c modified by the BeagleBone patches, if yes,
>> could you put the modified version somewhere I could have a look at it?
> The minor patch to the irq file doesn't seem likely to cause problems,
> but there is a *LOT* of mmc driver code that is changed between mainline
> and the BeagleBone kernel, much of it related to DMA.
If I got it it right the device tree handling is also complete new ( 
arch / arm / boot / dts /)  compared to mainline?
If so, the enhanced DMA (edma) should also be taken into account ?
--
Ralf
> I've put up my full kernel build tree in case you want to look at any
> other files.  The top directory is the scripts and patches used to build
> the kernel.  The actual kernel code already patched with the BeagleBone
> patch set as well as ipipe and xenomai is in the KERNEL directory:
>
> http://morpheus.steinkuehler.net/xenomai
>
> Are the xenomai patches similar to the preempt-rt patch set in that they
> can expose underlying flaws in driver code that is not SMP clean?
>
> If so, I suspect something with the mmc and dma updates specific to the
> BeagleBone patch set.  Maybe I should be pestering the OMAP kernel list?
>


