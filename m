Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE5361
	for <xenomai@lists.linux.dev>; Fri, 17 Feb 2023 02:20:31 +0000 (UTC)
Received: from relay10.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::230])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C55ACC2C3B
	for <xenomai@lists.linux.dev>; Fri, 17 Feb 2023 02:09:49 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id C333E240003
	for <xenomai@lists.linux.dev>; Fri, 17 Feb 2023 02:09:41 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
	by spool.mail.gandi.net (Postfix) with ESMTP id D982874004E
	for <xenomai@xenomai.org>; Fri, 17 Feb 2023 02:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=T0wWMiiiw8/VpUUAdNCnMj3WKqwHegzhYJi0gxpO9O8=;
	b=QdlwIaXE52jwcjao9CUop6CsC4GdznK3Rp3yKikhblgyeYHX9lIdwlk0nvXimg
	ksyoTXPwK9SniGpIgnoE7L+71HQfdaqrUPma8ZzEls/RQiYtuOT3+emqpl+Z2JVU
	KVfsqu1VooohCQ7cjdHyQsNdtHlttr6ToCe23CT3J4eKQ=
Received: from [10.10.80.195] (unknown [117.121.60.17])
	by smtp17 (Coremail) with SMTP id NdxpCgBnhW_e4e5jBAx+EQ--.49679S2;
	Fri, 17 Feb 2023 10:09:34 +0800 (CST)
Message-ID: <b5410402-4c54-ac6e-63fb-3db8075b8589@163.com>
Date: Fri, 17 Feb 2023 10:09:34 +0800
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: I found the jitter was greater, when using the patch
 "cobalt/init: Fail if CPU 0 is missing from real-time CPU mask"
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org
References: <6b1485d5-c10f-e607-916e-138b9d3ccf75@163.com>
 <fd22514f-1ff9-a413-ac64-7f5513885235@siemens.com>
From: linz <powertree@163.com>
In-Reply-To: <fd22514f-1ff9-a413-ac64-7f5513885235@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:NdxpCgBnhW_e4e5jBAx+EQ--.49679S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF15tFy5Zr48WFW7Kw18Grg_yoW3GF1Upr
	W2qr4aqw1qqFyjg3y5AasrXr1rGrW8ua9xJr17WryIyrn8Ar93WF18AFy5trW7C3s3ZF10
	qryUZF93Jr90ya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVBTOUUUUU=
X-Originating-IP: [117.121.60.17]
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/1tbivB8ZlWASa8-1JQAAsp
Received-SPF: pass (spool2: domain of 163.com designates 123.126.96.234 as permitted sender) client-ip=123.126.96.234; envelope-from=powertree@163.com; helo=m12.mail.163.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=163.com header.s=s110527 header.b=QdlwIaXE;
	spf=pass (spool.mail.gandi.net: domain of powertree@163.com designates 123.126.96.234 as permitted sender) smtp.mailfrom=powertree@163.com;
	dmarc=pass (policy=none) header.from=163.com


