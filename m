Subject: Re: [PATCH v2 7/7] cobalt/sched: restrict rescheduling hints to
 migration-safe context
References: <20191124154608.9353-1-rpm@xenomai.org>
 <20191124154608.9353-7-rpm@xenomai.org>
 <84756ec0-56b6-e781-9693-aeebf06b6cbc@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8a9bc424-96d3-b0a7-f1c5-8f8e2eb3701c@siemens.com>
Date: Mon, 25 Nov 2019 11:55:56 +0100
MIME-Version: 1.0
In-Reply-To: <84756ec0-56b6-e781-9693-aeebf06b6cbc@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 25.11.19 11:40, Philippe Gerum via Xenomai wrote:
> On 11/24/19 4:46 PM, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> XNINIRQ, XNINSW and XNSCHED are quick hints loaded from per-cpu data
>> which are considered by the main rescheduling call (xnsched_run()) to
>> figure out whether the actual rescheduling backend (___xnsched_run())
>> should actually run immediately, or be postponed to a later call.
>>
>> In seldom cases, we might call xnsched_run() from the root thread with
>> hard irqs enabled.  Because such requests also depend on those hints,
>> they are sensitive to CPU migration. The changes address this issue,
>> considering that such requests can be forwarded to ___xnsched_run()
>> directly - ignoring the hints - because the following premises apply
>> in this case:
>>
> 
> Please drop this patch, it still does not solve the main issue which is that we might lose a rescheduling opportunity over the root stage in case of a CPU migration, e.g.:
> 
> CPU0                            CPU1
> ----                            ----
> 
> xnthread_resume/suspend(T)
> <CPU migration>
>                                  xnsched_run()
>                                      |
>                                      |
>                                      v
>                            would only apply to rq(CPU1), missing updates to rq(CPU0)
> 
> To fix this, I don't see any other (sane) way than requiring all calls to xnsched_run() over the root stage to happen within an atomic section shared with the wakeup/suspend signal. Those cases should be few anyway, so a reasonable way of dealing with this issue would be to add an assertion to xnsched_run(), which should trigger upon migration-unsafe calling contexts, and fix a couple of call sites in the core.
> 

OK, simpler is better anyway.

I would then suggest to clean up via patch 6 in the very same run, to 
provide that commit a context.

Applying up to patch 5 to next now.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

