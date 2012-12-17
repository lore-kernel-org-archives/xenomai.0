Message-ID: <50CF4392.4030000@siemens.com>
Date: Mon, 17 Dec 2012 17:08:50 +0100
From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
MIME-Version: 1.0
References: <50CCEA7E.1080000__518.307140055363$1355606686$gmane$org@xenomai.org>
	<50CCF3B8.5000201@linux-kernel.net> <50CCF6C4.80408@xenomai.org>
In-Reply-To: <50CCF6C4.80408@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] core-3.5 for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "wm@linux-kernel.net" <wm@linux-kernel.net>, "Kiszka,
	Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 15/12/12 23:16, Gilles Chanteperdrix wrote:
> On 12/15/2012 11:03 PM, Wolfgang Mauerer wrote:
>> On 15/12/2012 22:24, Gilles Chanteperdrix wrote:
>>> I see some (recent) activity on this git repository:
>>> https://github.com/siemens/ipipe/commits/core-3.5_for-upstream
>>>
>>> In what state is this branch, can I pull from it?
>> please don't pull yet, I need to port a few more patches forward
>> and fix one known issue with the tree. But I'll try to send a
>> pull/discussion request next week.
>>
>>> At least the changes allowing preempt_disable()/preempt_enable() to be
>>> called from non-root context look dubious.
>> are you referring to 767f0d43fe3? This one still carries a TODO
>> item in the description to remind me to check with which
>> non-x86 archs this can cause problems, and what we can do about
>> them.
> 
> 
> Actually, we already have ipipe_safe_current(), so I guess what you need
> is ipipe_safe_current_thread_info() ?

yes, that makes sense -- how about something like

#ifndef ipipe_safe_current_thread_info
#define ipipe_safe_current_thread_info()				\
	({								\
		struct thread_info *__ti__;				\
		unsigned long __flags__;				\
		__flags__ = hard_smp_local_irq_save();			\
		__ti__ = ipipe_test_foreign_stack() ?			\
			&init_thread_info : current_thread_info();	\
		hard_smp_local_irq_restore(__flags__);			\
		__ti__;							\
	})
#endif

and use that as basis to determine the preemption counter in  preempt_count()?
Unfortunately, solely #including linux/ipipe.h into linux/preempt.h 
leads to complete havoc, most likely caused by some spinlock preprocessor magic.
So I need to figure out a clean way of getting this definition into preempt.h
before I prepare a patch.

Thanks, Wolfgang

