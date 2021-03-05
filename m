References: <MWHPR11MB17100A5F27118C92A44F94C4F2999@MWHPR11MB1710.namprd11.prod.outlook.com>
 <CY4PR11MB1703AFA86C561954ECFE93BAF2969@CY4PR11MB1703.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: gdb test failure issue on xenomai 3.2
In-reply-to: <CY4PR11MB1703AFA86C561954ECFE93BAF2969@CY4PR11MB1703.namprd11.prod.outlook.com>
Date: Fri, 05 Mar 2021 11:56:34 +0100
Message-ID: <87k0qlyil9.fsf@xenomai.org>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Hi Hongzhan,

Sorry for the lag in replying.

Chen, Hongzhan <hongzhan.chen@intel.com> writes:

> Hi Philippe,
>
> I think I already found the root cause and almost fix it but still need time to validate it.
>
> Temporary patch like following:
>
> diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
> index de7c43b70..846b571b6 100644
> --- a/kernel/cobalt/dovetail/sched.c
> +++ b/kernel/cobalt/dovetail/sched.c
> @@ -56,9 +56,22 @@ int pipeline_leave_inband(void)
>
>  int pipeline_leave_oob_prepare(void)
>  {
> -       dovetail_leave_oob();
> +       int suspmask = XNRELAX;
> +       struct xnthread *curr = xnthread_current();
>
> -       return XNRELAX;
> +       dovetail_leave_oob();
> +       /*
> +        * If current is being debugged, record that it should migrate
> +        * back in case it resumes in userspace. If it resumes in
> +        * kernel space, i.e.  over a restarting syscall, the
> +        * associated hardening will both clear XNCONTHI and disable
> +        * the user return notifier again.
> +        */
> +       if (xnthread_test_state(curr, XNSSTEP)) {
> +               xnthread_set_info(curr, XNCONTHI);
> +               suspmask |= XNDBGSTOP;
> +       }
> +       return suspmask;
>  }

Yes, that part was definitely missing. I guess I dropped it mistakenly
due to the condition on the obsolete IPIPE_KEVT_USERINTRET check.

>
>  void pipeline_leave_oob_finish(void)
> intel@intel-Z97X-UD5H:~/iotg/dovetail/xenomaioverdovetail/cobalt-dovetail/upstream/xenomai-rpm$ git diff kernel/cobalt/dovetail/kevents.c
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 966a63ce0..9bceffaac 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
>         if (xnthread_test_info(thread, XNCONTHI)) {
>                 xnlock_get_irqsave(&nklock, s);
>                 xnthread_clear_info(thread, XNCONTHI);
> @@ -492,6 +494,8 @@ static void handle_ptrace_cont(void)
>                         unregister_debugged_thread(curr);
>
>                 xnthread_set_localinfo(curr, XNHICCUP);
> +
> +               dovetail_request_ucall(current);
>         }
>

Looks good to me too. Once the ptrace core tells us that current is
resuming from a stopped state, this is the right place to ask for
switching back to oob mode.

> After validation is done , I would submit clean patch to review.

Thanks for looking at this one. This is quite tricky stuff.

-- 
Philippe.

