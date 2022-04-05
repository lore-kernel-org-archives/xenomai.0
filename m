Message-ID: <965edc40-6bae-fd91-331e-b1e59bf61a84@siemens.com>
Date: Tue, 5 Apr 2022 18:01:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] xnthread_relax: Make sure wakework irq work has a stack
Content-Language: en-US
References: <20220405114052.7385-1-richard@nod.at>
 <94940f791d07b0f2e4f8594b26aa47680a024d0b.camel@siemens.com>
 <CAFLxGvzdJYiVd+ZsQ++PPcd_P1ajdDPgWe0Tpko0JAo3G5rb_A@mail.gmail.com>
 <54aa3260-9a9b-dbdb-90a8-6395fd86fc28@siemens.com>
 <1433861802.219536.1649174000463.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1433861802.219536.1649174000463.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai <xenomai@xenomai.org>

On 05.04.22 17:53, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> I would like to have an explanation or prove points (traces, assertions)
>> that we actually see xnthread_relax overtaking the delivery of its own
>> wakework.
> 
> I can re-test with something like that:
> 
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index beda67e18..4c100b645 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -2159,6 +2159,7 @@ void xnthread_relax(int notify, int reason)
>         pipeline_clear_mayday();
>  
>         trace_cobalt_shadow_relaxed(thread);
> +       WARN_ON_ONCE(irq_work_is_busy(&wakework.inband_work.work));
>  }
>  EXPORT_SYMBOL_GPL(xnthread_relax);
> 
> But I fear this might take some time. The KASAM spat happened only once
> and also only after the test ran for almost 5 days.

How about additionally widening the suspected race window by adding a
delay to lostage_task_wakeup?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

