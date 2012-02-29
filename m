Message-ID: <4F4E87C2.3070106@domain.hid>
Date: Wed, 29 Feb 2012 21:17:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEc6OSwfGvfwXM3vqtAXd7o_XeMhSmuvj8mkd8ziLXQSMyK0aA@mail.gmail.com>	<4F4E630C.8020301@domain.hid>	<CAEc6OSypUWu3PmMy0HKzTipyrQsU-PDoQYAdH7BeMo+5gCh0uA@mail.gmail.com>	<4F4E680C.1000602@domain.hid>	<CAEc6OSwe8WO=FRh9e7TSfSjVw5kbGphUYCQA4hjkzXbn8kCgRg@domain.hid>	<4F4E712F.7050104@domain.hid>	<CAEc6OSwv_h6Rmv8FhLPhbgCQs-hmzCX+9COXj_T8nYLH0yhbaw@domain.hid>	<4F4E8112.6060909@domain.hid>
	<CAEc6OSyVayLDKw=rfQu7PbQhothpa3-pGvnRtq=7C-BxhOeYdw@domain.hid>
In-Reply-To: <CAEc6OSyVayLDKw=rfQu7PbQhothpa3-pGvnRtq=7C-BxhOeYdw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Execution time profiling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Charles Lesire-Cabaniols <charles.lesire@domain.hid>
Cc: xenomai@xenomai.org

On 02/29/2012 08:59 PM, Charles Lesire-Cabaniols wrote:
> 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> On 02/29/2012 08:44 PM, Charles Lesire-Cabaniols wrote:
>>> 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>
>>>> On 02/29/2012 07:03 PM, Charles Lesire-Cabaniols wrote:
>>>>> 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>>
>>>>>> On 02/29/2012 06:52 PM, Charles Lesire-Cabaniols wrote:
>>>>>>> 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>>>>
>>>>>>>> On 02/29/2012 06:29 PM, Charles Lesire-Cabaniols wrote:
>>>>>>>>> Hi guys,
>>>>>>>>>
>>>>>>>>> I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix Overo.
>>>>>>>>>
>>>>>>>>> I want to evaluate the execution time of a simple program, executed
>>>> as
>>>>>> a
>>>>>>>>> real-time thread.
>>>>>>>>>
>>>>>>>>> I definitely wonder about which functions to use, as I have
>>>> completely
>>>>>>>>> inconsistent measures.
>>>>>>>>> I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.
>>>>>>>>> I also directly read the CNNT register with ARM instructions (which
>>>> is
>>>>>>>> the
>>>>>>>>> only one I think correct) in order to have a (good?) reference.
>>>>>>>>> (...)
>>>>>>>>> What am I doing wrong?
>>>>>>>>
>>>>>>>> So, you should printf("%Lu %Lu\n", rt_timer_read(), rt_timer_tsc());
>>>>>>>>
>>>>>>>> Not printf("%lu", ...)
>>>>>>>>
>>>>>>>> --
>>>>>>>>                                            Gilles.
>>>>>>>>
>>>>>>>
>>>>>>> Effectively, that looks cleaner, thanks:
>>>>>>>
>>>>>>> ----- Xenomai rt_timer_read -----
>>>>>>> start: 49166276042 ; end: 49166432273 ; (s-e): 156231 ; CET: 156231
>>>>>>> ----- Xenomai rt_timer_tsc -----
>>>>>>> start: 639161547 ; end: 639163539 ; (s-e): 1992 ; CET: 1992
>>>>>>> ----- Xenomai clock_gettime -----
>>>>>>> [ s] start: 946684855 ; end: 946684855 ; (s-e): 0 ; CET: 0
>>>>>>> [ns] start: 275520245 ; end: 275677089 ; (s-e): 156844 ; CET: 156844
>>>>>>>
>>>>>>> My ARM instruction reads 110554.
>>>>>>>
>>>>>>> Which Xenomai function should I use?
>>>>>>> Which one is supposed to be the more accurate?
>>>>>>> Does rt_timer_read return nsecs?
>>>>>>> What is the unit of rt_timer_tsc?
>>>>>>
>>>>>> rt_timer_tsc uses whatever hardware counter is available, you need
>>>>>> rt_timer_tsc2ns or rt_timer_ns2tsc to convert between this unit to and
>>>>>> from nanoseconds.
>>>>>>
>>>>>> For more details, see:
>>>>>>
>>>>>>
>>>>>>
>>>>
>> http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__native__timer.html
>>>>>>
>>>>>> Depending on how xenomai user-space was compiled, rt_timer_tsc should
>>>>>> have the lowest overhead.
>>>>>>
>>>>>
>>>>> And are the default options the best ones?
>>>>
>>>> Yes, but I am not sure the debian package uses the default one. Please
>>>> post here the disassembly of rt_timer_tsc, I will tell you if your
>>>> system is compiled for the lowest overhead.
>>>>
>>>>
>>> How to do that?
>>
>> arm-none-linux-objdump -d /path/to/libnative.so.3 | less
>> search <rt_timer_tsc>, when you find it, post the disassembly here.
>>
> 
> Here it is:
> 
> 00005a54 <rt_timer_tsc>:
>     5a54:       e59f2034        ldr     r2, [pc, #52]   ; 5a90
> <rt_timer_tsc+0x3c>
>     5a58:       e3e03a0f        mvn     r3, #61440      ; 0xf000
>     5a5c:       e59f1030        ldr     r1, [pc, #48]   ; 5a94
> <rt_timer_tsc+0x40>
>     5a60:       e08f2002        add     r2, pc, r2
>     5a64:       e5133003        ldr     r3, [r3, #-3]
>     5a68:       e7921001        ldr     r1, [r2, r1]
>     5a6c:       e59f0024        ldr     r0, [pc, #36]   ; 5a98
> <rt_timer_tsc+0x44>
>     5a70:       e2833003        add     r3, r3, #3
>     5a74:       e0403283        sub     r3, r0, r3, lsl #5
>     5a78:       e92d4010        push    {r4, lr}
>     5a7c:       e5910008        ldr     r0, [r1, #8]
>     5a80:       e1a0e00f        mov     lr, pc
>     5a84:       e12fff13        bx      r3
>     5a88:       e8bd4010        pop     {r4, lr}
>     5a8c:       e12fff1e        bx      lr
>     5a90:       000086a4        andeq   r8, r0, r4, lsr #13
>     5a94:       000000ec        andeq   r0, r0, ip, ror #1
>     5a98:       ffff1004        undefined instruction 0xffff1004

This is the good one.

-- 
                                                                Gilles.

