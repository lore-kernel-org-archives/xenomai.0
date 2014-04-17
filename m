Message-ID: <534FD826.8030701@xenomai.org>
Date: Thu, 17 Apr 2014 15:33:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5347D5BB.1070107@mitrol.it> <5347D6E0.2030805@xenomai.org>
 <5347DCCC.3040801@mitrol.it> <5347DF09.9080905@xenomai.org>
 <5347E0E1.3020807@mitrol.it> <5347E3DA.6010106@xenomai.org>
 <5347E8AB.7020908@mitrol.it> <5347EB00.7060203@xenomai.org>
 <534FC6F3.1050305@mitrol.it>
In-Reply-To: <534FC6F3.1050305@mitrol.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] arm imx6 and hardware FPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 04/17/2014 02:20 PM, Paolo Minazzi wrote:
> Il 11/04/2014 15.15, Gilles Chanteperdrix ha scritto:
>> On 04/11/2014 03:05 PM, Paolo Minazzi wrote:
>>> Il 11/04/2014 14.45, Gilles Chanteperdrix ha scritto:
>>>> On 04/11/2014 02:32 PM, Paolo Minazzi wrote:
>>>>> Il 11/04/2014 14.24, Gilles Chanteperdrix ha scritto:
>>>>>> On 04/11/2014 02:15 PM, Paolo Minazzi wrote:
>>>>>>> Il 11/04/2014 13.49, Gilles Chanteperdrix ha scritto:
>>>>>>>> On 04/11/2014 01:44 PM, Paolo Minazzi wrote:
>>>>>>>>> Hi to all,
>>>>>>>>> I'm trying to test my imx6 with xenomai 2.6.3.
>>>>>>>>> I use the linaro cross-compiler that uses the hardware floating
>>>>>>>>> point.
>>>>>>>>>
>>>>>>>>> I made a simple floating point test.
>>>>>>>>>
>>>>>>>>> If I use two non-realtime user-space tasks the test works OK and I
>>>>>>>>> have
>>>>>>>>> no errors in calculations.
>>>>>>>>> This means that compiler and hardware works well.
>>>>>>>>>
>>>>>>>>> But I I use two realtime user-space tasks I have errors in
>>>>>>>>> calculations.
>>>>>>>>> Real-time tasks are created with rt_task_create(&demo, "demo", 0,
>>>>>>>>> 99,
>>>>>>>>> T_FPU);
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is my kernel config
>>>>>>>>> ============================================
>>>>>>>>> ...
>>>>>>>>> #
>>>>>>>>> # Machine
>>>>>>>>> #
>>>>>>>>> CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
>>>>>>>>> CONFIG_IPIPE_WANT_ACTIVE_MM=y
>>>>>>>>> CONFIG_XENO_HW_FPU=y
>>>>>>>>> CONFIG_XENO_HW_UNLOCKED_SWITCH=y
>>>>>>>>> ...
>>>>>>>>> #
>>>>>>>>> # At least one emulation must be selected
>>>>>>>>> #
>>>>>>>>> CONFIG_VFP=y
>>>>>>>>> CONFIG_VFPv3=y
>>>>>>>>> CONFIG_NEON=y
>>>>>>>>> CONFIG_VFP_3_2_BACKPORT=y
>>>>>>>>> ...
>>>>>>>>> ============================================
>>>>>>>>>
>>>>>>>>> Is it possible to use ***hardware floating point*** with realtime
>>>>>>>>> user-space tasks ?
>>>>>>>>
>>>>>>>> Yes, it should be. Do you get the same issue when running both the
>>>>>>>> switchtest and switchtest -s 1000 tests? Do you have the same issue
>>>>>>>> with the I-pipe patch for Linux 3.8?
>>>>>>>>
>>>>>>>>
>>>>>>> / # ./switchtest -s 1000
>>>>>>> == Testing FPU check routines...
>>>>>>> d0: 1 != 2
>>>>>>> d1: 1 != 2
>>>>>>> d2: 1 != 2
>>>>>>> d3: 1 != 2
>>>>>>> d4: 1 != 2
>>>>>>> d5: 1 != 2
>>>>>>> d6: 1 != 2
>>>>>>> d7: 1 != 2
>>>>>>> d8: 1 != 2
>>>>>>> d9: 1 != 2
>>>>>>> d10: 1 != 2
>>>>>>> d11: 1 != 2
>>>>>>> d12: 1 != 2
>>>>>>> d13: 1 != 2
>>>>>>> d14: 1 != 2
>>>>>>> d15: 1 != 2
>>>>>>> == FPU check routines: OK.
>>>>>>>
>>>>>>> / # ./switchtest
>>>>>>> == Testing FPU check routines...
>>>>>>> d0: 1 != 2
>>>>>>> d1: 1 != 2
>>>>>>> d2: 1 != 2
>>>>>>> d3: 1 != 2
>>>>>>> d4: 1 != 2
>>>>>>> d5: 1 != 2
>>>>>>> d6: 1 != 2
>>>>>>> d7: 1 != 2
>>>>>>> d8: 1 != 2
>>>>>>> d9: 1 != 2
>>>>>>> d10: 1 != 2
>>>>>>> d11: 1 != 2
>>>>>>> d12: 1 != 2
>>>>>>> d13: 1 != 2
>>>>>>> d14: 1 != 2
>>>>>>> d15: 1 != 2
>>>>>>> == FPU check routines: OK.
>>>>>>>
>>>>>>> As you can see the test seems OK.
>>>>>>> But If I understand correctly switchtest is not a real-time test.
>>>>>>
>>>>>> You do not understand correctly. You should run
>>>>>> switchtest & switchtest -s 1000
>>>>>>
>>>>>> And let them run for some time.
>>>>>>
>>>>>>> I see the problem If I use my floating point test.
>>>>>>> I try to calculate sin(2x).
>>>>>>> Then I claculate 2*sin(x)*cos(x).
>>>>>>> They should be similar. But sometime they are very different ===>
>>>>>>> fpu
>>>>>>> error
>>>>>>>
>>>>>>>
>>>>>>> I have kerne 3.0.35.
>>>>>>> For me it is not so easy try 3.8.
>>>>>>
>>>>>> How is that? To test xenomai you do not need all the drivers, just
>>>>>> the
>>>>>> uart.
>>>>>>
>>>>>>
>>>>> I'm able to do it.
>>>>> But I'm paid for use this board. Try I cannot loose too time to test
>>>>> configurations that we will not use.
>>>>> I understand you, but you should try to understand me.
>>>>> Have you got some ideas ?
>>>>
>>>> I have given you my ideas. Of course, you are free to ignore them and
>>>> debug the issue on your own.
>>>>
>>>>
>>> I understand your hard words.
>>> I understand only because in my life I worked (in my free time) on a
>>> very complex project : colinux64.
>>> If you do not know, colinux is a porting of linux kernel on windows.
>>> Only who works on these complex parts of the system know the hard works
>>> there is to do and what it means find bug. The same complexity of
>>> xenomai.
>>>
>>> I have done my homework, but not in xenomai project world.
>>> Repeat, I understand your words ... but remember that not all the people
>>> are stupid and do not want to find bug.
>>> You do not know the skills of the persons on the other side, so my
>>> advice is to try to understand which kind of person you are contacting.
>>> It is not so easy ... but it could be important in your work.
>>
>> What are you talking about? You ask a question, I reply rapidly with
>> some ideas to test. You do not want to test these ideas, so the
>> conclusion is: debug the issue on your own. I do not know any other
>> answer than the one I gave you.
>>
>>
> Studying the problem it seems that xenomai works fine.
> The problem maybe is related to not re-entrance of sin and cos function.
> If I use simple float operation I do not see the problem.
>
> I have the same problem using two non realtime task, so I can say that
> the problem is not related to xenomai.

In order to be sure that the bug is not introduced by Xenomai, you 
should disable CONFIG_XENOMAI, CONFIG_IPIPE, and in fact, even try the 
unpatched kernel. And again: you can use the switchtest tool to test 
whether FPU is OK (with CONFIG_XENOMAI), and if switchtest fails after 
some time, we have tools to make debugging much easier.

Also note that the 3.0 kernel was released more than 3 years ago, so it 
is entirely possible that mainline bugs have been fixed since then, both 
on Linux side, and on I-pipe side, which is the reason I asked you to 
test a more recent kernel.

-- 
					    Gilles.

