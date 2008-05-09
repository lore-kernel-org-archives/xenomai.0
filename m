Message-ID: <48241CF1.8020708@domain.hid>
Date: Fri, 09 May 2008 11:44:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4824197E.90709@domain.hid>
In-Reply-To: <4824197E.90709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Unfreeze timers when debugged target
	exits
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> I expressed my skepticism about this global timer freeze before :->, and

Just try debugging periodic code without it...

We should have an opt-out mechanism to hide timers from the auto-freeze feature,
 that is the real issue yet to be fixed.

> now it hit me unpleasantly (Customer: "Is it normal that Xenomai stops
> working after the gdb session?" Jan [scratching head]: "Hmm, no...").
> 
> After more scratching I think I found the reason: The target decided to
> die after some fault, but Xenomai missed to unfreeze the timers. Patch
> below fixes that.
> 
> Without hearing complains, this also goes into trunk/2.4.x later today.
> 
> Jan
> 
> ---
>  ksrc/nucleus/shadow.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: b/ksrc/nucleus/shadow.c
> ===================================================================
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -2148,6 +2148,9 @@ static inline void do_taskexit_event(str
>  	if (!thread)
>  		return;
>  
> +	if (xnthread_test_info(thread, XNDEBUG))
> +		unlock_timers();
> +
>  	if (xnpod_shadow_p())
>  		xnshadow_relax(0);
>  
> 

This should be ok.


-- 
Philippe.

