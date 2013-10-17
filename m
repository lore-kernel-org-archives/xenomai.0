Message-ID: <52602FE5.4050809@xenomai.org>
Date: Thu, 17 Oct 2013 20:43:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>	<525E7D85.9020307@xenomai.org>	<525E81CD.6000603@steinkuehler.net>	<525E8665.8000705@steinkuehler.net>	<525E8A43.5090601@xenomai.org>	<525E8BFF.1060201@steinkuehler.net>	<525EAFFD.3010207@steinkuehler.net>	<525EB7A2.1050601@xenomai.org>
	<525EBAD4.3080100@steinkuehler.net>
	<525EEBE2.8080708@steinkuehler.net>
	<525F362F.6080109@steinkuehler.net> <525FADFA.2020009@xenomai.org>
	<525FDA89.60104@steinkuehler.net>
In-Reply-To: <525FDA89.60104@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/17/2013 02:39 PM, Charles Steinkuehler wrote:
> On 10/17/2013 4:29 AM, Gilles Chanteperdrix wrote:
>> On 10/17/2013 02:58 AM, Charles Steinkuehler wrote:
>>> On 10/16/2013 2:41 PM, Charles Steinkuehler wrote:
>>>> On 10/16/2013 11:12 AM, Charles Steinkuehler wrote:
>>>>> I'll test with ipipe disabled, go through the Arm Porting
>>>>> guide, and see where that gets me...
>>>> 
>>>> After building a patched kernel without ipipe or xenomai
>>>> enabled:
>>>> 
>>>> $ egrep '(IPIPE|XENO)' KERNEL/.config # CONFIG_XENOMAI is not
>>>> set CONFIG_XENO_GENERIC_STACKPOOL=y 
>>>> CONFIG_XENO_FASTSYNCH_DEP=y CONFIG_XENO_FASTSYNCH=y #
>>>> CONFIG_IPIPE is not set
>>>> 
>>>> ...the mmc issue seems fixed.  So according to the porting
>>>> guide, this indicates a likely problem with interrupts or the
>>>> interrupt controller (as Gilles indicated).
>>> 
>>> Based on the ARM porting guide, the first thing I did was to
>>> disable IRQ muting by simply commenting out the two calls to:
>>> 
>>> ipipe_pic_muter_register
>>> 
>>> ...in <linux>/drivers/gpio/gpio-omap.c
>>> 
>>> This results in a kernel that DOES NOT HANG with ipipe
>>> enabled!
>> 
>> It does not really make sense: when I-pipe is enabled but
>> Xenomai disabled, the PIC muting is only used to tweak the
>> interrupt controller priority. Since there are only secondary
>> mode irqs, they all should use the same priority.
> 
> I am confused as well, particularly by the fact that adding back
> the xenomai patches (but leaving the gpio IRQ masking disabled)
> gets me back to the hung mmc task.

No this makes sense: it simply means that the issue has nothing to do
with pic muting. What is surprising is that disabling pic muting
without CONFIG_XENOMAI changes anything: the PIC muting is only used
with CONFIG_XENOMAI except for the setting of the interrupt controller
priority.

> 
>> Is arch/arm/mach-omap2/irq.c modified by the BeagleBone patches,
>> if yes, could you put the modified version somewhere I could have
>> a look at it?
> 
> The minor patch to the irq file doesn't seem likely to cause
> problems, but there is a *LOT* of mmc driver code that is changed
> between mainline and the BeagleBone kernel, much of it related to
> DMA.
> 
> I've put up my full kernel build tree in case you want to look at
> any other files.  The top directory is the scripts and patches used
> to build the kernel.  The actual kernel code already patched with
> the BeagleBone patch set as well as ipipe and xenomai is in the
> KERNEL directory:
> 
> http://morpheus.steinkuehler.net/xenomai
> 
> Are the xenomai patches similar to the preempt-rt patch set in that
> they can expose underlying flaws in driver code that is not SMP
> clean?
> 
> If so, I suspect something with the mmc and dma updates specific to
> the BeagleBone patch set.  Maybe I should be pestering the OMAP
> kernel list?
> 

As I said in my first answer, the thing that could happen could be
that the driver is not prepared for the interrupt controller to
receive another interrupt while the interrupt line is masked after
receiving the first interrupt, this could be considered a driver bug
which is exposed by the fact that interrupts are masked for a longer
time with the I-pipe patch.

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFSYC/lGpcgE6m/fboRAiNTAJ9Lgl+5yvZx3tq+A2sNAuV2O+ELEwCfduKz
76kAr5wrhwpuON1H069pPr0=
=EyFB
-----END PGP SIGNATURE-----

