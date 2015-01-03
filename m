Message-ID: <54A84C97.6010404@web.de>
Date: Sat, 03 Jan 2015 21:09:59 +0100
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
 <54A6FD20.5020601@xenomai.org> <54A71623.8090906@web.de>
 <54A83698.7040304@xenomai.org>
In-Reply-To: <54A83698.7040304@xenomai.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] registry daemon mangement
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

On 2015-01-03 19:36, Philippe Gerum wrote:
> On 01/02/2015 11:05 PM, Jan Kiszka wrote:
>> On 2015-01-02 21:18, Philippe Gerum wrote:
>>>>>> I'm thinking of the scenario that two unrelated but unnamed sessions=
 are
>>>>>> started, specifically by different users. In the worst case, user A
>>>>>> starts off the sysregd for anon, B joins later and reuses it therfor=
e,
>>>>>> but then A decides to terminate all its processes, including the dae=
mon.
>>>>>>
>>>>>
>>>>> sysregd deals with such dependencies, A is not in charge of terminati=
ng
>>>>> sysregd.
>>>>
>>>> That is not the point. If the user (or the system) decides to kill all
>>>> processes of it, it's dead. Also for user B. anon doesn't work well for
>>>> the multi-user case. It should rather be "personalized", run in a
>>>> per-user namespace.
>>>>
>>>
>>> If the user decides to forcibly kill a central daemon it does not own,
>>> which is not even attached its own process group anymore, then well, I'm
>>> afraid any option will have a problem. The same way, a client process
>>> running FUSE services won't kill the thread that serves the FUSE
>>> requests internally.
>>
>> Actually, the user doesn't have to run amok: Try starting a xenomai
>> process that forks off the daemon, then log out from the very same
>> session - bang, the daemon is killed. Independent of parallel users.
>>
> =

> setsid().

Yep, fixes that. Will provide a patch.

> =

>> But even if that would work, letting a user-instantiated daemon manage a
>> system-wide resource (the anon session) is a design mistake IMHO. This
>> only works reliably as long as *all* users behave coordinated and
>> carefully. That should be avoided if somehow possible.
>>
> =

> This is not how sysregd works.

Then we must be talking about different things here. Which daemons do
you know that provide system-wide services are started on behalf of its
user?

> =

>>>
>>> So no, this failure scenario makes no sense. It is no different than
>>> asking sysregd to be resilient to machine shutdown.
>>
>> If the machine shuts down, all the users of the daemon are dead anyway -
>> what is your point? But that is not true if only a single user
>> terminates something, willingly or unwillingly.
>>
> =

> I'm using this comparison because sysregd will never exit, unless the
> user forcibly kills this process: this is a daemon, fork+setsid. Killing
> this process deliberately and expecting the apps to behave properly
> would be as silly as starting a shutdown expecting any app to be
> resilient to this action. Or maybe comparing this to killing gvfsd, or
> the X server, or the dbus server would make my point clearer.

dbus is a good example. As you know, there are two types of daemon
instances: those that serve specific sessions (which are per-user, thus
the daemon runs under its control) and the one that serves a central
resource, the system bus. The latter is not created on demand but
properly started as a system service.

All I'm proposing here is to follow this common pattern also for the
central service "anon session" with sysregd. We should just provide - as
reference when needed - some script (or systemd config) to kick off a
central instance for this particular session daemon in case multi-user
Xenomai operation is desired. That script - or the daemon itself when
giving some parameter - would also be able to adjust access rights to
the session mount points.

But there is more work required to make sysregd compatible with
unprivileged operation. I just tried it, and it generated various errors
here. Need to dig into them later.

> =

