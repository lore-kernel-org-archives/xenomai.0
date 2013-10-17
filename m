Message-ID: <525FADFA.2020009@xenomai.org>
Date: Thu, 17 Oct 2013 11:29:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>	<525E7D85.9020307@xenomai.org>	<525E81CD.6000603@steinkuehler.net>	<525E8665.8000705@steinkuehler.net>	<525E8A43.5090601@xenomai.org>	<525E8BFF.1060201@steinkuehler.net>	<525EAFFD.3010207@steinkuehler.net>	<525EB7A2.1050601@xenomai.org>
	<525EBAD4.3080100@steinkuehler.net>
	<525EEBE2.8080708@steinkuehler.net>
	<525F362F.6080109@steinkuehler.net>
In-Reply-To: <525F362F.6080109@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/17/2013 02:58 AM, Charles Steinkuehler wrote:
> On 10/16/2013 2:41 PM, Charles Steinkuehler wrote:
>> On 10/16/2013 11:12 AM, Charles Steinkuehler wrote:
>>> I'll test with ipipe disabled, go through the Arm Porting guide, and see
>>> where that gets me...
>>
>> After building a patched kernel without ipipe or xenomai enabled:
>>
>> $ egrep '(IPIPE|XENO)' KERNEL/.config
>> # CONFIG_XENOMAI is not set
>> CONFIG_XENO_GENERIC_STACKPOOL=y
>> CONFIG_XENO_FASTSYNCH_DEP=y
>> CONFIG_XENO_FASTSYNCH=y
>> # CONFIG_IPIPE is not set
>>
>> ...the mmc issue seems fixed.  So according to the porting guide, this
>> indicates a likely problem with interrupts or the interrupt controller
>> (as Gilles indicated).
>
> Based on the ARM porting guide, the first thing I did was to disable IRQ
> muting by simply commenting out the two calls to:
>
>    ipipe_pic_muter_register
>
> ...in <linux>/drivers/gpio/gpio-omap.c
>
> This results in a kernel that DOES NOT HANG with ipipe enabled!

It does not really make sense: when I-pipe is enabled but Xenomai 
disabled, the PIC muting is only used to tweak the interrupt controller 
priority. Since there are only secondary mode irqs, they all should use 
the same priority.

Is arch/arm/mach-omap2/irq.c modified by the BeagleBone patches, if yes, 
could you put the modified version somewhere I could have a look at it?

Regards.

-- 
					    Gilles.

