Message-ID: <54A6FD20.5020601@xenomai.org>
Date: Fri, 02 Jan 2015 21:18:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
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
In-Reply-To: <54A6F65F.5010405@web.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum: copperplate: add
 configuration tunable for registry moint point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 01/02/2015 08:49 PM, Jan Kiszka wrote:
> On 2015-01-02 20:55, Philippe Gerum wrote:
>> On 01/02/2015 08:28 PM, Jan Kiszka wrote:
>>> On 2015-01-02 20:31, Philippe Gerum wrote:
>>>> On 01/02/2015 08:15 PM, Jan Kiszka wrote:
>>>>> On 2015-01-02 20:20, Philippe Gerum wrote:
>>>>>> On 01/02/2015 07:09 PM, Jan Kiszka wrote:
>>>>>>> On 2015-01-02 19:07, Philippe Gerum wrote:
>>>>>>>> On 01/02/2015 04:59 PM, Jan Kiszka wrote:
>>>>>>>>> On 2015-01-02 16:06, Gilles Chanteperdrix wrote:
>>>>>>>>>> To explain a bit more completely. We can not assume that xenomai
>>>>>>>>>> applications are running as root user. And non root user are not
>>>>>>>>>> allowed to create /run/xenomai or /var/run/xenomai (at least not on
>>>>>>>>>> debian or slackware). What is more, these directories being
>>>>>>>>>> typically non persistent, a script has to be modified somewhere to
>>>>>>>>>> add mkdir /var/run/xenomai at every boot. On the other hand, mkdir
>>>>>>>>>> /mnt/xenomai has to be done once and only once, in the "make
>>>>>>>>>> install" phase for instance, since "make install" is run as root,
>>>>>>>>>> except that if /mnt is read-only it will not work. But not many
>>>>>>>>>> users are running system where they compile and run things with root
>>>>>>>>>> filesystem read-only. Anyway, the two cases are really similar, no
>>>>>>>>>> one is advantageous over the other. We are going to see questions on
>>>>>>>>>> the mailing list about that, whatever we do. Perhaps adding a small
>>>>>>>>>> kernel module to create /proc/xenomai/registry would make things
>>>>>>>>>> simpler...
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Non-root users are indeed an interesting new aspect. However, the
>>>>>>>>> solution to make a central directory writable seems weird to me. If you
>>>>>>>>> want to allow non-root users to access the registry, it would be way
>>>>>>>>> more logical to either shoot up a single privileged sysregd that
>>>>>>>>> everyone can talk to or use private instances that also run against
>>>>>>>>> their own per-user mount points, likely located in $HOME.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Technically, sysregd does not have access to all the registry data, I
>>>>>>>> mean not system-wide. The registry fs is a per-session resource based on
>>>>>>>> FUSE. In shared processing mode (--enable-pshared), any number of
>>>>>>>> processes may belong to a single session, forming one application.
>>>>>>>>
>>>>>>>> One sysregd instance controls the registry mount point for all processes
>>>>>>>> which belong to a single session, and also exports global information
>>>>>>>> about that session (all threads, all heaps etc). In short, it is in
>>>>>>>> charge of maintaining the fs hierarchy for one Xenomai session.
>>>>>>>>
>>>>>>>> Within the session, each process exports the active objects it knows
>>>>>>>> locally about also via a FUSE-based fs, rooted within the hierarchy
>>>>>>>> maintained by sysregd.
>>>>>>>>
>>>>>>>> In this discussion, we cannot assume a global sysregd instance dealing
>>>>>>>> with every possible export from every Xenomai process, that won't work.
>>>>>>>>
>>>>>>>
>>>>>>> Then how does the current single mount point (independent of its
>>>>>>> location and access rights) for all of those instances fit into this?
>>>>>>> Seems like they step on each other if you do not override the mount
>>>>>>> points on process invocation, right?
>>>>>>>
>>>>>>
>>>>>> Pid is used to discriminate within a session.
>>>>>> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#New_FUSE-based_registry_interface
>>>>>
>>>>> So a user not specifying a session name will collide with other users
>>>>> this way because they all compete for anon.
>>>>>
>>>>
>>>> Collide on what?
>>>
>>> Collide on managing the anon mount point. And everything that is stored
>>> underneath. No?
>>>
>>
>> A sysregd instance is started each time a new session emerges, and all
>> processes which belong to this session will refer to this instance
>> exclusively for managing the hierarchy. Anon is no different.
>>
>> Under the session mount point (e.g. "anon"), each process has its own
>> namespace. A shared branch in this hierarchy called /system is directly
>> attached to the session root, for all global objects shared by the session.
>>
>> The anon session makes no difference compared to others, it just happens
>> that random processes attached there don't share any object from the
>> session heap.
>>
>>> I'm thinking of the scenario that two unrelated but unnamed sessions are
>>> started, specifically by different users. In the worst case, user A
>>> starts off the sysregd for anon, B joins later and reuses it therfore,
>>> but then A decides to terminate all its processes, including the daemon.
>>>
>>
>> sysregd deals with such dependencies, A is not in charge of terminating
>> sysregd.
> 
> That is not the point. If the user (or the system) decides to kill all
> processes of it, it's dead. Also for user B. anon doesn't work well for
> the multi-user case. It should rather be "personalized", run in a
> per-user namespace.
> 

If the user decides to forcibly kill a central daemon it does not own,
which is not even attached its own process group anymore, then well, I'm
afraid any option will have a problem. The same way, a client process
running FUSE services won't kill the thread that serves the FUSE
requests internally.

So no, this failure scenario makes no sense. It is no different than
asking sysregd to be resilient to machine shutdown.

>>
>>> Either the concept is truly multi-user capable, or we can go back to
>>> managing the registry daemons centrally.
>>
>> How do we do this in the Mercury case where we don't want to depend on
>> any kernel add-on/driver for exposing internal process data, but we do
>> want to expose it through a file system? In addition, how do we do this
>> without copying data around?
> 
> This has nothing to do with kernel extensions. It's a matter of managing
> central user space daemons for shared services - like shared sessions.
> 

I noticed that you did not care about answering my basic questions about
your proposed design. The implementation is there, and works as
advertised, including for "anon". Nothing more than advertised, nothing
less. And of course, yes it does make a lot of sense to ask about the
intervention of some central code in the kernel or not. You seem to be
Cobalt-centric in your reasoning: fair enough, but the same
implementation has to work when we don't provide any kernel bits too.

I understand you are looking for a killer argument to make your point
about changing /mnt to /var/run, which seems to imply now that you would
want the entire registry to be rewritten, for the sake of making your
argument fly.

If you think sysregd is badly designed or implemented after actual
testing, please come with facts, but doing so in a separate discussion
would likely have more impact.

-- 
Philippe.

