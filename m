Subject: Re: Still getting Deadlocks with condition variables
References: <VI1PR05MB59177F9BC5CD74A181467003F6860@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <260342fe-450f-a30b-72c2-751961bc28dd@xenomai.org>
 <VI1PR05MB5917E09F83A6B78BC1798287F6850@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <4f24ced8-5317-3520-70e7-1c2e2dd24603@xenomai.org>
 <VI1PR05MB591734315C0968D56FAEE846F6820@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <22d9c328-440a-b167-c8ff-f05611d7c226@xenomai.org>
 <DB8PR05MB591551136A95F1D4B488C9C4F69C0@DB8PR05MB5915.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <85e376b0-fb2d-e05f-6cc3-aa1632de294d@xenomai.org>
Date: Mon, 15 Jun 2020 12:02:56 +0200
MIME-Version: 1.0
In-Reply-To: <DB8PR05MB591551136A95F1D4B488C9C4F69C0@DB8PR05MB5915.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, "'jan.kiszka@siemens.com'" <jan.kiszka@siemens.com>

On 6/15/20 11:06 AM, Lange Norbert wrote:
>>
>> This code does not take away any protection, on the contrary this ensures
>> that
>> PROT_EXEC is set for all stacks along with read and write access, which is
>> glibc's default for the x86_64 architecture.
> 
> I meant that it might have to do some non-atomic procedure, for example
> when splitting up a continuous bigger mapping with the stack in the middle,
> as the protection flags are now different.
>

We are talking about mprotect(), not mmap().

>> The fault is likely due to mm code fixing up those protections for the
>> relevant page(s). It looks like such pages are force faulted-in, which would
>> explain the #PF, and the SIGXCPU notification as a consequence. These are
>> minor faults in the MMU management sense, so this is transparent for
>> common applications.
> 
> I don’t know enough about the x86 (and don’t want to know), but this needs some
> explanation. First, the DSOs don’t need executable stack
> (build system did not care to add the .note.GNU-stack everywhere ), so this specific issue
> can be worked around.
> 
> -   I don’t understand why this is very timing sensitive, If page is marked to #PF (or removed)
>     Then this should fault predictable on the next access (I don’t share data on stack that Linux threads could run into an #PF instead)

Faulting is what it does. It is predictable and synchronous, you seem to be
assuming that the fault is somehow async or proxied, it is not.

> -   If that’s a non-atomic operation (perhaps only if the sparse tables need modification in a higher level), then I would expect
>     some sort of lazy locking (RCU?). Is this ending up in chaos as cores running Xenomai are "idle" for Linux, and pick up outdated data?

I have no idea why you would bring up RCU in this picture, there is no
convoluted aspect in what happens. There is no chaos, only a plain simple #PF
event which unfortunately occurs as a result of running an apparently
innocuous regular operation which is loading a DSO. The reason for the #PF can
be explained, how it is dealt with is fine, the rt loop in your app just does
not like observing it for a legitimate reason.

> -   Are/can such minor faults be handled in Xenomai? In other words is the WARNSW correct, or is
>     this actually just the check causing the issues?
>     Would it make sense to handle such minor faults in Xenomai (only demoting to Linux if necessary)?
> 
>> Not for those of us who do not want the application code to run
>> into any page fault unfortunately.
>>
>> Loading DSOs while the real-time system is running just proved to be a bad
>> idea it seems (did not check how other *libc implementations behave on
>> dlopen() though).
> 
> glibc dlopens files on its own BTW, for nss plugins and encodings. Practically than means
> you would need to check everything running (in non-rt threads), for dlopen and various
> calls that could resolve names to uid/gid, do dns lookups, use iconv etc.
> 

The glibc is fortunately not dlopening DSOs at every corner. You mention very
specific features that would have to take place during the app init chores
instead, or at the very least in a way which is synchronized with a quiescent
state of the rt portion of the process.

> This is an issue of changing protection on existing mappings, or the mmap call in broader terms.

This is an issue with some of mprotect() side-effects.

> Knowing why and under what circumstances this causes trouble would be rather important
> (would have been important some years ago when we *started* porting to Xenomai and picked solutions).
> 

I believe the whole thread has already framed the how and why fairly
precisely. With respect to knowing those things in advance, I can only
recommend that people who based their project on Xenomai over the past 15
years share their knowledge and experience by contributing documentation and
participating to the mailing list.

> I could for ex. expect the kernel option CONFIG_COMPACTION causing similar issues (and pretty impossible to triage).
> 

CONFIG_COMPACTION is a known source of latency spots, just like transparent
huge pages are not going to be helpful, regardless of the underlying rt
infrastructure.

To sum up what we have all been saying, the problem is not about causing a PTE
miss due to mprotect() altering permissions on pages, but how we can handle
the minor fault from primary mode. On arm, arm64 and ppc, such fault can be
handled directly from primary mode. On x86, the inner MMU code which is in
charge of handling faults does not allow that, there is the need for switching
to secondary mode.

Regarding handling PTE misses directly from primary mode, this would be a mess
with x86: sharing the MMU management logic between Cobalt and the regular
linux mm sub-system which otherwise run totally asynchronously is something I
for one won't even try.

Without Xenomai, you would take a fault the same way, the difference is that
with Xenomai, the WARNSW notifier tells you so, issuing a signal, which may be
triggering a separate issue with condvars.

-- 
Philippe.

