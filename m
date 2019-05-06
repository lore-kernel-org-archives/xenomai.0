Subject: Re: rtdm_task_init vs. supported_cpus
References: <e57c2c94-b593-ecee-6108-097929a96ee7@siemens.com>
 <3c94ecae-88ac-0b1b-0d06-153a5107cbb8@xenomai.org>
 <ea10faa0-c4ff-5a04-87ea-755065d5a367@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <37ee0011-3bc1-ca42-fbee-ddfbd4dafcfe@xenomai.org>
Date: Mon, 6 May 2019 18:35:12 +0200
MIME-Version: 1.0
In-Reply-To: <ea10faa0-c4ff-5a04-87ea-755065d5a367@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 5/6/19 6:03 PM, Jan Kiszka wrote:
> On 06.05.19 17:11, Philippe Gerum wrote:
>> On 5/6/19 5:02 PM, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> while playing with maxcpus on x86, I ran into one issue again that I
>>> think I saw already but forgot to dig into back then: When an RTDM
>>> driver happens to create a kernel task (rtdm_task_init) on a support
>>> outside of xenomai.supported_cpus, we will crash. That may happen
>>> because that command is run over module_init, or any other context that
>>> is not a Xenomai-blessed Linux task with therefore constraint affinity
>>> mask.
> 
> More precisely: You had to boot with maxcpus < existing CPUs as well. I
> that case, the core would not initialize its internal per-cpu data
> structures (specifically nksched) for the initially offlined CPUs, and
> running xnthread_start over them later on will cause that crash.
> 
>>>
>>> Any suggestions how to resolve that best? Restrict the affinity of the
>>> rtdm_task_init caller? Permanently or maybe just temporarily? Or is
>>> there some way to resolve that deeper inside xnthread_* APIs?
>>>
>>
>> xnthread_pin_initial() may help.
>>
> 
> It does, because of the contained set_cpus_allowed_ptr(). It's basically
> that permanent mask adjustment of the caller I mentioned above. The use
> case for xnthread_pin_initial is cobalt_map_user() where the target
> xnthread is corresponding to the current task and caller. Here we are
> over a separate, pure Linux task. I guess it's safer (/wrt unknown
> callers) to restore current's affinity after xnthread_start().
> 

The cleanest way would likely involve phasing out xnthread_start()
entirely. This is a relic from the ancient times when the 2.6 nucleus
would create non-linux kernel threads, which could emerge in dormant
and/or suspended state. I see no valid use case for this stuff anymore.

-- 
Philippe.

