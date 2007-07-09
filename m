Message-ID: <46925507.6090608@domain.hid>
Date: Mon, 09 Jul 2007 17:32:23 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46924A1A.4010909@domain.hid>	
	<1183992374.6014.84.camel@domain.hid> <46924B1B.1010308@domain.hid>	
	<1183993194.6014.87.camel@domain.hid> <46924E04.7080803@domain.hid>
	<1183993764.6014.89.camel@domain.hid>
In-Reply-To: <1183993764.6014.89.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] __deprecated not defined for Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Mon, 2007-07-09 at 17:02 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2007-07-09 at 16:50 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Mon, 2007-07-09 at 16:45 +0200, Wolfgang Grandegger wrote:
>>>>>> Hello,
>>>>>>
>>>>>> the attached patch changes:
>>>>>>
>>>>>>    2007-07-09  Wolfgang Grandegger  <wg@domain.hid>
>>>>>>
>>>>>>   * include/asm-generic/wrappers.h: add  __deprecated for Linux 2.4.
>>>>>>
>>>>> Merged, thanks.
>>>> You are too fast for me - I was still test-building my approach!
>>>>
>>>> Looks rather like I picked the wrong expression for marking
>>>> rtdm_task_sleep_until deprecated. I would prefer to go for this variant
>>>> and back Wolfgang's patch out again:
>>> __deprecated is going to be useful in backporting 2.6 stuff to 2.4. This
>>> is not only a RTDM issue.
>> No problem, as you like it.
> 
> Actually, I don't like wrappers that much, but, well...

I just realized, that __deprecated_call__ is _not_ defined in 2.4 but 
already in include/nucleus/compiler.h!

Wolfgang.



