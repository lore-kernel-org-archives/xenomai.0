Message-ID: <499D6FC7.6010204@domain.hid>
Date: Thu, 19 Feb 2009 15:42:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <499D359C.3060805@domain.hid>
	<499D3801.5040303@domain.hid>	<499D3FE6.4030208@domain.hid>
	<499D5B0A.7020608@domain.hid> <499D5FC4.4030303@domain.hid>
	<499D67A6.7000301@domain.hid> <499D68A5.8020002@domain.hid>
In-Reply-To: <499D68A5.8020002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] XENO_OPT_SYS_STACKPOOLSZ vs. switchtest
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
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Hi Gilles,
>>>>>>>
>>>>>>> how much XENO_OPT_SYS_STACKPOOLSZ do I need to run switchtest for
>>>>>>> default settings? At least on x86-64, the default 32K is not enough.
>>>>>>> Unless we talk about GB ;), maybe it makes sense to adjust the default
>>>>>>> size accordingly.
>>>>>> It depends on the arguments you pass to switchtest.
>>>>> None, ie. the default settings.
>>>> Then 6 kernel-space tasks are created. Since switchtest is not the
>>> 6*4 is 20k... Ah, the well-known allocator overhead, I guess. Will try
>>> with >= 40k.
>>>
>> Actually, it is not really an overhead, but rather the fact that it wants at
>> least two initially free pages per heap.
> 
> That would make 22K. The problem is that the management overhead is
> rounded up to another full page, requiring a 8K allocation per 4K
> request. Reminds me of TLSF - if I only had the time... :)

When allocating 4K, only 4K are allocated.

I think the problem could rather be that you are running switchtest on a
multi-cpu system, in which same the number of cpu tasks created is 6 by cpu.

-- 
                                                 Gilles.

