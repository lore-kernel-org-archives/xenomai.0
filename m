MIME-Version: 1.0
In-Reply-To: <530CBFB6.6000908@xenomai.org>
References: <CAKc2HpbgUU77_Y25KXjf6jHHLzmNX3PmOxqQsYK4dH0crk9--A@mail.gmail.com>
 <530CBFB6.6000908@xenomai.org>
Date: Wed, 26 Feb 2014 10:02:47 +0100
Message-ID: <CAKc2Hpbr_4RVB5iJqvUymk2vUPqCtAiTU9kt5L3BUc58mYsVEQ@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

2014-02-25 17:07 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:
> On 02/25/2014 10:07 AM, Kim De Mey wrote:
>>
>> Hello all,
>>
>> I noticed that when enabling the registry in Xenomai-forge (mercury
>> core), that the SIGCHLD gets set to ignore (SIG_IGN) in the
>> spawn_daemon() call.
>> I guess this choice was made to make sure no zombies of the daemon
>> stay alive. Correct?
>
>
> Yes.
>
>
>>
>> This does however mean that the default behaviour of the application
>> regarding the handling of children is changed. Now I wonder whether it
>> is okay (as a rule/practice) for a library to change this behaviour of
>> the application. Shouldn't we look for a solution where the behaviour
>> of the application remains untouched?
>>
>
> The default action for SIGCHLD is to ignore it. If the app wants to handle
> this signal specifically, it will have to trap it and figure out which child
> it cares about has exited in any case. So the library action for this signal
> does not change anything to the default case actually.
>

It is true that the default is to ignore it. However setting the
action explicitly to ignore does change the termination behaviour of
children. The children that terminate will no longer become zombies
and behaviour of wait() and wait_pid() calls is thus different (see
man page of waitpid()).
This different behaviour of waitpid() is also how I noticed the SIG_IGN.

> --
> Philippe.

