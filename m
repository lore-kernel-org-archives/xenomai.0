Message-ID: <51619016.1090001@xenomai.org>
Date: Sun, 07 Apr 2013 17:26:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <515DE96F.7080508@xenomai.org> <515FEF85.5010801@web.de>
	<51606911.7050205@xenomai.org> <51606A47.8000606@web.de>
	<51618C48.7040505@xenomai.org> <51618D60.80204@web.de>
In-Reply-To: <51618D60.80204@web.de>
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

On 04/07/2013 05:14 PM, Jan Kiszka wrote:

> On 2013-04-07 17:10, Gilles Chanteperdrix wrote:
>> On 04/06/2013 08:32 PM, Jan Kiszka wrote:
>>
>>> On 2013-04-06 20:27, Gilles Chanteperdrix wrote:
>>>>> And it has to map directly to might_fault
>>>>> in case CONFIG_IPIPE_DEBUG_CONTEXT is disabled (thus zero overhead).
>>>>
>>>> That would defeat the purpose of the patch. might_fault can not be
>>>> called over non root domains.
>>>
>>> True. But we should avoid leaving the costly irq-disable/enable and
>>> domain checks in production code behind when might_fault actually
>>> resolves to a nop. That should be the case for
>>> !CONFIG_DEBUG_ATOMIC_SLEEP && !CONFIG_PROVE_LOCKING.
>>
>>
>> I am almost sure I did not have either of these two options enabled when
>> I observed the bug.
> 
> Hmm. And CONFIG_PREEMPT_VOLUNTARY? In that case, might_sleep seems to
> serve as a voluntary preemption point.


>From what I see, ipipe_root_only is called systematically, even when
CONFIG_PREEMPT_VOLUNTARY is disabled.

-- 
                                                                Gilles.

