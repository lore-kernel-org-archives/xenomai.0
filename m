Message-ID: <5046F9BD.70907@xenomai.org>
Date: Wed, 05 Sep 2012 09:05:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50405C4F.5030301@ebus.com> <50406A3D.4080801@xenomai.org>
	<5043F063.2020302@ebus.com> <50444008.4000109@xenomai.org>
	<5045AD78.3090904@ebus.com> <5045B732.8040104@xenomai.org>
	<5046C2DA.7080200@ebus.com>
In-Reply-To: <5046C2DA.7080200@ebus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Upgrading to Xenomai 2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Doug Brunner <dbrunner@ebus.com>
Cc: xenomai@xenomai.org

On 09/05/2012 05:11 AM, Doug Brunner wrote:

> On 09/04/2012 01:09 AM, Gilles Chanteperdrix wrote:
>> On 09/04/2012 09:27 AM, Doug Brunner wrote:
>>> On 09/02/2012 10:28 PM, Gilles Chanteperdrix wrote:
>>>> On 09/03/2012 01:48 AM, Doug Brunner wrote:
>>>>
>>>>> On 08/31/2012 12:39 AM, Gilles Chanteperdrix wrote:
>>>>>> On 08/31/2012 08:40 AM, Doug Brunner wrote:
>>>>>>
>>>>>>> I've been having a very hard time with the upgrade from Xenomai 2.6.0 to
>>>>>>> 2.6.1--hoping someone might have a suggestion for me. My thinking was
>>>>>>> that, to get the most possible bug fixes, I should also upgrade to the
>>>>>>> latest kernel for which there is a stable I-pipe patch, which appears to
>>>>>>> be 3.2.21 from examining the list of available patches distributed with
>>>>>>> Xenomai.
>>>>>>>
>>>>>>> Unfortunately, 3.2.21 (even unmodified, using a vanilla Debian kernel
>>>>>>> config, set for 586 cpu type) will not boot on my target platform
>>>>>>> (Winsystems PPM-LX800-G, which has a Geode LX800 CPU). It immediately
>>>>>>> resets after "Loading initial ramdisk", without even any early printk
>>>>>>> output. I have no idea what could be causing that :(
>>>>>> Ok. I have just booted my geode with 3.4, both with 586 cpu type without
>>>>>> tsc and with geode cpu type with tsc. The kernel boots and the latency
>>>>>> test starts. So, I guess you selected a kernel configuration option we
>>>>>> do not support (such as CONFIG_KGDB).
>>>>>>
>>>>>> You can download the configuration which works for me here:
>>>>>> http://xenomai.org/~gch/config-geode
>>>>>>
>>>>> Argh...the problem was apparently that I'd left SMP support selected.
>>>>> Thanks for your config! It's a nice bare-bones kernel and boots my Geode
>>>>> as well so I'm using it as a new starting point.
>>>>> I saw an email from you on 8/3 referring to a regression connected to
>>>>> irq_hold that was fixed in your git. Should I get an I-pipe patch from
>>>>> there, or from git.denx.de/ipipe.git instead of using the one
>>>>> distributed with 2.6.1?
>>>> Probably not, that is a fix for IO-APIC interrupt controller, the geode
>>>> does not have an IO-APIC. Making a few tests with geode without tsc I
>>>> found out something obvious: "statistics collection" should be disabled
>>>> as it causes the tsc read function to be called often, and each read of
>>>> the emulated tsc costs 4us.
>>> If I understand you correctly you are recommending I use 3.2.21 with the
>>> ipipe patch supplied with Xeno 2.6.1 (changing ipipe_root_domain_p to
>>> ipipe_root_p in arch/x86/lib/mmx_32.c).
>>>
>>> Unfortunately it seems neither that 3.2.21 nor the already ipipe-enabled
>>> 3.4.6 from git.denx.de/ipipe.git
>>> (29e656a9501663366287a893d5f6d62bff9f40f6) works with my target
>>> Winsystems PPM-LX800-G. Whether I use the config you posted at
>>> http://xenomai.org/~gch/config-geode or mine (derived from yours, just
>>> drops some ethernet devices I don't use and adds the Geode framebuffer
>>> and IPv6), the system experiences ATA faults such as the following
>>> immediately upon trying to boot:
>>>
>>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>>> ata1.00: failed command: READ DMA
>>> ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
>>>            res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>>> ata1.00: status: { DRDY }
>>>
>>> Finally, after several of these with long delays in between, it panics
>>> because it can't find the root filesystem on the ATA device it's trying
>>> to access (CF card via the CS5536 controller).
>>>
>>> The same config minus the ipipe stuff, fed to an unpatched kernel tree,
>>> produces a binary that will boot the system with no error messages; this
>>> is true for both 3.2.21 and 3.4.6. Any idea what could be doing this, or
>>> what else I can do to debug? I've attached my configs for reference,
>>> except the 3.4.6 ipipe which I forgot to save.
>> The cs5536 SATA driver does not work for me either, even without I-pipe,
>> whereas the legacy IDE driver (option CONFIG_BLK_DEV_CS5536) works,
>> could you test whether it works for you?
>>
> For me the CS5536 PATA driver (not SATA as you have) works fine without 


Sorry, I meant libata driver, instead of SATA.

> I-pipe, but with I-pipe I get the fault described above. The legacy IDE 
> driver does work with I-pipe, at least on 3.2.21.


I tried both 3.2 and 3.4, and could not get the libata driver working,
even without CONFIG_IPIPE, I will try again.


-- 
                                                                Gilles.

