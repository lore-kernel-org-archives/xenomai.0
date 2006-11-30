Message-ID: <456EF1DA.1050102@domain.hid>
Date: Thu, 30 Nov 2006 15:59:38 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<4566C5AF.7030107@domain.hid>	<20061124113009.08c0a490.benjamin.zores@domain.hid>	<4569E699.6050003@domain.hid>	<20061127092143.e633cd91.benjamin.zores@domain.hid>	<456ACA35.8030206@domain.hid>	<20061127125419.3852edd9.benjamin.zores@domain.hid>	<456AD5EB.5040901@domain.hid>	<20061130133745.272ab4b1.benjamin.zores@domain.hid>
	<456EDA4B.3060809@domain.hid>
In-Reply-To: <456EDA4B.3060809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Benjamin Zores wrote:
>> On Mon, 27 Nov 2006 13:11:23 +0100
>> Wolfgang Grandegger <wg@domain.hid> wrote:
>>
>>> Benjamin Zores wrote:
>>>> On Mon, 27 Nov 2006 12:21:25 +0100
>>>> Wolfgang Grandegger <wg@domain.hid> wrote:
>>>>
>>>>>> Well, I hack a bit my patch to make it compile and the kernel already booted.
>>>>>> Though it hangs when loading the SATA driver.
>>>>>> I have no idea why atm.
>>>>> Problems with IRQs?
>>>> Probably, as when unplugging the SATA drive, the boot goes further
>>>> but then hang at USB detection (both are handlign IRQs a lot i guess).
>>>> Would be interesting if someone could test on other board than just mine.
>>> As I pointed out in my previous mail, the IRQ handling is not yet 
>>> correct for powerpc. Try to correct his first.
>> The 2.6.19 having been released out, and working much better on my card
>> than the vanilla 2.6.18 used to be, I'm now more kind to adapt my patch to
>> this latest kernel.
>>
>> However the IRQ handling API seem to have changed a lot
>> and i was wondering if some work on porting Adeos
>> (x86/ppc, not yet powerpc of course) patches already have been started
>> by someone here ?
> 
> I don't see that PPC is converted to genirq, that new API. And I'm not
> sure (while not being a PPC expert) if it ever will be, specifically as
> PowerPC is already on genirq and should obsolete PPC one day, right?

No, or at least partially wrong. I have to check what the new, fully 
implemented genirq does. But I realized, that the common IRQ structure 
is used now (resulting in some name changes, w.g. ->handler ->chip). 
Likely, PPC and PowerPC already use the new genirq.

> Anyway, there is an unreleased work-in-progress patch for x86 over -rc6
> by Philippe. I recently had the chance to test it and hack a bit on the
> SMP IO-APIC part. It seems to work fine under UP, but SMP had some
> issues that are identified, but still need to be addressed - thanks to
> genirq, now in a widely arch-independent way.
> 
> Philippe, I know you are very busy, but shouldn't we make a pre-release
> available already, also to discuss further how to deal best with genirq
> on other platforms beyond x86?
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


