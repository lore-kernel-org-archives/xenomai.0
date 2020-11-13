References: <MWHPR11MB17100D1F48C3EF22B3C6A329F2E60@MWHPR11MB1710.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
In-reply-to: <MWHPR11MB17100D1F48C3EF22B3C6A329F2E60@MWHPR11MB1710.namprd11.prod.outlook.com>
Date: Fri, 13 Nov 2020 19:30:14 +0100
Message-ID: <87lff5rtxl.fsf@xenomai.org>
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
Cc: xenomai@xenomai.org


Chen, Hongzhan via Xenomai <xenomai@xenomai.org> writes:

> Recently I have been working on wip/dovetail branch to port xenomai over
> dovetail. After fixed all TODOs for porting xenomai, kernel init now can
> successfully finish xenomai init till hang in rcu_barrier. 
> Its call path is like this start_kernel->arch_call_rest_init->rest_init->
> kernel_thread(kernel_init, NULL, CLONE_FS)->kernel_init->mark_readonly
> ->rcu_barrier when hang issue happen. 
>
> According to my debug , before call xenomai_init, all callback function 
> registerred with call_rcu can be invoked successfully after a period of time.
> The first problematic call_rcu which its callback never be invoked can be 
> traced back to call xenomai_init  (actually I just found only one call_rcu 
> called during xenomai_init) before call rcu_barrier. 
>
> In addition , after xenomai_init is completed , all following callbacks with 
> registerred through call_rcus called by other driver init are also never 
> invoked till call rcu_barrier.
>
> Is it not safe to call call_rcu with enabling xenomai over dovetail in this 
> case?

Such a restriction would not make any sense, making Dovetail pretty much
unusable, right? So, no.

> What I should do to fix this issue?  Please help comment.
>
> I have pushed all my patches onto my public branch 
> https://github.com/hongzhanchen/xenomai/tree/hzchen/dovetail ,please feel 
> free to check them. 
>

Unfortunately, the tree you mentioned does not even remotely builds,
tons of code commented out triggering warning about a collection of
pending TODOs, also with plain errors like:

/work/git/worktrees/xenomai+dovetail-5.8/kernel/xenomai/intr.c:284:37: error: 'IPIPE_NR_IRQS' undeclared here (not in a function)
/work/git/worktrees/xenomai+dovetail-5.8/kernel/xenomai/intr.c:472:6:
error: implicit declaration of function '__ipipe_irq_handler'; did you
mean 'xnintr_irq_handler'? [-Werror=implicit-function-declaration]

I tried to build it on top of dovetail-v5.8 from [1], which is the
reference version for that kernel. I would suggest to address the
pending work - at least the obviously critical one - in the Cobalt core
first, before going for any meaningful debug next.

[1] https://git.evlproject.org/linux-evl.git/tag/?h=v5.8-dovetail

-- 
Philippe.

