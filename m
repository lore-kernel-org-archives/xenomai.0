From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <8sld2b$hq8lvg@domain.hid>
References: <8sld2b$hq8lvg@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Sep 2010 19:03:32 +0200
Message-ID: <1285607012.1717.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unloading xeno_psos cannot cleanup some sources
 completely.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gao <gwysu@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2010-09-25 at 08:36 +0800, Gao wrote:
> Hi  All ,
>  
> After I load xeno_psos.ko by "/sbin/insmod xeno_psos.ko", and run my
> test program, whic create a queue by "q_vcreate", but not delete it in
> the test program.  After I finish running my test program. Then I
> unload the xeno_psos and then reload it again, it will crash as
> follow:     
>  
>  
>  /sbin/rmmod xeno_psos
> Xenomai: stopping pSOS+ services.
> 
> # /sbin/insmod xeno_psos.ko
> Xenomai: starting pSOS+ services.
> proc_dir_entry 'registry/psos' already registered
> ------------[ cut here ]------------
> Badness at fs/proc/generic.c:590
> NIP: c00f7988 LR: c00f7988 CTR: c0027f20
> REGS: c182bda0 TRAP: 0700   Not tainted  (2.6.33.4)
> MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22000442  XER: 00000000
> TASK = c181cc60[4] 'events/0' THREAD: c182a000
> GPR00: c00f7988 c182be50 c181cc60 00000038 c03bd180 c0394ae0 00000000
> 3eced82e
> GPR08: 00000100 00000000 00000003 c182a000 42000424 100af23c 01ffe800
> 01ff50a0
> GPR16: 01fd05d8 01ff507c c0348e18 c0320aa8 c182bea8 c03bd77c c0394fd8
> c313e7c4
> GPR24: c313e950 c0394fd8 00000000 c1881700 c1a35a80 c1a35600 c1a35ae0
> c1a35600
> NIP [c00f7988] proc_register+0xe4/0x1d0
> LR [c00f7988] proc_register+0xe4/0x1d0
> Call Trace:
> [c182be50] [c00f7988] proc_register+0xe4/0x1d0 (unreliable)
> [c182be80] [c00f7b90] create_proc_entry+0x60/0xac
> [c182bea0] [c0056d10] registry_proc_callback+0x318/0x394
> [c182bf60] [c002fe6c] worker_thread+0x12c/0x1c4
> [c182bfc0] [c0033dcc] kthread+0x78/0x7c
> [c182bff0] [c000f6c0] kernel_thread+0x4c/0x68
> Instruction dump:
> 2f9f0000 419e0034 807f0008 7fc4f378 4bf1ab6d 2f830000 409effe4
> 809b0008
> 3c60c032 7fc5f378 38636ce4 4bf264a5 <0fe00000> 83bb0038 939b0038
> 93bc0030
> 
>  
>  
>  
> The problem is caused by the reason that unloading xeno_psos.ko
> cannot clean up the the queues show as follow: 
>  
> # pwd
> /proc/xenomai/registry/psos/queues
> # ls
> cmq  q2r
> 
>  
> So can the problem be fixed? Thanks.

Yes, likely. But this is not on the hot path right now, so the issue is
queued. Thanks for reporting.

>  
>  
> Best regards,
> Wenyi Gao
>  
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



