Subject: Re: question about ipipe
References: <9112bf0c-edb0-b162-100d-c425353f02b3@siemens.com>
 <e365126f-c53a-1d42-752d-2b10d43cdaeb@xenomai.org>
 <c9ab7a3e-3aa4-1bcd-2390-a2e219eb5f1d@linx-info.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f3782031-9a21-4ece-efd4-57de49f58251@siemens.com>
Date: Fri, 18 Oct 2019 12:21:35 +0200
MIME-Version: 1.0
In-Reply-To: <c9ab7a3e-3aa4-1bcd-2390-a2e219eb5f1d@linx-info.com>
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
To: duanwujie <wjduan@linx-info.com>, xenomai@xenomai.org

Please do not reply to unrelated threads when starting a new topic.

On 18.10.19 02:54, duanwujie via Xenomai wrote:
> In the ipipe  some local_irq_enable will be replace by
> enable_local_irqs, some are not。

enable_local_irqs is a macro local to arch/x86/entry/common.c.
Generally, the replacement is hard_local_irq_...

> 
> how to determine whether it needs to be replaced ?　Is there any document ?
> 

At this level, we do not have documents. The common reasons to "harden"
interrupts disabling over I-pipe are:

 - sharing of basic hardware resources with Linux, e.g. interrupt
   controllers and timers
 - common code paths in context setting or switching, specifically
   around MMU and FPU
 - sensitive exception, interrupt and syscall entry/exit paths

And then there some special cases, like

 - tracing
 - KVM preemption

HTH,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

