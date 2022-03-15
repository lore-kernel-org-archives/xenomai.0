MIME-Version: 1.0
References: <8ba9c2e5-70dc-8e81-2ebd-b038e539f954@siemens.com>
In-Reply-To: <8ba9c2e5-70dc-8e81-2ebd-b038e539f954@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 15 Mar 2022 15:01:25 -0400
Message-ID: <CALLqZ8S6hKCSbayV4n0f-S=n8EeiG5jVPm9mFN6vC7HJyQ=mmg@mail.gmail.com>
Subject: Re: [PATCH] arm64: ipipe: Make erratum_1418040_thread_switch
 compatible with I-pipe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On Tue, Mar 15, 2022 at 2:56 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> First of all, this erratum hook is called from __switch_to, thus
> potentially also from the primary domain. Some of the functions it calls
> check if preemption was disabled under Linux - which may not be the case
> when invoked from primary domain. Rather than adding a costly check for
> ipipe_root_p to this hot-path, simply turn the check off if I-pipe is
> enabled.
>
> As the hook can be called from primary context, we need to protect its
> setup for new execs against those contexts via hard_preempt_disable.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> This is for 5.4-only, older kernels do no have the erratum fix.
>
> Philippe, the hardening of erratum_1418040_new_exec() could be a topic
> for dovetail as well. preemptible() is fully oob-aware there, though.
>
>  arch/arm64/kernel/cpu_errata.c | 3 ++-
>  arch/arm64/kernel/cpufeature.c | 3 ++-
>  arch/arm64/kernel/process.c    | 4 ++--
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpu_errata.c
> b/arch/arm64/kernel/cpu_errata.c
> index 1e16c4e00e771..7fd7d1c8b9fcc 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -37,7 +37,8 @@ static bool __maybe_unused
>  is_affected_midr_range_list(const struct arm64_cpu_capabilities *entry,
>                             int scope)
>  {
> -       WARN_ON(scope !=3D SCOPE_LOCAL_CPU || preemptible());
> +       WARN_ON(scope !=3D SCOPE_LOCAL_CPU ||
> +               (preemptible() && !IS_ENABLED(CONFIG_IPIPE)));
>         return is_midr_in_range_list(read_cpuid_id(),
> entry->midr_range_list);
>  }
>
> diff --git a/arch/arm64/kernel/cpufeature.c
> b/arch/arm64/kernel/cpufeature.c
> index acdef8d76c64d..d65287cc2148b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2023,7 +2023,8 @@ static void __init mark_const_caps_ready(void)
>
>  bool this_cpu_has_cap(unsigned int n)
>  {
> -       if (!WARN_ON(preemptible()) && n < ARM64_NCAPS) {
> +       if (!WARN_ON(!IS_ENABLED(CONFIG_IPIPE) && preemptible()) &&
> +           n < ARM64_NCAPS) {
>                 const struct arm64_cpu_capabilities *cap =3D
> cpu_hwcaps_ptrs[n];
>
>                 if (cap)
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 68c078ab0250c..879ecf0237c88 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -517,9 +517,9 @@ static void erratum_1418040_thread_switch(struct
> task_struct *next)
>
>  static void erratum_1418040_new_exec(void)
>  {
> -       preempt_disable();
> +       unsigned long flags =3D hard_preempt_disable();
>         erratum_1418040_thread_switch(current);
> -       preempt_enable();
> +       hard_preempt_enable(flags);
>  }
>
>  /*
> --
> 2.34.1


Hi Jan,

Thanks for the patch, I=E2=80=99ll have time to test it tomorrow.

Thanks

Greg

>
>
