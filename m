Message-ID: <4F216952.7010009@domain.hid>
Date: Thu, 26 Jan 2012 15:55:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F202C11.70908@domain.hid> <4F202F4E.6000708@domain.hid>
	<4F203237.2010102@domain.hid> <4F203353.8030302@domain.hid>
	<4F2035B6.6090105@domain.hid> <4F203771.6070708@domain.hid>
	<4F203F7F.70509@domain.hid> <4F204466.1040603@domain.hid>
	<4F212CC4.6060001@domain.hid>
In-Reply-To: <4F212CC4.6060001@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Add sigdebug unit test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 01/26/2012 11:36 AM, Jan Kiszka wrote:
> On 2012-01-25 19:05, Jan Kiszka wrote:
>> On 2012-01-25 18:44, Gilles Chanteperdrix wrote:
>>> On 01/25/2012 06:10 PM, Jan Kiszka wrote:
>>>> On 2012-01-25 18:02, Gilles Chanteperdrix wrote:
>>>>> On 01/25/2012 05:52 PM, Jan Kiszka wrote:
>>>>>> On 2012-01-25 17:47, Jan Kiszka wrote:
>>>>>>> On 2012-01-25 17:35, Gilles Chanteperdrix wrote:
>>>>>>>> On 01/25/2012 05:21 PM, Jan Kiszka wrote:
>>>>>>>>> We had two regressions in this code recently. So test all 6 possible
>>>>>>>>> SIGDEBUG reasons, or 5 if the watchdog is not available.
>>>>>>>>
>>>>>>>> Ok for this test, with a few remarks:
>>>>>>>> - this is a regression test, so should go to
>>>>>>>> src/testsuite/regression(/native), and should be added to the
>>>>>>>> xeno-regression-test
>>>>>>>
>>>>>>> What are unit test for (as they are defined here)? Looks a bit inconsistent.
>>>>>
>>>>> I put under "regression" all the tests I have which corresponded to
>>>>> things that failed one time or another in xenomai past. Maybe we could
>>>>> move unit tests under regression.
>>>>>
>>>>>>>
>>>>>>>> - we already have a regression test for the watchdog called mayday.c,
>>>>>>>> which tests the second watchdog action, please merge mayday.c with
>>>>>>>> sigdebug.c (mayday.c also allows checking the disassembly of the code in
>>>>>>>> the mayday page, a nice feature)
>>>>>>>
>>>>>>> It seems to have failed in that important last discipline. Need to check
>>>>>>> why.
>>>>>>
>>>>>> Because it didn't check the page content for correctness. But that's now
>>>>>> done via the new watchdog test. I can keep the debug output, but the
>>>>>> watchdog test of mayday looks obsolete to me. Am I missing something?
>>>>>
>>>>> The watchdog does two things: it first sends a SIGDEBUG, then if the
>>>>> application is still spinning, it sends a SIGSEGV. As far as I
>>>>> understood, you test tests the first case, and mayday tests the second
>>>>> case, so, I agree that mayday should be removed, but whatever it tests
>>>>> should be integrated in the sigdebug test.
>>>>>
>>>>
>>>> Err... SIGSEGV is not a feature, it was the bug I fixed today. :) So the
>>>> test case actually specified a bug as correct behavior.
>>>>
>>>> The fallback case is in fact killing the RT task as before. But I'm
>>>> unsure right now: will this leave the system always in a clean state
>>>> behind?
>>>
>>> The test case being a test case and doing nothing particular, I do not
>>> see what could go wrong. And if something goes wrong, then it needs fixing.
>>
>> Well, if you kill a RT task while it's running in the kernel, you risk
>> inconsistent system states (held mutexex etc.). In this case the task is
>> supposed to spin in user space. If that is always safe, let's implement
>> the test.
> 
> Had a closer look: These days the two-stage killing is only useful to
> catch endless loops in the kernel. User space tasks can't get around
> being migrated on watchdog events, even when SIGDEBUG is ignored.
> 
> To trigger the enforced task termination without leaving any broken
> states behind, there is one option: rt_task_spin. Surprisingly for me,
> it actually spins in the kernel, thus triggers the second level if
> waiting long enough. I wonder, though, if that behavior shouldn't be
> improved, ie. the spinning loop be closed in user space - which would
> take away that option again.
> 
> Thoughts?

You can also call in an infinite loop, a xenomais syscall which causes a
switch to primary mode, but fails.


-- 
					    Gilles.

