Message-ID: <5056CAB8.3020506@xenomai.org>
Date: Mon, 17 Sep 2012 09:01:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <504EC598.7050005@ebus.com> <504F8F55.9080006@xenomai.org>
	<504FAAE6.5010701@xenomai.org> <505667A8.9040409@ebus.com>
In-Reply-To: <505667A8.9040409@ebus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Interpreting I-pipe trace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Doug Brunner <dbrunner@ebus.com>
Cc: Xenomai <Xenomai@xenomai.org>

On 09/17/2012 01:58 AM, Doug Brunner wrote:

> On 09/11/2012 02:19 PM, Gilles Chanteperdrix wrote:
>> On 09/11/2012 09:21 PM, Gilles Chanteperdrix wrote:
>>
>>> On 09/11/2012 07:01 AM, Doug Brunner wrote:
>>>
>>>> While running my latency testing earlier I saw some rather high
>>>> worst-case latencies (~70us) compared to average case (~14us), so I ran
>>>> again with I-pipe tracing enabled. However, I'm not sure what to make of
>>>> the results.
>>>>
>>>> My worst case involves an IRQ (common_interrupt appears in the trace
>>>> with user value 0xFFFFFFC4) and the wiki page talks about being able to
>>>> translate the user value 0xFFFFFFF4 into IRQ 11 but doesn't elaborate on
>>>> how this correspondence works. I'm not horribly concerned since it's a
>>>> delay of 53 us on a rather slow processor (Geode LX800) but it would be
>>>> nice to know what interrupt is taking so long.
>>>
>>> You may also want to apply the following patch for SMI on Geode LX, and
>>> enable CONFIG_XENO_HW_SMI_WORKAROUND. You can remove the '#if 0', if you
>>> do not use PCI.
>>
>> You have to pass cs5536.msr=1 to avoid using PCI registers access (which
>> use SMIs) in the IDE driver.
>>
> It doesn't appear like this patch, or using idle=poll, has any effect. I 
> tried making latency histograms with and without and they were almost 
> identical. Interestingly I don't see any output from the printk in the 
> patch, even though I have earlyprintk set up to run over my serial 
> console hookup. This persisted even when I took out the is_geode_lx() 
> check. This suggests to me that rthal_smi_init is not getting called.


Actually, after some more test, the only thing that made the difference
for me was booting with "cs5536.msr=1", as it causes the cs5536 driver
to use msrs instead of pci config register accesses and pci config
register accesses are emulated with SMIs. When doing, that there does
not seem to be any SMI on my geode, so masking the SMIs is in fact useless.

To shut other SMI off, you may try to add:
                wrmsrl(0x51000002, 0);
+               wrmsrl(0x51010002, 0);
+               wrmsrl(0x51200002, 0);
+               wrmsrl(0x51300002, 0);
+               wrmsrl(0x51400002, 0);
+               wrmsrl(0x51500002, 0);
+               wrmsrl(0x51700002, 0);

The tsc in my case is correctly configured, but if it is not correctly
configured by your bios, you can check its registers. This is all
documented in the Geode datasheet. You have to configure it so that it
does not stop when the idle task calls. You should also configure the
geode so that the geode doe not automatically go into a low power mode
when the "hlt" instruction is called (but if you boot with idle=poll,
"hlt" should never be called anyway).

In any case, the trace you posted is way to short, to actually debug a
high latencies, the trace should capture at least the timer
programmation before the tick which triggers the trace, so that you can
see what happened between the time the timer was supposed to tick and
the time when it really ticked. When you have done that, please post the
trace here, and we will try and continue the debugging.

>

> I do have CONFIG_XENO_HW_SMI_ALL set, which now that I think about it 
> seems like it should already give me the benefit of the patch. However I 
> don't see how it would stop rthal_smi_init from getting called.


This suggests a configuration issue, such as
CONFIG_XENO_HW_SMI_WORKAROUND missing. Nothing magical here.
rthal_smi_init IS called during Xenomai startup if
CONFIG_XENO_HW_SMI_WORKAROUND is enabled.

> For the benefit of my curiosity, could you explain how 0xFFFFFFC4 
> translates into a PCI related SMI?


Well, in the trace you posted, I do not see 0xFFFFFFC4, but in that case
0xFFFFFFC4 is ~0x3b, so, it corresponds to vector 3b. Now, what is
vector 3b probably depends on your setup, and probably has nothing to do
with PCI related SMI.

In any case, an SMI does not go through "common_interrupt", and SMI
jumps directly to, and is handled in BIOS code. So, it is invisible in
the I-pipe trace, except for a large hole in the time line.

-- 
                                                                Gilles.

