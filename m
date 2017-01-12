References: <20170110160757.5eb8ccee@md1em3qc>
 <406ae4f5-885c-c624-0b7a-ece67c553b14@xenomai.org>
 <20170111154759.228693f3@md1em3qc> <20170112183231.12bf8d56@md1em3qc>
 <9ecf1bb8-5633-1fdf-bf6e-afd8de03ab21@xenomai.org>
 <20170112193358.78490347@md1em3qc>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ac5a31a2-9373-b581-33d7-ba05d040d5fd@siemens.com>
Date: Thu, 12 Jan 2017 21:27:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170112193358.78490347@md1em3qc>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai 2 LDFLAGS wrappers, posix only
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2017-01-12 19:33, Henning Schild wrote:
> Am Thu, 12 Jan 2017 18:54:56 +0100
> schrieb Philippe Gerum <rpm@xenomai.org>:
> 
>> On 01/12/2017 06:32 PM, Henning Schild wrote:
>>> Am Wed, 11 Jan 2017 15:47:59 +0100
>>> schrieb Henning Schild <henning.schild@siemens.com>:
>>>   
>>>> Am Wed, 11 Jan 2017 12:03:23 +0100
>>>> schrieb Philippe Gerum <rpm@xenomai.org>:
>>>>  
>>>>> On 01/10/2017 04:07 PM, Henning Schild wrote:    
>>>>>> Hi,
>>>>>>
>>>>>> i am about to include three more wrappers into xenomai2 to
>>>>>> assert_nrt, later i plan to create a xenomai3 patch as well. The
>>>>>> functions to wrap are __cxa_guard_(acquire|release|abort). They
>>>>>> contain mutexes protecting the initialization state of static
>>>>>> objects in c++ code, often found when people implement the
>>>>>> singleton pattern.
>>>>>>
>>>>>> I have got the wrapping code but found that xeno-config will
>>>>>> create the wrapping LDFLAGS only for the posix skin. Is that
>>>>>> intentional or an inconsistency?
>>>>>> Even the wrappers in the "common" skin get applied for posix
>>>>>> only.
>>>>>>
>>>>>> I tried calling malloc/free in a "--skin=native" example and did
>>>>>> not get the SIGXCPU.
>>>>>>
>>>>>> Now i am guessing that the way wrappers are applied in xenomai2
>>>>>> is somehow inconsistent. Is that something that should be fixed
>>>>>> by having common and per skin wrappers, or would it be ok to
>>>>>> simply always append the posix LDFLAGS as well?      
>>>>>
>>>>> --posix is supposed to be passed only when a wrapping is expected.
>>>>> Omitting it allows to build apps over non-POSIX Xenomai APIs,
>>>>> while assuming that any POSIX call also present in the code can
>>>>> only be obtained from the glibc.    
>>>>
>>>> Ok i see. Just adding the --posix all the time would change the
>>>> implementation of all the pthread_* stuff where the developer might
>>>> just want to use non-rt pthreads.
>>>>
>>>> There seem to be two classes of wrappers. Those that just
>>>> assert_nrt() and do not change the implementation of the function
>>>> to be called. And the other class actually replaces the original
>>>> implementation.
>>>>
>>>> The ones that just insert the assert_nrt() are relevant for all
>>>> skins and should be applied there, while at the moment they are
>>>> only used for posix/rtdm.
>>>>
>>>> For xenomai3 that is malloc and free
>>>> (./lib/cobalt/assert_context.c), for xenomai2 it is those two plus
>>>> gettimeofday (src/skins/common/assert_context.c). These should be
>>>> wrapped in any skin, not just posix.  
>>
>> Is this requirement to wrap gettimeofday() on v2 a LART for preventing
>> deadlocks with the read_seqcount construct in kernel space?
> 
> I do not know why it is in there.
> 

>From the original commit message of my patch back then (I do not find
this in git, though, but it's in xenomai-core archives):

"Provide assert_nrt helper that checks if the caller is either not a
shadow thread or is currently running in relaxed mode. If not, SIG_XCPU
is raised.

This service is then used to provide wrappers for glibc functions that
are not realtime-safe but do not always trigger a syscall. Such
functions may therefore be used by RT threads in primary mode for quite
a while without being detected via some Xenomai mode switch. Moreover,
some functions that go through the vsyscall page even to raise an
ordinary syscall may not allow proper stack backtraces, making it harder
to find their callers.

So far we provide wrappers (for use with the --wrap linker switch) for
malloc/free, gettimeofday and clock_gettime. Adding more (if there
are/will be more) is trivial."

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

