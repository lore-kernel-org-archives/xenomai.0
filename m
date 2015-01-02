Message-ID: <54A71623.8090906@web.de>
Date: Fri, 02 Jan 2015 23:05:23 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
 <54A672BA.8090209@web.de> <54A679D5.20903@xenomai.org>
 <54A67CD1.10103@web.de> <54A69D42.2010408@xenomai.org>
 <54A69BFA.7060405@web.de> <54A6A506.3060504@xenomai.org>
 <54A6A387.4010109@web.de> <20150102141625.GD1492@daedalus>
 <20150102150638.GE1492@daedalus> <54A6C072.7020303@web.de>
 <54A6DE57.6020900@xenomai.org> <54A6DED7.1010900@web.de>
 <54A6EF96.9040607@xenomai.org> <54A6EE3B.3070909@web.de>
 <54A6F202.3080307@xenomai.org> <54A6F14F.7080601@web.de>
 <54A6F79E.4010602@xenomai.org> <54A6F65F.5010405@web.de>
 <54A6FD20.5020601@xenomai.org>
In-Reply-To: <54A6FD20.5020601@xenomai.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] registry daemon mangement (was: Re: [Xenomai-git]
 Philippe Gerum: copperplate: add configuration tunable for registry moint
 point)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-01-02 21:18, Philippe Gerum wrote:
>>>> I'm thinking of the scenario that two unrelated but unnamed sessions a=
re
>>>> started, specifically by different users. In the worst case, user A
>>>> starts off the sysregd for anon, B joins later and reuses it therfore,
>>>> but then A decides to terminate all its processes, including the daemo=
n.
>>>>
>>>
>>> sysregd deals with such dependencies, A is not in charge of terminating
>>> sysregd.
>>
>> That is not the point. If the user (or the system) decides to kill all
>> processes of it, it's dead. Also for user B. anon doesn't work well for
>> the multi-user case. It should rather be "personalized", run in a
>> per-user namespace.
>>
> =

> If the user decides to forcibly kill a central daemon it does not own,
> which is not even attached its own process group anymore, then well, I'm
> afraid any option will have a problem. The same way, a client process
> running FUSE services won't kill the thread that serves the FUSE
> requests internally.

Actually, the user doesn't have to run amok: Try starting a xenomai
process that forks off the daemon, then log out from the very same
session - bang, the daemon is killed. Independent of parallel users.

But even if that would work, letting a user-instantiated daemon manage a
system-wide resource (the anon session) is a design mistake IMHO. This
only works reliably as long as *all* users behave coordinated and
carefully. That should be avoided if somehow possible.

> =

> So no, this failure scenario makes no sense. It is no different than
> asking sysregd to be resilient to machine shutdown.

If the machine shuts down, all the users of the daemon are dead anyway -
what is your point? But that is not true if only a single user
terminates something, willingly or unwillingly.

> =

>>>
>>>> Either the concept is truly multi-user capable, or we can go back to
>>>> managing the registry daemons centrally.
>>>
>>> How do we do this in the Mercury case where we don't want to depend on
>>> any kernel add-on/driver for exposing internal process data, but we do
>>> want to expose it through a file system? In addition, how do we do this
>>> without copying data around?
>>
>> This has nothing to do with kernel extensions. It's a matter of managing
>> central user space daemons for shared services - like shared sessions.
>>
> =

> I noticed that you did not care about answering my basic questions about
> your proposed design. The implementation is there, and works as
> advertised, including for "anon". Nothing more than advertised, nothing
> less. And of course, yes it does make a lot of sense to ask about the
> intervention of some central code in the kernel or not. You seem to be
> Cobalt-centric in your reasoning: fair enough, but the same
> implementation has to work when we don't provide any kernel bits too.

Here we are discussing the design of the sysregd user space daemon.
Please explain how the kernel influences which user runs the daemon (and
where it puts its fuse mounts)? I'm really not looking into cobalt
aspects here.

> =

> I understand you are looking for a killer argument to make your point
> about changing /mnt to /var/run, which seems to imply now that you would
> want the entire registry to be rewritten, for the sake of making your
> argument fly.

This is clearly over-interpreting my point. Gilles brought up the topic
of mulit-user scenarios, and that made me think about mount-point
unrelated aspects of the daemon. I renamed the thread therefore.

> =

> If you think sysregd is badly designed or implemented after actual
> testing, please come with facts, but doing so in a separate discussion
> would likely have more impact.

That there is one corner remaining which is not yet round doesn't make
the whole design bad - where did I say this?

BTW, your change that kicked off this thread broke the registry-enabled
build. I've pushed a fix.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150102/4b01c06=
3/attachment.sig>
