References: <7bd62ff7-0f90-d881-4a5f-7a80091aa321@siemens.com>
 <87eedb6n9q.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: dovetail: DEBUG_LOCKS_WARN_ON(!lockdep_stage_disabled())
In-reply-to: <87eedb6n9q.fsf@xenomai.org>
Date: Wed, 09 Jun 2021 18:05:57 +0200
Message-ID: <878s3j6n16.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> Hi Philippe,
>>
>> currently trying to understand [1]: The check in
>> lockdep_hardirqs_on_prepare triggers, e.g. over exc_int3 ->
>> do_int3_user, and then on cond_local_irq_enable().
>>
>> Where should have the current stage be stalled after exc_int3 so that
>> lockdep is happy?
>>
>
> Nowhere. v5.8 introduced irqentry_enter_from_user_mode() which raw
> (debug) traps invoke directly, and this one does not reconcile the hard
> irq state with the stall bit.
>

Unfortunately, arm and arm64 do not use the generic kernel entry code
yet, so we can exercise the Dovetail-related code only with x86.

-- 
Philippe.

