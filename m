Subject: Re: Waking up a linux thread from a xenomai thread, without mode
 switch
References: <9716cf94f871edebb580b4010a5c24465299514f.camel@sprinte.eu>
 <53dd5690-8997-6434-549d-fdb4a2b2a8b8@xenomai.org>
 <825e119a24df931fec5e9938006abe921637195f.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6d143284-475d-5514-68d7-716089130740@xenomai.org>
Date: Fri, 14 Dec 2018 16:06:16 +0100
MIME-Version: 1.0
In-Reply-To: <825e119a24df931fec5e9938006abe921637195f.camel@sprinte.eu>
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
To: Julien Blanc <julien.blanc@sprinte.eu>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 12/14/18 2:16 PM, Julien Blanc wrote:
> Le vendredi 14 décembre 2018 à 12:07 +0100, Philippe Gerum a écrit :
>>
>> You could use non-rt Xenomai threads on the linux side with policies
>> SCHED_FIFO+prio=0 or SCHED_WEAK, allowing the thread to issue
>> blocking
>> Xenomai syscalls (such as waiting on a Cobalt sema4).
>>
>> But, since this would incur two mode switches for the caller - one to
>> switch to primary, then a converse switch to relax when returning
>> from
>> the blocking syscall - you certainly don't want to use that method in
>> high-frequency loops, because this would be very costly CPU-wise.
> 
> Do you mean, using a third thread acting as a proxy, so that the
> xenomai thread never leaves the primary domain ?

You need no proxy, if what you call the "linux" thread is in fact a
Xenomai thread undergoing Xenomai "weak" scheduling policy. It would run
in secondary mode except when calling into the rt core for waiting for a
rt event.

-- 
Philippe.

