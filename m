Message-ID: <5161C61F.9000009@xenomai.org>
Date: Sun, 07 Apr 2013 21:16:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <515DE96F.7080508@xenomai.org> <515FEF85.5010801@web.de>
	<5161A51C.8050606@xenomai.org> <5161BF47.9020007@xenomai.org>
	<5161C292.3070703@web.de>
In-Reply-To: <5161C292.3070703@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe on ARM platform.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 04/07/2013 09:01 PM, Jan Kiszka wrote:

> On 2013-04-07 20:47, Gilles Chanteperdrix wrote:
>> On 04/07/2013 06:55 PM, Gilles Chanteperdrix wrote:
>>
>>> On 04/06/2013 11:48 AM, Jan Kiszka wrote:
>>>
>>>> On 2013-04-04 22:58, Gilles Chanteperdrix wrote:
>>>>> - ftrace is broken, so I wonder if it would not be simpler to have a 
>>>>> tracer not relying on ftrace, as we did at the beginning of the I-pipe 
>>>>> tracer;
>>
>>> (...)
>>
>>>
>>> Hi,
>>>
>>> I have just pushed a new version of the for-core-3.8.2 branch with all
>>> the comments addressed.
>>>
>>> I also had tested a merge of the previous version with your next-x86
>>> branch, and except a few merge conflicts and a build error without SMP,
>>> adressed by this commit:
>>> http://git.xenomai.org/ipipe-gch.git/?p=ipipe-gch.git;a=commitdiff;h=fae81444a0bfe12de514ac039f866c0f66abfb3c;hp=1198253580e0d5610ee886e1ff3771461a06f414
> 
> Thanks for the fix, will pick it up as well.
> 
>>>
>>> It seemed to work fine on my x86 boxes.
>>
>>
>> The fixes in the next-x86 branch seem to make the tracer working, 
>> though it seems very slow (latencies doubled on ARM).
> 
> You mean the I-pipe tracer? That it works is likely due to e00888b4aa.
> The slowness, is it compared to an older I-pipe version?


Yes, it seems slower than older versions, but I have no figures, it is
just a general impression. I run "xeno-regression-test" with the tracer
on, as well as with xenomai and ipipe debugging options enabled.

> 
>>  The changes in 
>> timings seem to break some of the regression tests,
> 
> Timeouts fire?


Some tests rely on "sleep" for synchronization, I had to add a semaphore
to xddp_test, see:
http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff;h=73232678927c2afe525090a359f241c1acac4a2d;hp=926f4fbc2e38c198eefda6f0a98a278588d421db

I also had a problem with mutex-torture-native, but it does not seem
easy to reproduce.

> 
>> I also get a 
>> reproducible bug on at91sam9263 while running the "cond-torture-native" 
>> test:
>>
>> [  202.650000] Xenomai: Switching main_task to secondary mode after exception #8 in kernel-space at 0xc0093418 (pid 986)
> ...
>> [  203.470000] Unable to handle kernel paging request at virtual address 20c0041e
> 
> I suppose that address is totally off. Use after release issue?


It seems registry_unexport_pnode reads an invalid object->vfilp and
triggers registry_proc_apc whereas no vfile is currently reading the
object, as if registry_export_pnode had not been called.

-- 
                                                                Gilles.

