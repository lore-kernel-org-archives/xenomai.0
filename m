Message-ID: <51857D7E.3030009@xenomai.org>
Date: Sat, 04 May 2013 23:28:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8AC37F92-E842-45E8-8583-9C1A7D8C9930@mah.priv.at>
	<5184483E.1050305@xenomai.org>
	<8A7AED52-BB19-44B2-B1FE-B1E7FBE84915@mah.priv.at>
	<51850F84.6090204@xenomai.org>
	<C24A4431-BF7F-46A6-B6B7-D90DFA27444A@mah.priv.at>
	<51854E48.9010609@xenomai.org>
	<D93BA61A-1D5A-42D8-80DC-6B8315E74E43@mah.priv.at>
In-Reply-To: <D93BA61A-1D5A-42D8-80DC-6B8315E74E43@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.8.10 beaglebone failure: any clues I missed?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/04/2013 10:38 PM, Michael Haberler wrote:

> 
> Am 04.05.2013 um 20:07 schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> 
>> On 05/04/2013 04:30 PM, Michael Haberler wrote:
>>
>>>
>>> Am 04.05.2013 um 15:39 schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>>
>>>> On 05/04/2013 08:04 AM, Michael Haberler wrote:
>>>>
>>>>> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
>>>>> (modprobe xeno_native?)
>>>>
>>>>
>>>> See:
>>>> http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_xenomai_native_skin_or_config_xeno_opt_pervasive_disabled
>>>
>>> I went through that before posting,  and found no clue hinting to the above, see below;
>>>
>>> on my first attempt, I managed to start from branch am33x-v3.2 instead from tag 3.8.10-bone15, so failure was obvious but thats fixed
>>>
>>> is there a requirement the patch files need to reside in xenomai-2.6/arch/arm/patches/* before doing scripts/prepare-kernel.sh ?
>>>
>>> still dead sure it's a 'duh' build goof
>>
>>
>> One possible reason would be that something changed in 3.8.10, for
>> instance in the system calls handling. But to know that, you would have
>> to answer the questions I asked you, which you seem not willing to do.
> 
> I'm prepared to confess but the clue is low ;)


The main question was: could you try 3.8.0 without any patches? Since it
seems to have support for the beaglebone processor.

> 
> I build the userspace support natively on the BB; the configure log is http://static.mah.priv.at/public/config.log


> 
> I cross-build only the kernel - following Stephans instructions I concluded it is sufficient to apply those steps, i.e. apply the two patches like so, after the inital kernel build which succeeds:
> 
> ../xenomai-2.6/scripts/prepare-kernel.sh  --linux=KERNEL --arch=arm --ipipe=../ipipe-kernel-3.8.10.patch  # fuzz here


on what files? If there is fuzz on arch/arm/kernel/entry-armv.S for
instance, this may be bad. Where did you get this
ipipe-kernel-3.8.10.patch from? Please try to simply apply the "post"
patch on git://git.xenomai.org/ipipe-gch.git branch for-core-3.8.

> cd KERNEL
> patch -p1 <../../post.patch # no fuzz
> cd ..
> tools/rebuild.sh 
> 
> I'd be unsure what to configure in the xenomai tree here beforehand when cross-building?
> 
> ---
> 
> with CONFIG_IPIPE_DEBUG_CONTEXT and CONFIG_IPIPE_DEBUG_INTERNAL enabled, /proc/interrupts looks so:
> 
> root@arm:/usr/xenomai/bin# cat /proc/interrupts 
>            CPU0       
>  28:       1486      INTC  edma
>  30:          0      INTC  edma_error
>  34:          0      INTC  musb-hdrc.0.auto
>  35:          1      INTC  musb-hdrc.1.auto
>  46:         96      INTC  4819c000.i2c
>  56:          0      INTC  4a100000.ethernet
>  57:        735      INTC  4a100000.ethernet
>  58:        625      INTC  4a100000.ethernet
>  59:          0      INTC  4a100000.ethernet
>  80:       4748      INTC  mmc0
>  83:      18092      INTC  gp_timer
>  86:        162      INTC  44e0b000.i2c
>  88:        363      INTC  OMAP UART0
>  91:          0      INTC  rtc0
>  92:          0      INTC  rtc0
> 125:          0      INTC  53100000.sham


So, you only have one interrupt controller, and it is "INTC", you do not
need to check this one, it is already adapted.

-- 
                                                                Gilles.

