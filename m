MIME-Version: 1.0
In-Reply-To: <CAH8NBSfmRw8mGdH4Fo10bxCHP4YTpCcNkXDg_AFxxArQ7we6wA@mail.gmail.com>
References: <CAH8NBSf+nbREqxMkYt_398z81f-TNRNMbUvm1OSQuk6AagngaQ@mail.gmail.com>
	<51778082.4060504@xenomai.org>
	<CAH8NBSfP3ToQtYMFZymuPwB_E96q=7wBWsL_Ag2r2c=dSwa6yA@mail.gmail.com>
	<51779EF1.6010801@xenomai.org>
	<CAH8NBSfmRw8mGdH4Fo10bxCHP4YTpCcNkXDg_AFxxArQ7we6wA@mail.gmail.com>
Date: Thu, 25 Apr 2013 13:27:02 +0530
Message-ID: <CAH8NBSeCvBMAzGK8ewUvDW2TY4GYDzZSW8EF20+WyKFoMB2V0Q@mail.gmail.com>
From: Srikanth C <srikanthc9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Spurious interrupt are raised with 2.6.1 xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai@xenomai.org

Test Results with adeos-ipipe patch:

H/W Setup is same, S/W Changed to adeos-ipipe with 3.0.8 kernel.

adeos-ipipe-3.0.8-powerpc-2.13-04.patch applied to 3.0.8 kernel, spurious
interrupt is not raised with this patch.

All ipipe series patches raising spurious interrupt in powerpc.



On Wed, Apr 24, 2013 at 3:03 PM, Srikanth C <srikanthc9@gmail.com> wrote:

> Sorry there is typo mistake in kernel version 3.2.24 instead of 3.2.34
>
> Please find the attached boot log and interrupts(/proc/interuupts) log
>
> Added a debug message in _ipipe_grab_irq function to verify the spurious
> interrupt occurrence after IACK read
> test code pasted below :
> count variable is global variable and initialised to zero
> *****************************************************************
> count++;
> irq = ppc_md.get_irq();
>         if (unlikely(irq == NO_IRQ)) {
>                 __get_cpu_var(irq_stat).spurious_irqs++;
>                 printk("S. %d",count);
>                 return __ipipe_exit_irq(regs);
>         }
> ******************************************************************
> Continuous odd numbers is printed for spurious interrupt
> S. 1
> S. 3
> S. 5
>
>
>
> On Wed, Apr 24, 2013 at 2:29 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> On 04/24/2013 08:57 AM, Srikanth C wrote:
>>
>>> Arch is PPC and interrupt is PCI, level sensitive interrupt.
>>>
>>> ipipe 3.2.21 patch is applied to kernel 3.2.24 and even I tried with
>>> ipipe-core-3.5.7-powerpc-3.**patch with 3.5.7 kernel
>>> same result is observed.
>>>
>>
>> Which powerpc platform? What is the test case? How do you notice the
>> spurious interrupt? Is there any kernel log info you may share that reports
>> it?
>>
>> Please, help us to help you.
>>
>>
>>>
>>>
>>> On Wed, Apr 24, 2013 at 12:19 PM, Gilles Chanteperdrix <
>>> gilles.chanteperdrix@xenomai.**org <gilles.chanteperdrix@xenomai.org>>
>>> wrote:
>>>
>>>  On 04/24/2013 08:29 AM, Srikanth C wrote:
>>>>
>>>>  Hi,
>>>>>
>>>>> Spurious interrupts are raised on 2.6.1 Xenomai patch
>>>>> with Linux Kernel version 3.2.34
>>>>>
>>>>> for every pci interrupt raise  there is one spurious interrupt also
>>>>>
>>>> getting
>>>>
>>>>> raised.
>>>>>
>>>>> Without Xenomai patch pci interrupts are working fine (Spurious
>>>>>
>>>> interrupts
>>>>
>>>>> are not raised).
>>>>>
>>>>
>>>>
>>>> What architecture? What kind of interrupt? Do you know the latest
>>>> version of Xenomai is 2.6.2.1, not 2.6.1? Where did you get an I-pipe
>>>> patch for 3.2.34 as the one we provide is for 3.2.21?
>>>>
>>>> --
>>>>                                                                  Gilles.
>>>>
>>>>  ______________________________**_________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> http://www.xenomai.org/**mailman/listinfo/xenomai<http://www.xenomai.org/mailman/listinfo/xenomai>
>>>
>>>
>>
>> --
>> Philippe.
>>
>
>
