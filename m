Subject: Re: [PATCH 3/7] cobalt/posix: fix missed rescheduling opportunities
References: <20191122171949.18021-1-rpm@xenomai.org>
 <20191122171949.18021-4-rpm@xenomai.org>
 <1c860027-1d24-3aa9-4a6b-cdd7ed3142e6@siemens.com>
 <c17ad5d4-e8c4-ad1b-911e-2d2597aea0d0@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <05bd0a71-d076-cf43-d379-4b498f1b50dd@xenomai.org>
Date: Fri, 22 Nov 2019 18:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <c17ad5d4-e8c4-ad1b-911e-2d2597aea0d0@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 11/22/19 6:53 PM, Philippe Gerum via Xenomai wrote:
> On 11/22/19 6:42 PM, Jan Kiszka wrote:
>> On 22.11.19 18:19, Philippe Gerum via Xenomai wrote:
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> stop_debugged_thread() may suspend threads running on a remote CPU, we
>>> have to kick the rescheduling procedure for these changes to take
>>> effect asap. Make sure xnsched_run() is kicked from the call sites
>>> once they are done updating the scheduler state.
>>>
>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>> ---
>>>   kernel/cobalt/posix/process.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
>>> index b90e53507..1e003108e 100644
>>> --- a/kernel/cobalt/posix/process.c
>>> +++ b/kernel/cobalt/posix/process.c
>>> @@ -819,6 +819,7 @@ static inline int handle_exception(struct ipipe_trap_data *d)
>>>           }
>>>           stop_debugged_process(thread);
>>>           xnlock_put_irqrestore(&nklock, s);
>>> +        xnsched_run();
>>
>> How does this help with threads on remote CPUs? xnsched_run deals with xnsched_current only, no?
>>
> 
> This forces the propagation of the remote IPI, which has to happen from the local one.
> 

i.e. xnsched_run -> __xnsched_run() passes the need resched check because XNSCHED is marked in xnsched_current()->lflags. As a consequence of the latter, ___xnsched_run() is allowed to run, ending up in test_resched() kicking the pending IPIs according to prior changes to the remote runqueues from the local CPU.

-- 
Philippe.

