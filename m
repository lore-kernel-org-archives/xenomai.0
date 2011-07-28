Message-ID: <4E3191DD.7060307@domain.hid>
Date: Thu, 28 Jul 2011 18:44:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E2527B2.3030305@domain.hid> <4E305C93.6010000@domain.hid>
In-Reply-To: <4E305C93.6010000@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] [RFC] Fixes for domain migration races
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-07-27 20:44, Gilles Chanteperdrix wrote:
> On 07/19/2011 08:44 AM, Jan Kiszka wrote:
>> Hi,
>>
>> I've just uploaded my upstream queue that mostly deals with the various
>> races I found in the domain migration code.
>>
>> One of my concerns raised earlier turned out to be for no reason: We do
>> not allow Linux to wake up a task that has TASK_ATOMICSWITCH set. So the
>> deletion race can indeed be fixed by the patch I sent earlier.
> 
> So, I still have the same question: is not the solution of synchronizing
> with the gatekeeper as soon as we get out from schedule in secondary
> mode better than waiting the task_exit callback? It looks more correct,
> and it avoids gksched.

Yes, I was on the wrong track /wrt wakeup races during the early
migration phase.

It is a possible and valid scenario that the task returns from
schedule() without being migrated. That can only happen if a signal was
queued in the meantime. The task will not be woken up again, that is
prevented by ATOMICSWITCH, but it will check for pending signals itself
before falling asleep. In that case it will enter TASK_RUNNING again and
return either before the gatekeeper could run or, on SMP, may continue
in parallel on a different CPU.

What saves us now from the fatal scenario that both the task runs and
the gatekeeper resumes its Xenomai part is that TASK_INTERRUPTIBLE state
was left. And if we wait for the gatekeeper to realize this like you
suggested, we ensure that neither the object is deleted too early nor
TASK_INTERRUPTIBLE is reentered again by doing Linux work.

I've cleaned up my queue correspondingly and just pushed it.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

