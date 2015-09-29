References: <B89CCBE86D4F62448EE4F6367C6D3C89221E32ED@USMLVA0EM24MSX.ww017.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <560AB34B.5020300@xenomai.org>
Date: Tue, 29 Sep 2015 17:50:35 +0200
MIME-Version: 1.0
In-Reply-To: <B89CCBE86D4F62448EE4F6367C6D3C89221E32ED@USMLVA0EM24MSX.ww017.siemens.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai
	2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/29/2015 05:35 PM, PRADHAN, MAKARAND (RC-CA) wrote:
> Hi Everyone,
> 
> I am noticing a delay of around 1ms from the time I get an interrupt and the time when the user space irq handler task is invoked by Xenomai. Would highly appreciate any suggestions that will help me resolve the issue. Details follow:
> 
> System config:
> Xenomai: 2.6.4
> Linux: 3.14
> Processor: MPC8360E (powerpc)
> 
> I have a user space task(Task name: 00000193, pid: 30896(ipipe trace)) doing an rt_intr_wait on int 42(2a).
> 
> The ipipe trace is attached to the email. Am posting my interpretation of the trace below. It indicates that after the occurance of the int, the previously executing task continues execution before the int handling task gets scheduled:
> 
> Occurance of hw interrupt 42(2a)
> :|  +*begin   0x00000021 -1178    0.666  __ipipe_grab_irq+0x40 (__ipipe_ret_from_except+0x0)
> :|  +*func               -1178    0.878  __ipipe_dispatch_irq+0x8 (__ipipe_grab_irq+0x50)
> :|  +*func               -1177+   1.787  irq_to_desc+0x8 (__ipipe_dispatch_irq+0xec)
> :|  +*func               -1175+   1.712  irq_to_desc+0x8 (__ipipe_dispatch_irq+0xfc)
> :|  +*func               -1173+   1.712  qe_ic_get_low_irq+0x8 (qe_ic_cascade_low_ipic+0x1c)
> :|  +*begin   0x0000002a -1172    0.500  qe_ic_cascade_low_ipic+0x28 (__ipipe_dispatch_irq+0x94)
> :|  +*func               -1171    0.696  __ipipe_dispatch_irq+0x8 (qe_ic_cascade_low_ipic+0x34)
> :|  +*func               -1171    0.727  irq_to_desc+0x8 (__ipipe_dispatch_irq+0xec)
> :|  +*func               -1170+   1.242  irq_to_desc+0x8 (__ipipe_dispatch_irq+0xfc)
> :|  +*func               -1169+   1.212  __ipipe_ack_level_irq+0x8 (__ipipe_dispatch_irq+0x94)
> :|  +*func               -1167    0.924  qe_ic_mask_irq+0x8 (__ipipe_ack_level_irq+0x40)
> :|  +*func               -1167+   1.500  __ipipe_spin_lock_irqsave+0x8 (qe_ic_mask_irq+0x3c)
> :|  #*func               -1165+   1.636  __ipipe_spin_unlock_irqrestore+0x8 (qe_ic_mask_irq+0x94)
> :|  +*func               -1163    0.909  __ipipe_set_irq_pending+0x8 (__ipipe_dispatch_irq+0x314)
> :|  +*end     0x0000002a -1163    0.742  qe_ic_cascade_low_ipic+0x3c (__ipipe_dispatch_irq+0x94)
> :|  +*func               -1162+   1.606  __ipipe_do_sync_stage+0x8 (__ipipe_dispatch_irq+0x2f0)
> :|  #*func               -1160+   2.333  xnintr_irq_handler+0x8 (__ipipe_do_sync_stage+0x150)
> :|  #*func               -1158+   1.318  rt_intr_handler+0x8 [xeno_native] (xnintr_irq_handler+0x150)
> :|  #*func               -1157+   2.606  xnsynch_flush+0x8 (rt_intr_handler+0x48 [xeno_native])
> :|  #*func               -1154+   1.530  xnpod_resume_thread+0x8 (xnsynch_flush+0x170)
> :|  #*[30896] -<?>-  257 -1153+   4.606  xnpod_resume_thread+0x134 (xnsynch_flush+0x170)                <- Correct irq handler task identified for resuming
> :|  +*end     0x00000021 -1148    0.636  __ipipe_grab_irq+0x58 (__ipipe_ret_from_except+0x0)
> :|  +*func               -1147+   1.712  __ipipe_exit_irq+0x8 (__ipipe_grab_irq+0x60)
> 
> 
> The previously executing thread continues execution for 1076 us:
> :   +*func               -1145    0.833  rt_task_set_mode+0x8 [xeno_native] (__rt_task_set_mode+0x40 [xeno_native])
> :   +*func               -1144    0.666  xnpod_set_thread_mode+0x8 (rt_task_set_mode+0x90 [xeno_native])
> :|  +*begin   0x80000000 -1144+   1.181  xnpod_set_thread_mode+0x408 (rt_task_set_mode+0x90 [xeno_native])

Are you playing with the T_LOCK bit?

-- 
Philippe.

