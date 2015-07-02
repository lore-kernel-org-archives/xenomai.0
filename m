References: <E1ZAZ7w-0003gL-BC@sd-51317.xenomai.org>
 <55953E81.7020505@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <559540CF.8080903@xenomai.org>
Date: Thu, 2 Jul 2015 15:46:55 +0200
MIME-Version: 1.0
In-Reply-To: <55953E81.7020505@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Philippe Gerum : cobalt/thread: generalize usage of
 -> lock_count for preemption control
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 07/02/2015 03:37 PM, Jan Kiszka wrote:
> On 2015-07-02 09:41, git repository hosting wrote:
>> Module: xenomai-3
>> Branch: next
>> Commit: 97e32440e9675ba91cdf80b320a35979b935dd8c
>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=97e32440e9675ba91cdf80b320a35979b935dd8c
>>
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Tue Jun 30 20:36:25 2015 +0200
>>
>> cobalt/thread: generalize usage of ->lock_count for preemption control
>>
>> XNLOCK is uselessly mirroring only part of the information
>> ->lock_count conveys.
>>
>> We only need to keep XNLOCK as a mode bit in the ABI between the
>> Cobalt core and lib/cobalt for switching the lock from user-space,
>> using ->lock_count internally for testing the current preemption
>> state.
>>
> 
> What about the mode listing in /proc/xenomai/sched/threads? I think it
> will not work anymore right now, but likely it's useful to keep this.

Correct, this needs fixing too. I'm working on moving XNLBALERT out of
the way, so that we may stop grabbing the big fat lock over xnlock
entirely, which will be nice to rtdm_lock* services.

> The registry daemon should be fine as it builds on top of the
> user/kernel ABI, right?
> 

Same issue than above: we still need to convert a non-zero lock_count to
XNLOCK in the state flags returned to userland.

-- 
Philippe.

