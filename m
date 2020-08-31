Subject: Re: Adivces on Xenomai-3.0.9 support linux-4.19.
References: <CAAvDm6Zx4oWB13b9g5_B-3M=AMCoPmcOu0FGrSOK_NPqtXjPUw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dc509fef-852f-55bb-94c6-890bdf704fc9@siemens.com>
Date: Mon, 31 Aug 2020 11:31:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6Zx4oWB13b9g5_B-3M=AMCoPmcOu0FGrSOK_NPqtXjPUw@mail.gmail.com>
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
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 31.08.20 11:17, 孙世龙 sunshilong via Xenomai wrote:
> Hi, list
> 
> Our project depends on Xenomai-3.0.9. And we can't upgrade it to
> Xenomai-3.1 indeed.
> 
> We want to make Xenomai-3.0.9 work on Linux-4.19
> (as far as I know, the latest version that it supports is Linux-4.14 and
> Xenomai-3.1 supports Linux-4.19).
> 
> Is it possible?
> Could you give me some advice on how to make Xenomai-3.0.9 work on Linux-4.19?
> 

It's doable with reasonable effort if you do not need RTnet drivers. 
Pick these from 3.1 (bottom first)

Replace sigset_to/from_compat with post 4.14 versions
kernel: cobalt: trace: replace dummy array with field
kernel: cobalt: forward SRCARCH from the scripts/prepare-kernel.sh
kernel: cobalt: use printk instead of print_symbol on v4.16 and later
kernel: cobalt: replace ACCESS_ONCE with READ_ONCE

and additionally patch

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 5bba5bc703..5710c13f1c 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2121,7 +2121,7 @@ void xnthread_relax(int notify, int reason)
 		suspension |= XNDBGSTOP;
 	}
 
-	set_task_state(p, p->state & ~TASK_NOWAKEUP);
+	set_current_state(p->state & ~TASK_NOWAKEUP);
 	xnthread_run_handler_stack(thread, relax_thread);
 	xnthread_suspend(thread, suspension, XN_INFINITE, XN_RELATIVE, NULL);
 	splnone();

I'm using this in local version as well. If things do not build, I might 
have missed some commit. Report the error then.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

