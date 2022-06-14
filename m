References: <PH1P110MB1050824464C7A004168828B9E2AA9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <ff60d210-0e25-72aa-2820-8e30fc4565c9@siemens.com>
 <871qvrqnf8.fsf@xenomai.org>
 <PH1P110MB10500F3E0FC8A4E382890559E2AA9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [External] - Re: <evl/heap.h> compile conflict with Boost
Date: Tue, 14 Jun 2022 18:06:48 +0200
In-reply-to: <PH1P110MB10500F3E0FC8A4E382890559E2AA9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87k09ipdkk.fsf@xenomai.org>
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
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Apologies. Here you go.
>
> From 452e8b2ca8ecd53571a6b1f5d8b9ab23cd67f99d Mon Sep 17 00:00:00 2001
> From: Russell Johnson <russell.johnson@kratosdefense.com>
> Date: Tue, 14 Jun 2022 08:10:14 -0600
> Subject: [PATCH] fixing conflict with C++ [[fallthough]], and maybe at some
>  point in the future with the C2X standard
>
> Signed-off-by: Russell Johnson <russell.johnson@kratosdefense.com>
> ---
>  benchmarks/hectic.c    | 10 +++++-----
>  benchmarks/latmus.c    |  4 ++--
>  include/evl/compiler.h |  2 +-
>  lib/thread.c           |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/benchmarks/hectic.c b/benchmarks/hectic.c
> index 6b6b3b5..886f7d2 100644
> --- a/benchmarks/hectic.c
> +++ b/benchmarks/hectic.c
> @@ -336,7 +336,7 @@ static void *sleeper_switcher(void *cookie)
>                         break;
>                 case 1:
>                         handle_bad_fpreg(param->cpu, ~0, -1);
> -                       fallthrough;
> +                       __fallthrough;
>                 case -1:
>                         clean_exit(EXIT_FAILURE);
>                 }
> @@ -469,7 +469,7 @@ static void *rtup(void *cookie)
>                         break;
>                 case 1:
>                         handle_bad_fpreg(param->cpu, ~0, -1);
> -                       fallthrough;
> +                       __fallthrough;
>                 case -1:
>                         clean_exit(EXIT_FAILURE);
>                 }
> @@ -549,7 +549,7 @@ static void *rtus(void *cookie)
>                         break;
>                 case 1:
>                         handle_bad_fpreg(param->cpu, ~0, -1);
> -                       fallthrough;
> +                       __fallthrough;
>                 case -1:
>                         clean_exit(EXIT_FAILURE);
>                 }
> @@ -646,7 +646,7 @@ static void *rtuo(void *cookie)
>                         break;
>                 case 1:
>                         handle_bad_fpreg(param->cpu, ~0, -1);
> -                       fallthrough;
> +                       __fallthrough;
>                 case -1:
>                         clean_exit(EXIT_FAILURE);
>                 }
> @@ -811,7 +811,7 @@ static int task_create(struct cpu_tasks *cpu,
>         case RTUS:
>         case RTUO:
>                 param->swt.flags = HECTIC_OOB_WAIT;
> -               fallthrough;
> +               __fallthrough;
>         case SLEEPER:
>         case SWITCHER:
>                 err = ioctl(cpu->fd, EVL_HECIOC_REGISTER_UTASK,
> &param->swt);
> diff --git a/benchmarks/latmus.c b/benchmarks/latmus.c
> index a507e80..59ed448 100644
> --- a/benchmarks/latmus.c
> +++ b/benchmarks/latmus.c
> @@ -1252,10 +1252,10 @@ int main(int argc, char *const argv[])
>                         switch (*endptr) {
>                         case 'd':
>                                 timeout *= 24;
> -                               fallthrough;
> +                               __fallthrough;
>                         case 'h':
>                                 timeout *= 60;
> -                               fallthrough;
> +                               __fallthrough;
>                         case 'm':
>                                 timeout *= 60;
>                                 break;
> diff --git a/include/evl/compiler.h b/include/evl/compiler.h
> index fce2766..8e6ad8c 100644
> --- a/include/evl/compiler.h
> +++ b/include/evl/compiler.h
> @@ -61,7 +61,7 @@
>  #endif
>
>  #ifndef __fallthrough
> -#define fallthrough    __attribute__((__fallthrough__))
> +#define __fallthrough  __attribute__((__fallthrough__))
>  #endif
>
>  #ifndef __alloc_size
> diff --git a/lib/thread.c b/lib/thread.c
> index 4b836cc..dc2ca6c 100644
> --- a/lib/thread.c
> +++ b/lib/thread.c
> @@ -111,7 +111,7 @@ int evl_attach_thread(int flags, const char *fmt, ...)
>                 break;
>         default:
>                 policy = SCHED_FIFO;
> -               fallthrough;
> +               __fallthrough;
>         case SCHED_FIFO:
>         case SCHED_RR:
>                 priority = param.sched_priority;

Merged, thanks.

-- 
Philippe.

