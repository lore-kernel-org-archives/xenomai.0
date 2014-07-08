Message-ID: <53BC1B3C.9000806@xenomai.org>
Date: Tue, 08 Jul 2014 18:24:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1404677764.4624.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B9BC6A.9070501@xenomai.org>
 <1404835832.96010.YahooMailNeo@web171606.mail.ir2.yahoo.com>
In-Reply-To: <1404835832.96010.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/08/2014 06:10 PM, Matthias Schneider wrote:
> ----- Original Message -----
>
>> From: Philippe Gerum <rpm@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc:
>> Sent: Sunday, July 6, 2014 11:15 PM
>> Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()
>>
>> On 07/06/2014 10:16 PM, Matthias Schneider wrote:
>>
>> [snip]
>>
>>>   On thing I do not understand is:
>>>
>>>   in kernel cobalt_monitor_wait(), the synch object is unlocked via
>>>   xnsynch_release(). What happens if this synchobj was locked via
>>>   mon->gate.fastlock ? Shouldnt that also be released?
>>>
>>
>> xnsynch_release() handles fastlocks as well.
>>
>>
>>>   What other reason could there be if the synch object was released
>>>   via xnsynch_release, xnsynch_acquire was interrupted for
>>>   xnsynch_release to block?
>>>
>>
>> Since the issue seems to be easily reproducible, could you send a
>> self-contained piece of code illustrating it?
>>
>> Also, please mention if you are seeing this issue only when running your
>> app over GDB, or if it currently happens without any debugger attached.
>>
>> TIA,
>
>
> It seems I have not described the problematic scenario completely -
>
> there were two other threads that call called syncobj_lock()
> / cobalt_monitor_enter() at about the same time. (Actually there
> are three concurrent on the queue that is being tested, two receive
> operation and one send operation). I am pretty sure that the issue is
> extremely timing dependent.
>
> Anyway, the testcase would be
>
> queue_test_receive_peek_multiple_tasks()
>
> in
>
> freertos/lib/queue-1.c
>
> I have already submitted as a patch. In case it helps, I can
> try tro reproduce the issue with another queue implementation
> (e.g. psos) and send a short code snippet.
>

Thanks. If queue-1.c exhibits the issue, it will do, no need for more.

-- 
Philippe.

