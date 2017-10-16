References: <CAKJ14NfjG5uVNEdmxPhqU39V3ADdnC9yCq+4eU7dov2aRixohQ@mail.gmail.com>
 <b68c5417-304d-52f1-5a00-9aaa93d6b195@xenomai.org>
From: Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>
Message-ID: <0a9d40a2-f9e2-170e-6f67-fec3c15eaf85@basystemes.fr>
Date: Mon, 16 Oct 2017 17:11:11 +0200
MIME-Version: 1.0
In-Reply-To: <b68c5417-304d-52f1-5a00-9aaa93d6b195@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] Xenomai and libunwind on ARM Cortex A9
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Le 04/10/2017 à 10:54, Philippe Gerum a écrit :
> On 10/03/2017 01:49 PM, Andreas Glatz wrote:
>> Hi
>>
>> I implemented the debug signal handle SIGXCPU as described in the
>> Xenomai documentation. The glibc function backtrace() returns
>> backtraces, but they often are very short (they typically end at the
>> signal (restore) handler, and don't show the function which caused the
>> SIGXCPU in the first place).
> Mm, ok. I did not observe this issue so far. This said, I'm not
> routinely using the feature.
We have the same issue on ARM Cortex A9. Backtraces are complete when 
the signal does not come from xenomai. They end at the signal handler 
(__default_rt_sa_restorer) for xenomai SIGXCPU signal.
Maybe it has something to do with unwind-tables on ARM.

>
>> I found libunwind, which is preloaded before starting our application
>> and replaces the glibc backtrace handler with unw_backtrace(). This
>> works fine most of the time.
>>
>> Recently, I discovered that the application crashes with SIGSEGV
>> during startup when quite a few SIGXCPUs occur in short succession
>> according to the gdb trace. Everything seems to work fine when
>> switching back to the glibc backtrace() function though. Now I'm
>> wordering if unw_backtrace() is actually not (Xenomai) thread-save.
>> Has anyone seen this before [or any other clues]?
>>
> No alternate signal stack is used for SIGXCPU by libcobalt, the handler
> always runs over the preempted thread's stack. The usual suspect would
> be a stack overflow experienced by the receiving thread. Does libunwind
> consume significantly more stackspace than glibc's backtrace()? Any
> change after increasing the stack space for application threads?
>


