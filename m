Message-ID: <499D83DD.7010309@domain.hid>
Date: Thu, 19 Feb 2009 17:07:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <499D359C.3060805@domain.hid>	<499D3801.5040303@domain.hid>	<499D3FE6.4030208@domain.hid>	<499D5B0A.7020608@domain.hid>
	<499D5FC4.4030303@domain.hid>	<499D67A6.7000301@domain.hid>
	<499D68A5.8020002@domain.hid> <499D76AE.2090309@domain.hid>
	<499D8065.2020009@domain.hid>
In-Reply-To: <499D8065.2020009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] XENO_OPT_SYS_STACKPOOLSZ vs. switchtest
Reply-To: rpm@xenomai.org
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
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Hi Gilles,
>>>>>>>>>
>>>>>>>>> how much XENO_OPT_SYS_STACKPOOLSZ do I need to run switchtest for
>>>>>>>>> default settings? At least on x86-64, the default 32K is not enough.
>>>>>>>>> Unless we talk about GB ;), maybe it makes sense to adjust the default
>>>>>>>>> size accordingly.
>>>>>>>> It depends on the arguments you pass to switchtest.
>>>>>>> None, ie. the default settings.
>>>>>> Then 6 kernel-space tasks are created. Since switchtest is not the
>>>>> 6*4 is 20k... Ah, the well-known allocator overhead, I guess. Will try
>>>>> with >= 40k.
>>>>>
>>>> Actually, it is not really an overhead, but rather the fact that it wants at
>>>> least two initially free pages per heap.
>>> That would make 22K. The problem is that the management overhead is
>>> rounded up to another full page, requiring a 8K allocation per 4K
>>> request.
>> Nope. An individual 4k request is going to pull 8 x 512 bytes pages from the
>> stack pool, not more.
> 
> Yeah, I see. The only "overhead" here was already paid via the pagemap.
> 
>>  Reminds me of TLSF - if I only had the time... :)
>>
>> It looks like working properly for -solo.
> 
> I think to remember your concerns were more about missing fragmentation,
> size overhead and performance comparisons. A working version for
> standard Xenomai was already available at that time (maybe not for all
> archs, but that is surely quickly fixed).
>

Locking and init fixes went to TLSF 2.4.4 in the recent months, so we would have
needed those anyway. It's quite late to merge TLSF in Xenomai 2.5, but I would
have no objection to make it the base allocator of the 3.x series. We would have
to extend it with:

- support for a few callouts, such as the validity checking function used in
xnhead_test_and_free(),
- shared memory export (this is quite allocator agnostic in fact)
- detailed error codes in xnheap_test_and_free/xnheap_free

> Jan
> 


-- 
Philippe.

