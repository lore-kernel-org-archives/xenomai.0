Message-ID: <4DFB3A47.4040702@domain.hid>
Date: Fri, 17 Jun 2011 13:28:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DFB1DC3.80203@domain.hid> <4DFB32B2.1010904@domain.hid>
	<4DFB3466.10908@domain.hid> <4DFB3521.2010109@domain.hid>
	<4DFB38E3.10204@domain.hid> <4DFB39F3.5080507@domain.hid>
In-Reply-To: <4DFB39F3.5080507@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] nucleus: Fix interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-06-17 13:26, Gilles Chanteperdrix wrote:
> On 06/17/2011 01:22 PM, Jan Kiszka wrote:
>> On 2011-06-17 13:06, Gilles Chanteperdrix wrote:
>>> On 06/17/2011 01:03 PM, Jan Kiszka wrote:
>>>> On 2011-06-17 12:55, Gilles Chanteperdrix wrote:
>>>>> On 06/17/2011 11:26 AM, Jan Kiszka wrote:
>>>>>> Our current interrupt handlers assume that they leave over the same task
>>>>>> and CPU they entered. But CONFIG_XENO_HW_UNLOCKED_SWITCH and commit
>>>>>> f6af9b831c broke this assumption: xnpod_schedule invoked from the
>>>>>> handler tail can now actually trigger a domain migration
>>>>>
>>>>> What unlocked context swith introduce from my point of view is simply
>>>>> sections where interrupt happen which do not reschedule.
>>>>>
>>>>> f6af9b831c introduce a rescheduling point, but does not change what
>>>>> happens during the interrupt handler either.
>>>>>
>>>>> So, I do not really understand this commit message. Either we can assume
>>>>> that interrupt handlers migrate tasks or not, but this does not seem to
>>>>> have anything to do with unlocked context switches or commit f6af9b831c.
>>>>
>>>> It has: Task is about to relax, re-enables interrupts in
>>>> xnpod_resume_thread, IRQ hits, handler is entered over the relaxing RT
>>>> task, xnpod_schedule in its tail performs the switch to root, which then
>>>> continues to relaxed task, IRQ tail resumes over a different task, on
>>>> SMP potentially also on a different CPU. I can send you a the trace if
>>>> you want to have a closer look.
>>>
>>> Ok. Got it. But what has this to do with unlocked context switches ?
>>
>> Also before commit f6af9b831c, there was a window with enabled IRQs in
>> the relaxation path. So the above scenario should have been possible
>> even earlier.
> 
> Unlocked context swith enables irqs, but sets the XNSWLOCK bit, so, no
> other rescheduling can take place.

Ah, OK. Will remove that from the commit log.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

