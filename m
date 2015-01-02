Message-ID: <54A6F202.3080307@xenomai.org>
Date: Fri, 02 Jan 2015 20:31:14 +0100
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
In-Reply-To: <54A6EE3B.3070909@web.de>
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

On 01/02/2015 08:15 PM, Jan Kiszka wrote:
> On 2015-01-02 20:20, Philippe Gerum wrote:
>> On 01/02/2015 07:09 PM, Jan Kiszka wrote:
>>> On 2015-01-02 19:07, Philippe Gerum wrote:
>>>> On 01/02/2015 04:59 PM, Jan Kiszka wrote:
>>>>> On 2015-01-02 16:06, Gilles Chanteperdrix wrote:
>>>>>> To explain a bit more completely. We can not assume that xenomai
>>>>>> applications are running as root user. And non root user are not
>>>>>> allowed to create /run/xenomai or /var/run/xenomai (at least not on
>>>>>> debian or slackware). What is more, these directories being
>>>>>> typically non persistent, a script has to be modified somewhere to
>>>>>> add mkdir /var/run/xenomai at every boot. On the other hand, mkdir
>>>>>> /mnt/xenomai has to be done once and only once, in the "make
>>>>>> install" phase for instance, since "make install" is run as root,
>>>>>> except that if /mnt is read-only it will not work. But not many
>>>>>> users are running system where they compile and run things with root
>>>>>> filesystem read-only. Anyway, the two cases are really similar, no
>>>>>> one is advantageous over the other. We are going to see questions on
>>>>>> the mailing list about that, whatever we do. Perhaps adding a small
>>>>>> kernel module to create /proc/xenomai/registry would make things
>>>>>> simpler...
>>>>>>
>>>>>
>>>>> Non-root users are indeed an interesting new aspect. However, the
>>>>> solution to make a central directory writable seems weird to me. If you
>>>>> want to allow non-root users to access the registry, it would be way
>>>>> more logical to either shoot up a single privileged sysregd that
>>>>> everyone can talk to or use private instances that also run against
>>>>> their own per-user mount points, likely located in $HOME.
>>>>>
>>>>
>>>> Technically, sysregd does not have access to all the registry data, I
>>>> mean not system-wide. The registry fs is a per-session resource based on
>>>> FUSE. In shared processing mode (--enable-pshared), any number of
>>>> processes may belong to a single session, forming one application.
>>>>
>>>> One sysregd instance controls the registry mount point for all processes
>>>> which belong to a single session, and also exports global information
>>>> about that session (all threads, all heaps etc). In short, it is in
>>>> charge of maintaining the fs hierarchy for one Xenomai session.
>>>>
>>>> Within the session, each process exports the active objects it knows
>>>> locally about also via a FUSE-based fs, rooted within the hierarchy
>>>> maintained by sysregd.
>>>>
>>>> In this discussion, we cannot assume a global sysregd instance dealing
>>>> with every possible export from every Xenomai process, that won't work.
>>>>
>>>
>>> Then how does the current single mount point (independent of its
>>> location and access rights) for all of those instances fit into this?
>>> Seems like they step on each other if you do not override the mount
>>> points on process invocation, right?
>>>
>>
>> Pid is used to discriminate within a session.
>> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#New_FUSE-based_registry_interface
> 
> So a user not specifying a session name will collide with other users
> this way because they all compete for anon.
> 

Collide on what?


-- 
Philippe.

