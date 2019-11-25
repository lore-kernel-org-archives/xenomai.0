Subject: Re: [PATCH v2 3/7] cobalt/posix: fix missed rescheduling opportunities
References: <20191124154608.9353-1-rpm@xenomai.org>
 <20191124154608.9353-3-rpm@xenomai.org>
 <59725ae2-796c-d065-7646-2d6382916519@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b70a9a8a-c158-8e6d-29a3-ad43e570c8af@xenomai.org>
Date: Mon, 25 Nov 2019 11:09:04 +0100
MIME-Version: 1.0
In-Reply-To: <59725ae2-796c-d065-7646-2d6382916519@siemens.com>
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

On 11/25/19 10:09 AM, Jan Kiszka wrote:
> On 24.11.19 16:46, Philippe Gerum via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> stop_debugged_thread() may suspend threads running on a remote CPU, we
>> have to kick the rescheduling procedure for these changes to take
>> effect asap. Make sure xnsched_run() is kicked from the call sites
>> once they are done updating the scheduler state.
>>
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>   kernel/cobalt/posix/process.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
>> index b90e53507..1e003108e 100644
>> --- a/kernel/cobalt/posix/process.c
>> +++ b/kernel/cobalt/posix/process.c
>> @@ -819,6 +819,7 @@ static inline int handle_exception(struct ipipe_trap_data *d)
>>           }
>>           stop_debugged_process(thread);
>>           xnlock_put_irqrestore(&nklock, s);
>> +        xnsched_run();
> 
> To reduce the potential (but unavoidable) delay between the exception and the remote thread stops, shouldn't this move under the lock? For the wakeup, we do this below.
> 

That is not necessary. We can't be preempted by the regular kernel logic in this routine since we are running over the head stage, so the only possible preemption would come from a Cobalt interrupt, which would imply that the rescheduling procedure was kicked even earlier (in order to switch us out) and the pending IPIs would have already been sent as a result of this.

-- 
Philippe.

