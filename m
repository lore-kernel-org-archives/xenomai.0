Message-ID: <5347DCCC.3040801@mitrol.it>
Date: Fri, 11 Apr 2014 14:15:08 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <5347D5BB.1070107@mitrol.it> <5347D6E0.2030805@xenomai.org>
In-Reply-To: <5347D6E0.2030805@xenomai.org>
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
To: xenomai@xenomai.org

Il 11/04/2014 13.49, Gilles Chanteperdrix ha scritto:
> On 04/11/2014 01:44 PM, Paolo Minazzi wrote:
>> Hi to all,
>> I'm trying to test my imx6 with xenomai 2.6.3.
>> I use the linaro cross-compiler that uses the hardware floating point.
>>
>> I made a simple floating point test.
>>
>> If I use two non-realtime user-space tasks the test works OK and I have
>> no errors in calculations.
>> This means that compiler and hardware works well.
>>
>> But I I use two realtime user-space tasks I have errors in calculations.
>> Real-time tasks are created with rt_task_create(&demo, "demo", 0, 99,
>> T_FPU);
>>
>>
>> This is my kernel config
>> ============================================
>> ...
>> #
>> # Machine
>> #
>> CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
>> CONFIG_IPIPE_WANT_ACTIVE_MM=y
>> CONFIG_XENO_HW_FPU=y
>> CONFIG_XENO_HW_UNLOCKED_SWITCH=y
>> ...
>> #
>> # At least one emulation must be selected
>> #
>> CONFIG_VFP=y
>> CONFIG_VFPv3=y
>> CONFIG_NEON=y
>> CONFIG_VFP_3_2_BACKPORT=y
>> ...
>> ============================================
>>
>> Is it possible to use ***hardware floating point*** with realtime
>> user-space tasks ?
>
> Yes, it should be. Do you get the same issue when running both the 
> switchtest and switchtest -s 1000 tests? Do you have the same issue 
> with the I-pipe patch for Linux 3.8?
>
>
/ # ./switchtest -s 1000
== Testing FPU check routines...
d0: 1 != 2
d1: 1 != 2
d2: 1 != 2
d3: 1 != 2
d4: 1 != 2
d5: 1 != 2
d6: 1 != 2
d7: 1 != 2
d8: 1 != 2
d9: 1 != 2
d10: 1 != 2
d11: 1 != 2
d12: 1 != 2
d13: 1 != 2
d14: 1 != 2
d15: 1 != 2
== FPU check routines: OK.

/ # ./switchtest
== Testing FPU check routines...
d0: 1 != 2
d1: 1 != 2
d2: 1 != 2
d3: 1 != 2
d4: 1 != 2
d5: 1 != 2
d6: 1 != 2
d7: 1 != 2
d8: 1 != 2
d9: 1 != 2
d10: 1 != 2
d11: 1 != 2
d12: 1 != 2
d13: 1 != 2
d14: 1 != 2
d15: 1 != 2
== FPU check routines: OK.

As you can see the test seems OK.
But If I understand correctly switchtest is not a real-time test.

I see the problem If I use my floating point test.
I try to calculate sin(2x).
Then I claculate 2*sin(x)*cos(x).
They should be similar. But sometime they are very different ===> fpu error


I have kerne 3.0.35.
For me it is not so easy try 3.8.

Paolo


