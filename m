Message-ID: <50F30E2A.4090706@xenomai.org>
Date: Sun, 13 Jan 2013 20:42:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F1B329.80303@xenomai.org>
	<50F2592F.3010300@zultron.com> <50F2994F.6060904@web.de>
	<50F2A629.4030901@xenomai.org> <50F30C61.8090303@zultron.com>
In-Reply-To: <50F30C61.8090303@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.5.3 posix/mprotect fail "sigdebug_handler
 triggered" (Was: Re: Kernel OOPS during regression tests)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, Xenomai <xenomai@xenomai.org>

On 01/13/2013 08:34 PM, John Morris wrote:

> Another subject change here...
> 
> On 01/13/2013 06:18 AM, Gilles Chanteperdrix wrote:
>> On 01/13/2013 12:23 PM, Jan Kiszka wrote:
>>
>>> On 2013-01-13 07:50, John Morris wrote:
>>>> On 01/12/2013 01:02 PM, Gilles Chanteperdrix wrote:
>>>>> On 01/12/2013 06:26 PM, John Morris wrote:
>>>>>
>>>>>> 1)  Most worrisome is "kernel BUG at mm/mmap.c:2313!   invalid opcode:
>>>>>> 0000 [#2] SMP".  Is this related to HEAPSZ or STACKPOOLSZ?  My mind is
>>>>>> getting foggy about all the things I've seen, but it seems like it was
>>>>>> happening earlier in the tests until these config values were quadrupled.
>>>>>
>>>>>
>>>>> Try disabling transparent hugepages, as noted by Jan.
>>>>>
>>>>>>
>>>>>> 2)  posix/mprotect is failing:  "FAILURE: sigdebug_handler triggered,
>>>>>> reason 2    memory write after exec enable".
>>>>>>
>>>>>> 3)  FPU warning:  "fptest.h:24: Warning: Linux is compiled to use FPU in
>>>>>> kernel-space.    For this reason, switchtest can not test using FPU in
>>>>>> Linux kernel-space."
>>>>>>
>>>>>> Regression test run log:
>>>>>> http://www.zultron.com/static/2013/01/xenomai/foo-xeno-regression-test.log
>>>>>
>>>>>
>>>>> You should normally use the -l option to use a non default "load", and
>>>>> run the test for a long time.
>>>>>
>>>>> See xeno-regression-test --help and dohell --help
>>>>>
>>>>>
>>>>
>>>>
>>>> Jan's fix appears to have solved 1) above, but 2) posix/mprotect is
>>>> still failing.  Thanks for the xeno-regression-test tips; ran a couple
>>>> more (not for a long time, will do that later).
>>>
>>> Can you clarify how your setup looks like? The kernel is a vanilla 3.5.3
>>> patched with ipipe-core-3.5.3-x86-2.patch? And then you just disabled
>>> THP? Or did you switch to my for-upstream/3.5 I-pipe branch?
> 
> Vanilla 3.5.3, released Xenomai 2.6.2, THP disabled.
> 
>> I have merged the bugfixes from your branch in my branch in addition to
>> other bug fixes, so, I would recommend using this one.
> 
> You must mean the xenomai-2.6.git tree, master branch.  I'll begin using
> that.


I mean branch for-core-3.5.7 in ipipe-gch git. But you should also pull
the xenomai-2.6 git master branch fixes, yes.


-- 
                                                                Gilles.

