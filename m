Subject: Re: [BUG] copperlate/eventobj.c ->>> eventobj_inquire(), don't work
References: <e371ebd5-519a-cf6e-998e-b2591d4f1c48@163.com>
 <d926b5a5-da09-c2f1-0b81-544cae7cc9d9@xenomai.org>
 <4bfa01f9-d2c0-de99-ec25-458578c23e3e@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e4362081-b1e8-32a1-98a6-6f25840cadf0@xenomai.org>
Date: Mon, 13 Jul 2020 20:27:15 +0200
MIME-Version: 1.0
In-Reply-To: <4bfa01f9-d2c0-de99-ec25-458578c23e3e@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Caffreyfans <Caffreyfans@163.com>, xenomai@xenomai.org

On 7/13/20 7:59 PM, Jan Kiszka wrote:
> On 10.07.20 10:38, Philippe Gerum via Xenomai wrote:
>> On 7/10/20 8:04 AM, Caffreyfans via Xenomai wrote:
>>> Hi sir,
>>>
>>>      I'm trying to make another skin for xenomai.  When I do something about
>>> "event". I use `eventobj_inquire()` to get event flags. But no matter what
>>> value I post, I always get 0.
>>>
>>>      I find that eventobj_inquire() is not working. I know `alchemy/event`
>>> also
>>> use `eventobj`. So I write a test code by using alchemy skin. I am curious
>>> whether it is my own problem or there is an error in xenomai.
>>>
>>
>> Most likely a bug in Xenomai. In addition, looking at cobalt_event_post(),
>> there is a blatant race condition between the signal <-> wait operations. The
>> in-kernel wait() operation serializes on the ugly big lock which is not going
>> to help much against racing with the userland counterpart in
>> cobalt_event_post(), which does this:
>>
>>     __sync_or_and_fetch(&state->value, bits); /* full barrier. */
>>
>>     if ((state->flags & COBALT_EVENT_PENDED) == 0)
>>         return 0;
>>
>> The somebody-is-waiting bit tested above should be part of some atomic
>> operation shared with the wait-side or covered by the ugly big lock, but the
>> way it is implemented today can lead to spurious waits.
>>
>> The event code was fixed months ago for another bad issue, the whole thing
>> looks fragile. You may want to review all of it.
>>
> 
> The issue Caffreyfrans is describing seems more like a synchronous one. Didn't
> reproduce or analyzed yet, but it looks more "friendly" to me.
> 

The issue in cobalt_event_post() is very unlikely related to the problem with
the inquiry service, for sure. The serialization issue poked my eyes as I was
tracking the updates to the event value for the inquiry problem.

> The one that you bring up would be nasty. But why should that happen? Do we
> miss to recheck a condition inside the syscall and therefore starve?
> 

event_wait(kernel)		event_post(user)
------------------		----------------

lock(&nklock)			update event->value
bits not in event->value:	
				!EVENT_PENDED
	raise EVENT_PENDED
	xnsynch_sleep_on	
				=> no kernel entry
(waits indefinitely)		(event_sync is missed)

And SMP is not even required to break it. So either the EVENT_PENDED
information is folded into the event value so that both can be checked
atomically as one like mutexes do, or the broken optimization in userland is
replaced by a direct call to some kernel-based event_post service (tbd).
Obviously, option #1 would consume a bit in order to encode EVENT_PENDED,
limiting the effective event map to 31 bits, which would be a problem ABI- and
API-wise.

-- 
Philippe.

