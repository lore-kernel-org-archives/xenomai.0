References: <fbe65e53-a837-9c38-5ce3-bf26d773fe6e@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2] dovetail: Adjust EXIT_SYSCALL_* values to avoid
 clash with seccomp
Date: Sun, 14 Nov 2021 12:16:49 +0100
In-reply-to: <fbe65e53-a837-9c38-5ce3-bf26d773fe6e@siemens.com>
Message-ID: <87czn3ng0p.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> __secure_computing, called by syscall_trace_enter, returns -1 when a
> call should be skipped. We must avoid that this is interpreted as
> EXIT_SYSCALL_OOB in the dovetail case.
>
> Fixes, e.g., crashes of Chrome in sandbox mode.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/linux/entry-common.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 2a08b00632b9..26a89e869f3c 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -64,10 +64,11 @@
>  
>  /*
>   * Status codes of syscall entry when Dovetail is enabled. Must not
> - * conflict with valid syscall numbers.
> + * conflict with valid syscall numbers. And with -1 which seccomp uses
> + * to skip an syscall.
>   */
> -#define EXIT_SYSCALL_OOB	(-1)
> -#define EXIT_SYSCALL_TAIL	(-2)
> +#define EXIT_SYSCALL_OOB	(-2)
> +#define EXIT_SYSCALL_TAIL	(-3)
>  
>  /**
>   * arch_check_user_regs - Architecture specific sanity check for user mode regs

Merged, thanks.

-- 
Philippe.

