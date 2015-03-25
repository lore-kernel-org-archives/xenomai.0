Message-ID: <5512C4CB.6070808@mitrol.it>
Date: Wed, 25 Mar 2015 15:23:07 +0100
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <55127004.3010708@mitrol.it>
 <20150325083622.GF15125@hermes.click-hack.org> <55127908.5050202@mitrol.it>
 <20150325090354.GG15125@hermes.click-hack.org> <55127BB1.7040804@mitrol.it>
 <20150325092001.GI15125@hermes.click-hack.org> <5512850D.4030606@mitrol.it>
 <5512B7E0.5090002@xenomai.org>
In-Reply-To: <5512B7E0.5090002@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] fault in ppd_lookup_inner
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Il 25/03/2015 14:28, Philippe Gerum ha scritto:
> On 03/25/2015 10:51 AM, Paolo Minazzi wrote:
>>>> I understand ... I port the fix to avoid compatililityproblem.
>>>> I made only ksrc changes, so my user space is 100% compatible.
>>> There is no compatibility problem between versions of a stable
>>> branch. 2.6.4 is compatible with 2.6.0, 2.6.1, 2.6.2, 2.6.3. It is
>>> even ABI compatible, you do not even have to recompile your
>>> applications.
>>>
>>>> I understand that you do not agree with me because you prefer a clean
>>>> 2.6.4.
>>>> I can try an other library. Do you mean a smaller library?
>>> Any library that everybody has on his system, to allow reproducing
>>> the issue. You could also try replacing the dlopen with a nanosleep.
>>>
>>>> This is a strange test. I'm trying it because in the past I have had
>>>> some
>>>> memory corruption that make system instable.
>>>> I would like to be sure about it.
>>> I do not doubt that you observed an issue. I would simply like to be
>>> sure that it has not already been fixed in Xenomai or the I-pipe
>>> patch.
>>>
>> I will make other tests.
>> If I discover something I will write on mailing list.
> 3.0.35-fsl for imx6 has multiple issues of its own, particularly in the
> SMP case. In addition, the pipeline patch over this one belongs to the
> legacy series, which also has bugs that were fixed in recent I-pipe
> series for 3.x kernels.
>
> Typically, the way process cleanup events are dealt with in the pipeline
> has been fixed to close a race. Running with CONFIG_DEBUG_PAGEALLOC
> enabled might reveal some of these issues, but not all of them.
>
> I tried your test code on imx6q (3.18.2) and x86_64 (3.14.33) without
> any issue after > 100,000 iterations, dlopening libm instead of
> libvncserver.
>
My board is not SMP.
I realized that ipipe patch for imx6 for kernel 3.0.35 is not so stable 
and after some tests
it is possible see memory corruption/system instable.

Porting some part of the ipipe for 3.5 to my 3.0.35 the system become 
much more stable, exactly
[Xenomai][PATCH 1/2] ipipe: Rework and simplify __ipipe_pin_vma
[Xenomai][PATCH 2/2] ipipe: Fault in locked vmas after changing the 
protection flags

To be precise I tried my example (dlopen) with other 3 tests in parallel:
- canbus loop between can0 and can1 at 1Mbit using a realtime version of 
flexcan driver.
- test that continue to do malloc/free (realtime task)
- 10 realtime task that do nothing

I realize that the system is very stressed and it will never used in 
this way.
But it is a way to understand the level of stability.

After all, after 24 hours, 7 boards continue to run without any problem.
Only one board stopped with ppd_lookup_inner fault.

Maybe the external interrupt (the canbus driver) creates some problem.
It generates more interrupts in 1 milliseconds.
I think that rtdm is not tested as tasks linked to time. But this is my 
opion and
on this I could be wrong.
The driver is very simple, so I can say that it does not introduces bug.

I will try to do not run the canbus test to see if this bug vanish.

Thanks
Paolo


