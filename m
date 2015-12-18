MIME-Version: 1.0
In-Reply-To: <5673B86F.6080205@gmail.com>
References: <mailman.3.1450263601.11243.xenomai@xenomai.org>
 <mailman.3.1450263601.11243.xenomai.{4ac8acb6-338d-4c9e-8bb4-e7df718e2fe0}.0@xenomai.org>
 <20151216064242.GC1786@hermes.click-hack.org> <5673B86F.6080205@gmail.com>
From: ilyasse toumi <toumi.ily@gmail.com>
Date: Fri, 18 Dec 2015 13:41:50 +0100
Message-ID: <CAG6c7CaSBQrr+WHWNQfCcpfJ=0L5co8F=NQZqeyN=2TP=YEUbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] patch for RPI2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Joe Lee <joelee271828@gmail.com>
Cc: gilles.chanteperdrix@xenomai.org, xenomai@xenomai.org

Hi there

I used the same kernel (rpi-3.18.y) but this time with Xenomai 3.0.1. the
patch seems to be OK. After building it i used it with Raspbian root file
system.
I launched the latency test in both x86 and RPI2. x86 response time is of
the order of several microseconds, but RPI2 response time is of the order
of a few ten microseconds.

To summarize, the problem was with Xenomai 2 ( I didn't use git version )
and also SOC should be enabled. Now I am planning to port Xenomai on Orange
Pi, It should not be very hard since they have the  same CPU

On Fri, Dec 18, 2015 at 8:40 AM, Joe Lee <joelee271828@gmail.com> wrote:

> On Wednesday, December 16, 2015 02:42 PM, Gilles Chanteperdrix wrote:
>
>> On Tue, Dec 15, 2015 at 07:12:26PM -0800, Mathieu Rondonneau wrote:
>>
>>> On 15-12-15 10:43 AM, Gilles Chanteperdrix wrote:
>>>
>>>> On Tue, Dec 15, 2015 at 01:22:55PM +0100, ilyasse toumi wrote:
>>>>
>>>>> Hi there,
>>>>>
>>>>> I'm using kernel rpi-3.18.y as mentioned in an email sent by Joe Lee
>>>>> about
>>>>> RPI2, I used the patch ipipe-core-3.18.20-arm-6.patch and also the
>>>>> patch
>>>>> for RPI2 version5, the problem is that when i try to compile the kernel
>>>>> after patching it it gives some errors.
>>>>> It's about some implicit declarations of functions that are present in
>>>>> the
>>>>> patch like
>>>>>
>>>>> __ipipe_mach_update_tsc
>>>>>
>>>>
>>>> This one is probably due to a misconfiguration, i.e. you enabled
>>>> xenomai, but not a SOC or SOC family which provides an emulated tsc.
>>>> A lot of the coded added by the patch is compiled conditionally, so
>>>> the fact that a definition for a function is present in the patch
>>>> does not necessarily mean that it will be present with your
>>>> particular build configuration.
>>>>
>>>> if you do use Xenomai-3.0, it could be that you are missing this part of
>>> the patch?
>>>
>>
>> More likely, the SOC is not enabled in the kernel configuration.
>>
>> smp_mb__before_atomic_dec
>>>>> smp_mb__before_atomic_dec
>>>>>
>>>>
>>>> This one indicates a version of Xenomai not ready for Linux 3.18.
>>>> Xenomai 2.6.4 for instance can not be compiled with anything more
>>>> recent than Linux 3.14. You can use Xenomai 2.6 git if you want
>>>> Linux 3.18 support, or if starting a new development, it probably
>>>> makes more sense to jump to Xenomai 3.0 directly.
>>>>
>>>> Regards.
>>>>
>>>> That is correct, the patch is only for Xenomai 3.0.
>>>
>>
>> No. The patch should also work with Xenomai 2.6, but you need
>> Xenomai 2.6 git.
>>
>> Hi Gilles,
> The Xenomai 3.0.1 patched kernel is OK. But the Xenomai 2.6 patched
> sometimes hang like this:
> [7.407819] Xenomai: stuck on nucleus lock 808b14a0
> [7.407819]    waiter = kernel/xenomai/nucleus/intr.c:114
> (xnintr_clock_handler(), CPU #2)
> [7.407819]    owner  = kernel/xenomai/nucleus/intr.c:114
> (xnintr_clock_handler(), CPU #1)
> Could you help me?
>
> --
> Joe Lee
>



-- 
--
Ilyasse Toumi
Embedded system engineer
Graduate student of ISAE Supaero
+33 6 50 59 13 42