>>>
>>>>>
>>>>>> Either the concept is truly multi-user capable, or we can go back to
>>>>>> managing the registry daemons centrally.
>>>>>
>>>>> How do we do this in the Mercury case where we don't want to depend on
>>>>> any kernel add-on/driver for exposing internal process data, but we do
>>>>> want to expose it through a file system? In addition, how do we do th=
is
>>>>> without copying data around?
>>>>
>>>> This has nothing to do with kernel extensions. It's a matter of managi=
ng
>>>> central user space daemons for shared services - like shared sessions.
>>>>
>>>
>>> I noticed that you did not care about answering my basic questions about
>>> your proposed design. The implementation is there, and works as
>>> advertised, including for "anon". Nothing more than advertised, nothing
>>> less. And of course, yes it does make a lot of sense to ask about the
>>> intervention of some central code in the kernel or not. You seem to be
>>> Cobalt-centric in your reasoning: fair enough, but the same
>>> implementation has to work when we don't provide any kernel bits too.
>>
>> Here we are discussing the design of the sysregd user space daemon.
>> Please explain how the kernel influences which user runs the daemon (and
>> where it puts its fuse mounts)? I'm really not looking into cobalt
>> aspects here.
> =

> - when an application starts, it looks for a sysregd daemon serving its
> session, or spawns one if none. Alternatively, one could start sysregd
> manually from the shell before launching the application as well.
> - sysregd daemonizes, no controlling terminal.
> - sysregd creates the main mount point if not present:
> /mount-point/<session-name>, then waits for clients on a local domain
> socket named after the session.
> - some client process connects to the socket endpoint.
> - sysregd extracts the client pid from the peer credentials, then
> creates a client sub-root within the name space:
> /mount-point/<session-name>/<pid>, tells the client about its dedicated
> per-process mount point, then listens to I/O events on this socket.
> - client mounts its fuse-based fs on the specified directory, for
> exporting the registry info it owns. The registry for this client's
> data/objects is therefore served by a thread which belongs to this client.
> =

> When the client exits for whatever reason, sysregd detects the close
> event on the socket, then forcibly umounts the fuse-fs hierarchy mounted
> by the client, so that we don't have stale registry branches in the tree
> (fusermount -u).
> =

> So, it's decentralized enough to make sure that a process will only
> cause its own data to become stale upon exit, nothing more. No more
> process, no more resources available from this process, nothing valuable
> to export from this process. Fair enough.

Yep, looks good.

> =

> With respect to the design issues:
> =

> - the same implementation works with Cobalt and Mercury. A common option
> for centralizing registry services would be to rely on a component
> living in kernel space, just like 2.6 does, simply because the resources
> to be exposed are maintained there in the legacy architecture. With 3.x,
> most of the exportable data is created and maintained in userland, so
> asking people running a native kernel to push a dedicated kernel module
> only for dealing with a centralized registry is not an option. We
> certainly can do this from userland, and FUSE provides a way to keep the
> file system semantics for this.

I'm not questioning this nor proposing kernel-based centralization. It's
just about centralizing the daemon for the system-wide shared anon
session when needed.

> =

> - we don't need to move data around each time a state change happens, to
> reflect it into the registry. Instead, each client process which wants
> to export data serves them using FUSE. To be even more specific about
> this issue, in the "anon" case, clients rooted under this session don't
> share anything, so what is displayed comes directly from their own local
> memory. I'd rather not broadcast changes to portions of that memory, but
> deliver it directly upon request. I'd rather not force all applications
> to maintain all their data into a single system-wide heap, where a
> central daemon could peek at.

But they apparently share a single service that is backing the system
mount point at least. There seems to be no technical need for this,
though. If I'm not missing anything, every user of the anon session
could also have the mount point locally under a user-specific path. That
would remove the need for a central anon service. Am I right?

> =

> - sysregd is only performing limited housekeeping chores to keep the
> overall hierarchy tidy as processes come and go. If sysregd dies for any
> given session, including anon, the fuse-based mount point for each
> process is still there, and the registry data from clients is still
> accessible.

But it will no longer be updated as applications in this session change
or not applications join, no? The registry becomes stale.

> One would only lose the /system hierarchy giving access to
> general information about the session which is maintained by sysregd
> directly, any attempt to access it would just fail gracefully with a
> "Transport endpoint is not connected" error. The running
> application/processes would be unaffected.
> =

> So, although there may be other designs possible for sure, I don't see
> any shortcoming in the current implementation that would lead to a
> general failure when either an application or sysregd - or even both of
> them - exit.

A lost service remains a lost service, even if it may not be critical
for all its users.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150103/3a70cb8=
4/attachment.sig>
