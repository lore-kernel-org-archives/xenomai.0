References: <529dd829-ca80-10f7-36f5-c1dcba403360@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bfdeba2c-bcc9-c18e-c73d-e8d4effdb95e@xenomai.org>
Date: Thu, 5 Apr 2018 17:08:18 +0200
MIME-Version: 1.0
In-Reply-To: <529dd829-ca80-10f7-36f5-c1dcba403360@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: fix preemption damage in hard_preempt_enable()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 04/05/2018 04:49 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> to assess the impact of the bug that the mentioned commit fixes, can you
> describe the code path that trigger it?
> 

e.g. in the rtnet stack, calling rtdev_get_by_name() on a PREEMPT
kernel, and a regular rescheduling pending at the time of the call.

rtdev_get_by_name()
      -> rtdm_lock_irqsave(...)
      -> rtdev_reference(...)
            -> try_module_get()
                  hard_preempt_disable(); /* hard IRQs were off */
                  ...
                  hard_preempt_enable();
                     -> hard_local_irq_restore() /* still off */
                     -> preempt_check_resched(); /* resched pending */
                           <<schedule() with hard IRQs off>>

This went unnoticed until I got some changes in creating a resched
opportunity right on spot...

-- 
Philippe.

