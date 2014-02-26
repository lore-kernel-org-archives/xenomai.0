Message-ID: <530DB32C.2070403@xenomai.org>
Date: Wed, 26 Feb 2014 10:26:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKc2HpbgUU77_Y25KXjf6jHHLzmNX3PmOxqQsYK4dH0crk9--A@mail.gmail.com>	<530CBFB6.6000908@xenomai.org>
 <CAKc2HpZeu+o+8iQU0q+2oi_uVkqwc71S+JgKQ7dkC7sG0RZocA@mail.gmail.com>
In-Reply-To: <CAKc2HpZeu+o+8iQU0q+2oi_uVkqwc71S+JgKQ7dkC7sG0RZocA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: SIGCHLD to SIG_IGN in spawn_daemon()
 okay?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 02/25/2014 08:03 PM, Kim De Mey wrote:
> 2014-02-25 17:07 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:
>> On 02/25/2014 10:07 AM, Kim De Mey wrote:
>>>
>>> Hello all,
>>>
>>> I noticed that when enabling the registry in Xenomai-forge (mercury
>>> core), that the SIGCHLD gets set to ignore (SIG_IGN) in the
>>> spawn_daemon() call.
>>> I guess this choice was made to make sure no zombies of the daemon
>>> stay alive. Correct?
>>
>>
>> Yes.
>>
>>
>>>
>>> This does however mean that the default behaviour of the application
>>> regarding the handling of children is changed. Now I wonder whether it
>>> is okay (as a rule/practice) for a library to change this behaviour of
>>> the application. Shouldn't we look for a solution where the behaviour
>>> of the application remains untouched?
>>>
>>
>> The default action for SIGCHLD is to ignore it. If the app wants to handle
>> this signal specifically, it will have to trap it and figure out which child
>> it cares about has exited in any case. So the library action for this signal
>> does not change anything to the default case actually.
>>
>
> It is true that the default is to ignore it. However setting the
> action explicitly to ignore does change the termination behaviour of
> children. The children that terminate will no longer become zombies
> and behaviour of wait() and wait_pid() calls is thus different (see
> man page of waitpid()).
> This different behaviour of waitpid() is also how I noticed the SIG_IGN.
>

Which does not change the situation with respect to handling SIGCLD, 
only for background threads calling waitpid() to collect exit statuses 
eagerly, in absence of exit notification.

Your application can still re-trap SIGCLD to some handler, do the wait() 
to collect the exit status there, identifying your own threads based on 
the returned pid to take proper action. In that sense, the fact that the 
library initially ignores the signal does not change the general 
behavior if you do care for such signal afterwards.

The issue in your case seems that you don't want to set any disposition 
for SIGCLD, and therefore expect that copperplate won't do it either. So 
the alternative for preventing zombies is between trusting the 
application for collecting all statuses properly, or asking the 
application to use the signal-based mechanism for collecting exit 
status. Option #2 is current, as you noticed it.

-- 
Philippe.

