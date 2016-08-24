Message-ID: <57BD7815.4090007@allwinnertech.com>
Date: Wed, 24 Aug 2016 18:33:57 +0800
From: xielinfei <xielinfei@allwinnertech.com>
MIME-Version: 1.0
References: <57B41CA5.5040103@allwinnertech.com>
 <a7e6b5c8-ba49-3b78-09a3-f8417ae4a0b9@xenomai.org>
 <458bb092-c690-e8e9-7d9b-a66969b4505f@xenomai.org>
 <57B67DAD.8060707@allwinnertech.com> <57B6FA48.4070609@allwinnertech.com>
 <3abb8d06-cf67-d90f-de3f-6e3d935d93d3@xenomai.org>
In-Reply-To: <3abb8d06-cf67-d90f-de3f-6e3d935d93d3@xenomai.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai]
 =?utf-8?b?W+WPr+iDveaYr+Weg+WcvumCruS7tl0gIFJlOiAgW2hl?=
 =?utf-8?q?lp=5D_porting_I-pipe_patch_on_linux-3=2E4_ARM=28cortex-a7=29_so?=
 =?utf-8?q?c?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Hi Philippe,

       Thank for your suggestion!
       I downgraded ipipe-3.10.32 to linux-3.4.39 and it works,
       However, I get some negative value, is this normal?
---------------------------------------------------------------------------=
-----------------
/usr/xenomai/bin # ./k /usr/xenomai/bin # ./klatency
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:00  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      -8.459|      -8.290|      -2.918|       0| -8.459|      -2.918
RTD|      -8.459|      -8.297|      -4.835|       0| -8.459|      -2.918
RTD|      -8.418|      -8.247|      -0.335|       0| -8.459|      -0.335
RTD|      -8.460|      -8.294|      -4.460|       0| -8.460|      -0.335
RTD|      -8.460|      -8.198|      -2.002|       0| -8.460|      -0.335
---------------------------------------------------------------------------=
--------------------
/usr/xenomai/bin # ./l /usr/xenomai/bin # ./latency =1B[J
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
best|--lat worst
RTD|     -3.417|     -3.042|      3.041|       0|     0| -3.417|      3.041
RTD|     -3.917|     -3.292|     19.624|       0|     0| -3.917|     19.624
RTD|     -3.917|     -3.292|     18.541|       0|     0| -3.917|     19.624
RTD|     -3.917|     -3.292|     17.541|       0|     0| -3.917|     19.624
RTD|     -3.917|     -3.334|     12.124|       0|     0| -3.917|     19.624
---------------------------------------------------------------------------=
-----------------------

On 2016=E5=B9=B408=E6=9C=8822=E6=97=A5 02:27, Philippe Gerum wrote:
> On 08/19/2016 02:23 PM, xielinfei wrote:
>> Hi Philippe,
>>
>>
>> test-3.4.6-patch: it is the official I-pipe patch
>> ipipe-core-3.4.6-arm-4.patch
>> <http://xenomai.org/downloads/ipipe/v3.x/arm/older/ipipe-core-3.4.6-arm-=
4.patch>
>> test-3.4.v3s-patch: It is the vendor sdk with the modified I-pipe patch
>> (mainly based on ipipe-core-3.4.6-arm-4.patch
>> <http://xenomai.org/downloads/ipipe/v3.x/arm/older/ipipe-core-3.4.6-arm-=
4.patch>)
>>
>> The mainly differ as follow:
>> ------------------------------------------------------------------------=
--------------------------------------------------------------
>> diff -r test-3.4.6-patch/arch/arm/kernel/entry-armv.S
>> test-3.4.v3s-patch/arch/arm/kernel/entry-armv.S
>> 269a270,282
>>> __und_fault:
>>>      @ Correct the PC such that it is pointing at the instruction
>>>      @ which caused the fault.  If the faulting instruction was ARM
>>>      @ the PC will be pointing at the next instruction, and have to
>>>      @ subtract 4.  Otherwise, it is Thumb, and the PC will be
>>>      @ pointing at the second half of the Thumb instruction.  We
>>>      @ have to subtract 2.
>>>      ldr    r2, [r0, #S_PC]
>>>      sub    r2, r2, r1
>>>      str    r2, [r0, #S_PC]
>>>      b    do_undefinstr
>>> ENDPROC(__und_fault)
>>>
>> 295c308
>> < #ifndef    CONFIG_THUMB2_KERNEL
>
> Please always send unified diffs (diff -u) to express changes in source
> code, this is easier to analyze than the antiquated original diff format.
>
> I don't see any hunks fixing up the architected timer to make it
> pipeline-aware. Those changes should take place in
> drivers/clocksource/arm_arch_timer.c. Some of them also allow a userland
> code to read the MMIO registers taping into the clock source, this will
> be required for running Xenomai apps.
>
> On a general note, I would not try to upgrade ipipe-3.4.6 for supporting
> the architected timer, I would rather downgrade ipipe-3.18 to match your
> 3.4.6 kernel. This way, the port would include all the post-3.4 fixes,
> and the support for the arch timer as well.
>
> If you chose to do so, you only need to port the changes affecting the
> devices provided by your SoC, ignoring any hunk which belong to other
> ARM SoC/variants (e.g. timers, clock sources, irq chip controllers, gpio
> modules etc).
>
> You could run splitdiff -a on the ipipe-3.18 patch, cherry-picking all
> the needed changes.
>

--

Best regards=EF=BC=81
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
=E8=B0=A2=E6=9E=97=E8=8F=B2
=E7=8F=A0=E6=B5=B7=E5=85=A8=E5=BF=97=E7=A7=91=E6=8A=80=E8=82=A1=E4=BB=BD=E6=
=9C=89=E9=99=90=E5=85=AC=E5=8F=B8     BU1-PSW
=E5=9C=B0=E5=9D=80=EF=BC=9A=E5=B9=BF=E4=B8=9C=E7=9C=81=E7=8F=A0=E6=B5=B7=E5=
=B8=82=E9=AB=98=E6=96=B0=E5=8C=BA=E5=94=90=E5=AE=B6=E6=B9=BE=E9=95=87=E7=A7=
=91=E6=8A=802=E8=B7=AF9=E5=8F=B7
=E9=82=AE=E7=BC=96=EF=BC=9A519000
TEL=EF=BC=9A15018321890
=E5=85=AC=E5=8F=B8=E7=BD=91=E5=9D=80=EF=BC=9A http://www.allwinnertech.com

NOTICE: This e-mail and any included attachments are intended only for the =
sole use of named and intended recipient (s) only. If you are the named and=
 intended recipient, please note that the information contained in this ema=
il and its embedded files are confidential and privileged. If you are neith=
er the intended nor named recipient, you are hereby notified that any unaut=
horized review, use, disclosure, dissemination, distribution, or copying of=
 this communication, or any of its contents, is strictly prohibited. Please=
 reply to the sender and destroy the original message and all your records =
of this message (whether electronic or otherwise). Furthermore, you should =
not disclose to any other person, use, copy or disseminate the contents of =
this e-mail and/or the documents accompanying it.

