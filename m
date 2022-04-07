References: <20220406155648.1592472-1-rpm@xenomai.org>
 <20220406155648.1592472-2-rpm@xenomai.org>
 <b806bd3e-594b-e4cf-2cc6-34f3c938b5f3@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 2/5] cobalt/events: add single-waiter delivery mode
Date: Thu, 07 Apr 2022 13:26:56 +0200
In-reply-to: <b806bd3e-594b-e4cf-2cc6-34f3c938b5f3@siemens.com>
Message-ID: <87lewhf7k6.fsf@xenomai.org>
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
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 06.04.22 17:56, Philippe Gerum via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> Allow for sending a set of event bits to the heading waiter only,
>> instead of broadcasting them to all waiters.
>> 
>> This change affects the ABI, since we add a set of operation flags to
>> the cobalt_event_sync service, to pass the new COBALT_EVENT_BCAST
>> flag. It also affects the internal API as follows:
>> 
>> - the new cobalt_event_broadcast() call behaves like
>>   cobalt_event_post() formerly did, which is broadcasting the event to
>>   all waiters atomically.
>> 
>> - the new cobalt_event_signal() call implements the single-waiter
>>   delivery mode we introduce.
>> 
>> - the former cobalt_event_post() is now a wrapper to
>>   cobalt_event_broadcast(), marked with a deprecation flag.
>
> Strictly spoken, deprecation will come with patch 4 only.
>
> Can we have some test cases for the new features as well? Who will use them?
>

Patch #1 comes with a new test for the autoclear thingy, I'll add a test
case for the single wakeup as well.

Alchemy will use them. This interface is useful to anyone who needs the
complete event flag group semantics without incurring the (significant)
extra cost of a mutex+condvar combo. Typically, although the broadcast
mode is a no-brainer, implementing the single-wakeup pattern is not
trivial with the latter.

-- 
Philippe.

