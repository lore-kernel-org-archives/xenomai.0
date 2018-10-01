References: <20181001135619.24883-1-rpm@xenomai.org>
 <0f37705c-cacc-2f70-b2d2-0b6473a1a456@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1a465605-22c8-c155-a79c-dfe728affdf2@xenomai.org>
Date: Mon, 1 Oct 2018 16:26:22 +0200
MIME-Version: 1.0
In-Reply-To: <0f37705c-cacc-2f70-b2d2-0b6473a1a456@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH 0/6] Cobalt fixes (CPU affinity handling,
 cyclictest)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 10/01/2018 04:05 PM, Jan Kiszka wrote:
> On 01.10.18 15:56, Philippe Gerum wrote:
>> This series mainly fixes CPU affinity issues when the set of rt CPUs
>> is restricted via xenomai.supported_cpus=<mask>, specifically:
>>
>> - handle user requests for domain migration to the head stage over
>>    non-rt CPUs gracefully. This builds on the I-pipe patch sent earlier:
>>
>>    sched/core: ipipe: do not panic on failed migration to the head stage
>>
>> - set the default CPU affinity for userland apps to the restricted CPU
>>    set if given on the kernel command line (instead of any
>>    CPU). Typically, running switchtest on a system with a restricted rt
>>    CPU set without passing --cpu-affinity should implicitly select
>>    available (rt) CPUs exclusively.
>>
>> As I have been running benchmarks lately, I fixed a bug in cyclictest
>> which caused weird latency results with long-running tests too.
>>
>> Philippe Gerum (6):
>>    demo/cyclictest: turn on FIFO mode by default, detecting spurious
>>      relaxes
>>    cobalt/thread: handle case of invalid domain migration over non-rt CPU
>>    cobalt/intr: IRQ affinity depends on xnsched_realtime_cpus
>>    cobalt/sched: fix mismatches between supported CPUs and affinity set
>>    boilerplate/setup: cobalt: retrieve the default CPU affinity
>>    demo/cyclictest: fix time delta calculation
>>
>>   demo/posix/cyclictest/cyclictest.c | 82
>> ++++++++++++++++++++++++++++++++------
>>   include/cobalt/kernel/sched.h      | 10 +++++
>>   kernel/cobalt/intr.c               |  2 +-
>>   kernel/cobalt/posix/process.c      | 21 ++++++----
>>   kernel/cobalt/posix/sched.c        |  2 +-
>>   kernel/cobalt/thread.c             |  1 +
>>   lib/boilerplate/setup.c            | 33 ++++++++++++++-
>>   7 files changed, 126 insertions(+), 25 deletions(-)
>>
> 
> Will have a look. Already noticed: missing signed-off. In the kernel
> community, this sometimes indicated "not yet for merge", but I suppose
> you just forgot them. If you confirm that and I have no other remarks, I
> can fix that up while merging.
> 

I confirm that I'm submitting this upstream, please fix.

-- 
Philippe.

