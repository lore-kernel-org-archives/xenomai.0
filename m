References: <20120901153825.3f232f97@dell> <504210A3.2080402@xenomai.org>
	<20120901155011.70dcc825@dell> <50421382.90608@xenomai.org>
	<0cd389b2-7365-44d9-844a-6e6d97692471@email.android.com>
	<50421C75.7080405@xenomai.org>
	<1eab433e-48cb-4d60-b731-e961ed2abb89@email.android.com>
	<50422697.9020600@xenomai.org>
In-Reply-To: <50422697.9020600@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michael Trimarchi <michael@amarulasolutions.com>
Date: Sat, 01 Sep 2012 18:37:17 +0200
Message-ID: <ea671f6b-1493-44d0-81df-e75a2d2ff956@email.android.com>
Subject: Re: [Xenomai] imx1 and imx27 boot problem with __ipipe_tsc_get()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> ha scritto:

>On 09/01/2012 04:33 PM, Michael Trimarchi wrote:
>
>> Hi
>> 
>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> ha scritto:
>> 
>>> On 09/01/2012 04:29 PM, Michael Trimarchi wrote:
>>>
>>>> Hi
>>>>
>>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> ha scritto:
>>>>
>>>>> On 09/01/2012 03:50 PM, gwenhael.goavec wrote:
>>>>>
>>>>>> On Sat, 01 Sep 2012 15:41:55 +0200
>>>>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>
>>>>>>> On 09/01/2012 03:38 PM, gwenhael.goavec wrote:
>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I have 2 boards, the first is based on imx1 and the second on
>>>>> imx27.
>>>>>>>> With this 2 boards, I'm unable to boot a 2.6.38.8 kernel.
>>>>>>>> For the imx1 with 3.2.21 the result is the same.
>>>>>>>>
>>>>>>>> I have enabled early_printk. On every boards the boot stop with
>a
>>>>> kernel panic.
>>>>>>>> The message start with : "Unable to handle kernel paging
>request
>>> at
>>>>> virtual
>>>>>>>> address 10003010" on imx27.
>>>>>>>>
>>>>>>>> This is due to the call of __ipipe_tsc_get() in
>>>>> __ipipe_tsc_update()
>>>>>>>>
>>>>>>>> To verify my toolchain I have tested 2.6.38.8 with at91
>>>>> successfully.
>>>>>>>>
>>>>>>>> If someone has a idea?
>>>>>>>
>>>>>>>
>>>>>>> Not enough information, to understand what happens we need the
>>>>> kernel
>>>>>>> oops (at least the register values).
>>>>>>>
>>>>>>> -- 
>>>>>>>                                                                
>>>>> Gilles.
>>>>>>
>>>>>> Sorry,
>>>>>>
>>>>>> Unable to handle kernel paging request at virtual address
>10003010
>>>>>> pgd = c0004000
>>>>>> [10003010] *pgd=00000000
>>>>>> Internal error: Oops: 5 [#1] PREEMPT
>>>>>> last sysfs file: 
>>>>>> Modules linked in:
>>>>>> CPU: 0    Not tainted  (2.6.38.8-ipipe #34)
>>>>>> PC is at 0xffff0f48
>>>>>> LR is at __ipipe_tsc_update+0xfc/0x1c0
>>>>>> pc : [<ffff0f48>]    lr : [<c0032cd4>]    psr: 600000d3
>>>>>> sp : c049fe80  ip : c04af0b0  fp : c04af040
>>>>>> r10: c04af0b0  r9 : c04d5300  r8 : c04d5300
>>>>>> r7 : 0000001a  r6 : c04c99f8  r5 : ffff0f40  r4 : ffff0f20
>>>>>> r3 : 00000000  r2 : 00000000  r1 : c04d5300  r0 : 10003010
>>>>>
>>>>>
>>>>> Ok. In the mean time I remembered someone signalled this bug and I
>
>>>>> fixed it in the patch for 3.4. r0 is supposed to be the address of
>>> the 
>>>>> hardware timer, 10003010 is a physical address instead of being a 
>>>>> virtual address. Please try the following patch:
>>>>>
>>>>> diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
>>>>> index 255e759..7a3d6b9 100644
>>>>> --- a/arch/arm/plat-mxc/time.c
>>>>> +++ b/arch/arm/plat-mxc/time.c
>>>>> @@ -352,7 +352,7 @@ mxc_timer_init(struct clk *timer_clk,
>>>>>
>>>>> 	if (timer_is_v1()) {
>>>>> 		tsc_info.u.counter_paddr = phys + MX1_2_TCN;
>>>>> -		tsc_info.counter_vaddr =(unsigned long)(phys + MX1_2_TCN);
>>>>> +		tsc_info.counter_vaddr = (unsigned long)(timer_base +
>MX1_2_TCN);
>>>>> 	} else {
>>>>> 		tsc_info.u.counter_paddr = phys + V2_TCN;
>>>>> 		tsc_info.counter_vaddr = (unsigned long)(timer_base + V2_TCN);
>>>>>
>>>>>
>>>>
>>>> It was my patch
>>>
>>>
>>> No, you promised to send a patch for 3.2 and I never received it, so
>I
>>> fixed it myself.
>>>
>> 
>> Sorry ,  I was thinking that you only need some test on it,
>> 
>> Execuse me for it
>> 
>> Michael
>
>
>The point is: I can not test the patch for imx27 or imx25 because I do
>not have access to such hardware, so I simply compile-test. Could you
>check whether the 3.2 branch still has the issues you fixed, and send
>patches please? I swear they will be merged this time.
>
>Last time your patch had issues, I told you that and we never got
>further.

Ok understand. Let me finish it

Michael

>
>-- 
>                                                                Gilles.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

