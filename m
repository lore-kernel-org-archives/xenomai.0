Subject: Re: [RFC][PATCH 0/7] Make debugging more deterministic
References: <cover.1543608201.git.jan.kiszka@siemens.com>
 <62c913ba-9ff7-4719-ecb5-aa8e83c24625@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ac36f2e8-9632-f0f0-ce82-1888150e7c03@siemens.com>
Date: Tue, 4 Jun 2019 19:35:13 +0200
MIME-Version: 1.0
In-Reply-To: <62c913ba-9ff7-4719-ecb5-aa8e83c24625@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 03.06.19 19:26, Philippe Gerum via Xenomai wrote:
> On 11/30/18 9:03 PM, Jan Kiszka wrote:
>> These patches are sticking in my queue for more than 3 years now which
>> is bad. The good thing is that they were able to mature, at least on
>> x86, over that time because we are actually using them.
>>
>> Two issues are addressed with these changes:
>>
>> 1. Ensure that threads that were stopped for debugging in primary mode
>>     will also be resumed in that mode. This prevents deviating behavior
>>     compared to non-debugged execution.
>>
>> 2. If one thread in a process hits a debugging condition and is about to
>>     bring the whole process into stopped state, ensure that all other RT
>>     threads are stopped immediately. This prevents that, because the
>>     interrupted thread first needs to go to Linux in order to start the
>>     process stop, other threads can continue running too far, changing
>>     the process state so that debugging becomes harder if not impossible.
>>
>> To provide these properties, the core needs two small new hooks from
>> I-pipe. Separate patches will be sent against 4.14 that provide these,
>> so far for x86 and ARM only.
>>
>> Furthermore, this series likely depends on the mayday cleanup I sent
>> earlier, at least it was never used without that (you don't want to
>> debug without it). That also raises the question how to manage the
>> I-pipe feature dependencies best in order work around or simply exclude
>> old I-pipe releases.
>>
>> Please review carefully if the design and implementation make sense. As
>> I said, we are using it, so it is not completely broken. But I may have
>> overseen some ugly corner cases nevertheless.
>>
>> Unless too many issues surface, I would like to get this feature into
>> master before 3.1, along with the needed hooks in I-pipe (including
>> active stable trees).
>>
>> Jan
>>
>> Jan Kiszka (7):
>>    cobalt/kernel: Rework register/unregister_debugged_thread
>>    cobalt/kernel: Switch back ptraced primary mode threads on resume
>>    cobalt/kernel: Reintroduce process-local thread list
>>    cobalt/kernel: Introduce XNDBGSTOP
>>    cobalt/kernel: Implement synchronous stop and resume for process
>>      debugging
>>    cobalt/kernel: Clear mayday request of relaxed task
>>    testsuite/smokey: gdb-based debugging test
>>
>>   configure.ac                        |   1 +
>>   include/cobalt/kernel/thread.h      |   2 +-
>>   include/cobalt/uapi/kernel/thread.h |   5 +-
>>   kernel/cobalt/posix/process.c       | 218 ++++++++++++++++++++++++-
>>   kernel/cobalt/posix/process.h       |   4 +-
>>   kernel/cobalt/posix/thread.c        |   4 +-
>>   kernel/cobalt/posix/thread.h        |   2 +-
>>   kernel/cobalt/thread.c              |  18 ++-
>>   testsuite/smokey/Makefile.am        |   1 +
>>   testsuite/smokey/gdb/Makefile.am    |  13 ++
>>   testsuite/smokey/gdb/gdb.c          | 310 ++++++++++++++++++++++++++++++++++++
>>   11 files changed, 564 insertions(+), 14 deletions(-)
>>   create mode 100644 testsuite/smokey/gdb/Makefile.am
>>   create mode 100644 testsuite/smokey/gdb/gdb.c
>>
> 
> Ack. The pipeline related bits are in -noarch already.
> 

Thanks for the review. Rebased (was clean) and applied to next now.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