在 2023/2/16 17:53, Jan Kiszka 写道:
> On 16.02.23 10:25, linz wrote:
>> Hi, I met a question when using xenomai v3.2.2. The CPU on my 
>> development board has four cores, CPU0, CPU1, CPU2, CPU3 I used CPU0 
>> and CPU3 for xenomai, and CPU1 and CPU3 for linux. The bootargs is as 
>> follows: setenv bootargs  isolcpus=0,3 xenomai.supported_cpus=0x9 
>> nohz_full=0,3 rcu_nocbs=0,3 irqaffinity=1,2 nosoftlockup 
>> nmi_watchdog=0; Then I runned latency testsuit, I found the jitter 
>> was greater than before. So I tried to use ftrace to look for the 
>> reason, and found the thread runing in CPU0 and CPU3 compete for 
>> nklock. The ftrace is as follows:             sshd-2187    [000] 
>> *.~2  6695.901950: ___xnlock_get <-___xnsched_run 
>> /////////////////////////////////////////////// CPU0 got xnlock 
>>           <idle>-0       [003] *.~1  6695.901950: 
>> rcu_oob_prepare_lock <-irq_find_mapping           <idle>-0       
>> [003] *.~1  6695.901951: __rcu_read_lock <-irq_find_mapping           
>> <idle>-0       [003] *.~1  6695.901951: __rcu_read_unlock 
>> <-irq_find_mapping             sshd-2187    [000] *.~2  6695.901951: 
>> xnsched_pick_next <-___xnsched_run           <idle>-0       [003] 
>> *.~1  6695.901952: rcu_oob_finish_lock <-irq_find_mapping           
>> <idle>-0       [003] *.~1  6695.901952: generic_pipeline_irq 
>> <-gic_handle_irq           <idle>-0       [003] *.~1  6695.901952: 
>> generic_pipeline_irq_desc <-generic_pipeline_irq             
>> sshd-2187    [000] *.~2  6695.901953: ktime_get_mono_fast_ns 
>> <-___xnsched_run           <idle>-0       [003] *.~1  6695.901953: 
>> handle_percpu_devid_irq <-generic_pipeline_irq_desc             
>> sshd-2187    [000] *.~2  6695.901953: arch_counter_read 
>> <-ktime_get_mono_fast_ns           <idle>-0       [003] *.~1  
>> 6695.901953: handle_oob_irq <-handle_percpu_devid_irq           
>> <idle>-0       [003] *.~1  6695.901954: do_oob_irq <-handle_oob_irq 
>>           <idle>-0       [003] *.~1  6695.901954: 
>> arch_timer_handler_phys <-do_oob_irq             sshd-2187    [000] 
>> *.~2  6695.901954: pipeline_switch_to <-___xnsched_run           
>> <idle>-0       [003] *.~1  6695.901955: xnintr_core_clock_handler 
>> <-arch_timer_handler_phys           <idle>-0       [003] *.~1  
>> 6695.901955: ___xnlock_get <-xnintr_core_clock_handler 
>> ///////////////////////////////////////////////  CPU3 wanted to get 
>> xnlock           <idle>-0       [003] *.~1  6695.901955: 
>> queued_spin_lock_slowpath <-___xnlock_get 
>> ///////////////////////////////////////////////  CPU3 failed and 
>> waited             sshd-2187    [000] *.~2  6695.901956: 
>> dovetail_context_switch <-pipeline_switch_to             sshd-2187    
>> [000] *.~2  6695.901956: check_and_switch_context 
>> <-dovetail_context_switch             sshd-2187    [000] *.~2  
>> 6695.901957: cpu_do_switch_mm <-check_and_switch_context             
>> sshd-2187    [000] *.~2  6695.901958: post_ttbr_update_workaround 
>> <-cpu_do_switch_mm             sshd-2187    [000] *.~2  6695.901958: 
>> fpsimd_thread_switch <-__switch_to             sshd-2187    [000] 
>> *.~2  6695.901959: __get_cpu_fpsimd_context <-fpsimd_thread_switch 
>>             sshd-2187    [000] *.~2  6695.901960: __fpsimd_save 
>> <-fpsimd_thread_switch             sshd-2187    [000] *.~2  
>> 6695.901960: __put_cpu_fpsimd_context <-fpsimd_thread_switch 
>>             sshd-2187    [000] *.~2  6695.901961: 
>> hw_breakpoint_thread_switch <-__switch_to             sshd-2187    
>> [000] *.~2  6695.901962: uao_thread_switch <-__switch_to             
>> sshd-2187    [000] *.~2  6695.901962: 
>> spectre_v4_enable_task_mitigation <-__switch_to             
>> sshd-2187    [000] *.~2  6695.901963: spectre_v4_mitigations_off 
>> <-spectre_v4_enable_task_mitigation             sshd-2187    [000] 
>> *.~2  6695.901963: cpu_mitigations_off <-spectre_v4_mitigations_off 
>>             sshd-2187    [000] *.~2  6695.901964: 
>> spectre_v4_mitigations_off <-spectre_v4_enable_task_mitigation 
>>             sshd-2187    [000] *.~2  6695.901965: cpu_mitigations_off 
>> <-spectre_v4_mitigations_off             sshd-2187    [000] *.~2  
>> 6695.901965: erratum_1418040_thread_switch <-__switch_to             
>> sshd-2187    [000] *.~2  6695.901966: this_cpu_has_cap 
>> <-erratum_1418040_thread_switch             sshd-2187    [000] *.~2  
>> 6695.901967: is_affected_midr_range_list <-this_cpu_has_cap 
>>             sshd-2187    [000] *.~2  6695.901967: mte_thread_switch 
>> <-__switch_to            <...>-2294    [000] *..2  6695.901968: 
>> inband_switch_tail <-__schedule 
>> /////////////////////////////////////////////// CPU0 switch thread 
>> sshd-2187 -> stress-2294            <...>-2294    [000] *..2  
>> 6695.901969: preempt_count_add <-inband_switch_tail            
>> <...>-2294    [000] *.~2  6695.901969: fpsimd_restore_current_oob 
>> <-dovetail_leave_inband            <...>-2294    [000] *.~2  
>> 6695.901970: fpsimd_restore_current_state 
>> <-fpsimd_restore_current_oob            <...>-2294    [000] *.~2  
>> 6695.901970: hard_preempt_disable <-fpsimd_restore_current_state 
>>            <...>-2294    [000] *.~2  6695.901971: 
>> __get_cpu_fpsimd_context <-fpsimd_restore_current_state            
>> <...>-2294    [000] *.~2  6695.901972: __put_cpu_fpsimd_context 
>> <-fpsimd_restore_current_state            <...>-2294    [000] *.~2  
>> 6695.901973: hard_preempt_enable <-fpsimd_restore_current_state 
>>            <...>-2294    [000] *.~2  6695.901973: ___xnlock_put 
>> <-xnthread_harden /////////////////////////////////////////////// 
>> CPU0 released xnlock           <idle>-0       [003] *.~1  
>> 6695.901974: xnclock_tick <-xnintr_core_clock_handler 
>> /////////////////////////////////////////////// CPU3 got xnlock 
>> finally, but lost 901974-901955==19us I try to revert the patch 
>> "cobalt/init: Fail if CPU 0 is missing from real-time CPU mask 
>> "(website is 
>> https://source.denx.de/Xenomai/xenomai/-/commit/5ac4984a6d50a2538139193350eef82b60a42001), 
>> and then use the follow bootargs: setenv bootargs isolcpus=3 
>> xenomai.supported_cpus=0x9 nohz_full=3 rcu_nocbs=3 irqaffinity=0,1,2 
>> nosoftlockup nmi_watchdog=0; finally, the problem is resolved.
> Why do you have to revert this commit? Your supported_cpus here still 
> contains CPU 0, thus should not trigger that check. Sorry, I wrote 
> wrongly, The bootargs should be: setenv bootargs isolcpus=3 
> xenomai.supported_cpus=0x8 nohz_full=3 rcu_nocbs=3 irqaffinity=0,1,2 
> nosoftlockup nmi_watchdog=0 So, I supported_cpus didn't contain CPU 0. 
> After reverting the patch, with the above bootargs, the jitter is less 
> than 7us using latency testsuit. But the jitter is about 15us using 
> latency testsuit using the follow bootargs: setenv bootargs 
> isolcpus=0,3 xenomai.supported_cpus=0x9 nohz_full=0,3 rcu_nocbs=0,3 
> irqaffinity=1,2 nosoftlockup nmi_watchdog=0; The reason is CPU0 and 
> CPU3 compete for xnlock, that is, results presented by ftrace.
>> My question is: If I revert the patch, what is the impact on the 
>> system? Can you specify where CPU 0 is supposed to be real-time?
> You can currently only specify setups where CPU 0 included because of 
> the mentioned restrictions in the cobalt core. I do not recall all 
> places where this assumption would be violated, just 
> kernel/cobalt/dovetail/tick.c: pipeline_timer_name() from quickly 
> re-reading the patch context. Can't you move all your RT workload to 
> CPU 0 and all non-RT to the others?

In the customer's actual environment,
if moving all your RT workload to CPU 0 and all non-RT to the others,
the customer will feel troublesome,
because they feel incompatible with xenomai 3.1.x, that is, the ipipe 
core has no restrictions on CPU0.


> Jan

