Message-ID: <49269929.5010804@domain.hid>
Date: Fri, 21 Nov 2008 12:19:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <49268B11.5090105@domain.hid>
In-Reply-To: <49268B11.5090105@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Catch multiple xnshadow_map attempts
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> My customer managed to find another hidden door to Xenomai's hell:
> Trying to create a Xenomai POSIX thread from within a native thread. A
> think the other way around would "work" as well. The precise scenario
> was native thread -> dlopen(libs that's linked against libpthread_rt) ->
> __init_posix_interface -> __wrap_pthread_setschedparam -> oops. That
> scenario revealed two more issues in fact.
> 
> Here is a patch to remove this hell gate by catching xnshadow_map
> invocations from withing already mapped shadow thread.
>

Any reason why the XNMAPPED predicate did not work in your case?

> Jan
> 
> ---
>  ChangeLog             |    5 +++++
>  ksrc/nucleus/shadow.c |    5 +++++
>  2 files changed, 10 insertions(+)
> 
> Index: xenomai/ksrc/nucleus/shadow.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/shadow.c
> +++ xenomai/ksrc/nucleus/shadow.c
> @@ -1334,6 +1334,8 @@ void xnshadow_exit(void)
>   * - -EINVAL is returned if the thread control block does not bear the
>   * XNSHADOW bit, or if the thread has already been mapped.
>   *
> + * - -EBUSY is returned if the current Linux task is already mapped.
> + *
>   * Environments:
>   *
>   * This service can be called from:
> @@ -1351,6 +1353,9 @@ int xnshadow_map(xnthread_t *thread, xnc
>  	unsigned muxid, magic;
>  	int err;
> 
> +	if (xnshadow_thread(current))
> +		return -EBUSY;
> +
>  	if (!xnthread_test_state(thread, XNSHADOW))
>  		return -EINVAL;
> 
> Index: xenomai/ChangeLog
> ===================================================================
> --- xenomai.orig/ChangeLog
> +++ xenomai/ChangeLog
> @@ -1,3 +1,8 @@
> +2008-11-21  Jan Kiszka  <jan.kiszka@domain.hid>
> +
> +	* ksrc/nucleus/shadow.c (xnshadow_map): Reject already mapped
> +	tasks with -EBUSY.
> +
>  2008-11-16  Philippe Gerum  <rpm@xenomai.org>
> 
>  	* ksrc/arch/blackfin/patches: Upgrade to to


-- 
Philippe.

