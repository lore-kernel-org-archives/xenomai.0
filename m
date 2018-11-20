Subject: Re: spinlock_irq...() supported in Xenomai 2.6.5 ?
References: <CA+K1mPFcJwvsSJQP_qAs0F01zPqzPtHD7fA6AqFXX71vrSyD0w@mail.gmail.com>
 <b3921461-be89-e33c-8904-4709847903ea@siemens.com>
 <CA+K1mPEH+RkvcOX4QXGRzdu1FwA2+u6mmb_7uyP0cDvGPBtKVw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9007f701-3172-df9a-8864-b7fa5a04a751@siemens.com>
Date: Tue, 20 Nov 2018 10:03:40 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPEH+RkvcOX4QXGRzdu1FwA2+u6mmb_7uyP0cDvGPBtKVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: xenomai@xenomai.org

On 19.11.18 19:10, C Smith via Xenomai wrote:
> On Sun, Nov 18, 2018 at 11:39 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> On 19.11.18 07:38, C Smith via Xenomai wrote:
>>> I am porting an old Linux kernelspace driver to Xenomai 2.6.5 using RTDM
>>> API.
>>> I see calls to spinlock_irq_save() and spin_unlock_irqrestore() in the
>> old
>>> kernel driver code, right in the middle of an interrupt handler.
>>>
>>> Are those spinlock calls 'wrapped' by Xenomai 2.6.5 such that they work,
>>> and execute in Primary mode? Is calling these a bad thing to do in the
>>> middle of an RTDM interrupt, will it try to switch to Secondary mode ?
>>>
>>
>> Neither the obsolete 2.6 (don't use it anymore!) nor current Xenomai 3 can
>> perform any magic here. If your driver's IRQ routine shall run in primary
>> mode,
>> you need to migrate it explicitly to the RTDM API.
>>
>> OK, that's what I suspected. Yes my interrupts must be Primary mode (hard
> RT), so should I use rtdm_lock_irqsave () and  rtdm_lock_irqrestore () as a
> substitute?
> 

Right.

> Also, the old kernel driver used writel(), is that magically wrapped so it
> would just become a Xenomai Primary mode call ?

Nothing is magically wrapped. You need to check if a standard Linux function you 
call is potentially blocking (takes a sleeping or spinning lock) under Linux. If 
that is not the case, and the MMIO accessors fall into that category, you are fine.

Check other drivers in Xenomai for patterns.

> 
> We will port to Xenomai 3 in the coming year. In the meantime there are
> tens of thousands of lines of code to so I must maintain our 2.6.5 code for
> now. Please don't abandon discussions of 2.6, it's the stable and debugged
> pinnacle of your excellent work, after all.

Understood, you have an existing code base. Your message just sounded like you 
are porting newly to Xenomai 2.6, and that is what should definitely be prevented.

Xenomai 2.6 in its core is fairly stable, but it's also unmaintained. So you are 
on your own when in comes to getting a recent, maintained kernel running against 
it, just to name one example. That's also the reason why we migrated our users 
at Siemens to Xenomai 3, even though they were happy with 2.6.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

