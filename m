Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3060B21C9ED
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068661; cv=none; b=lm1YlWvVpXdCXBfGfhr/AMJ0MVkqnSA07xtV+9cZcA7t0JgAsvLSnu6tZd7/XkDCrs6IwSd/d0rhpf8zpggZsclOqJfs847HuIy9NXwyZPYo9sEn0LiX5hs8gVePbjkIcK6VJ7meoe0dJkD4y1CsyrC3KwxFf2tqAw9PNx9wY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068661; c=relaxed/simple;
	bh=DVnXpEjaGYvh8Y/mJ/px78OkujiZXw7EmC/0WQ2NNIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKDydtmitg8zDAEeWqFxMUDjjwC6nKpAcYtmOJSLWQn/Ql3NFmS95tOmgPpA7BxsrkgESl0mJaFkpQUfvpIpwK4M8T5aLVjewyqGGG2U+ibUZC/1b6t1Gs0eB8ThpoHNcjvVO7zODGhUHwjUdpDDWhENAqs9z7JkzpQubKPFtWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WeHWtI90; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeHWtI90"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 57EC143767
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 13:44:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B311DD8065A
	for <xenomai@xenomai.org>; Wed,  9 Jul 2025 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752068653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WIYYz00WMAx0jEvifzAnucqSCA2pOwmBP4B89NJHgaI=;
	b=WeHWtI90L2qvxNLlzGOmIisbRlvUVyQ1exyv74CU2vHw8/6v/ZY8KitztJ/qBUOljtWjAe
	ppg9RcTamFEYwXTAIDy+xmAkSTfUunrlJVhm+8aWuvTG+B1cLsPSsmAGK+1wrJHka7CLr5
	FXl8RKDRefvls0jeAGkxddArNbITaAM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-bRn-WOMeMGeg-GjPJ1JLxg-1; Wed,
 09 Jul 2025 09:44:08 -0400
X-MC-Unique: bRn-WOMeMGeg-GjPJ1JLxg-1
X-Mimecast-MFC-AGG-ID: bRn-WOMeMGeg-GjPJ1JLxg_1752068647
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 903C51808985;
	Wed,  9 Jul 2025 13:44:06 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.17.16.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B338B1800285;
	Wed,  9 Jul 2025 13:44:03 +0000 (UTC)
Date: Wed, 9 Jul 2025 09:44:01 -0400
From: Phil Auld <pauld@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Henning Schild <henning.schild@siemens.com>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
	xenomai@xenomai.org, guocai.he.cn@windriver.com, pauld@redhat.com
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
Message-ID: <20250709134401.GA675435@lorien.usersys.redhat.com>
References: <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net>
 <20190729205059.GA1127@roeck-us.net>
 <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
 <20190816193208.GA29478@roeck-us.net>
 <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
 <20210727100018.19d61165@md1za8fc.ad001.siemens.net>
 <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com>
 <8734mg92pt.ffs@tglx>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734mg92pt.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WeHWtI90;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (spool.mail.gandi.net: domain of pauld@redhat.com designates 170.10.129.124 as permitted sender) smtp.mailfrom=pauld@redhat.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfhhihhlucetuhhlugcuoehprghulhgusehrvgguhhgrthdrtghomheqnecuggftrfgrthhtvghrnhepueefjeethefhtddtgefhfeelleefgfffgfegleefgfduhefgleevvdfhveffleehnecukfhppedvudejrdejtddrudejkedrvddugedpfeehrdduieehrdduheegrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddugedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehprghulhgusehrvgguhhgrthdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

Hi Thomas,

On Tue, Sep 03, 2024 at 05:27:58PM +0200 Thomas Gleixner wrote:
> On Tue, Jul 27 2021 at 10:46, Jan Kiszka wrote:
> 
> Picking up this dead thread again.

Necro-ing this again...

I keep getting occasional reports of this case. Unfortunately
though, I've never been able to reproduce it myself.

Did the below patch ever go anywhere?

It seems to be stable in my testing with the addition of
an "extern" in asm/cpu.h to get it to build.

> 
> > What is supposed to prevent the following in mainline:
> >
> > CPU 0                   CPU 1                      CPU 2
> >
> > native_stop_other_cpus                             <INTERRUPT>
> >   send_IPI_allbutself                              ...
> >                         <INTERRUPT>
> >                         sysvec_reboot
> >                           stop_this_cpu
> >                             set_cpu_online(false)
> >                                                    native_smp_send_reschedule(1)
> >                                                      if (cpu_is_offline(1)) ...
> 
> Nothing. And that's what probably happens if I read the stack trace
> correctly.
> 
> But we can be slightly smarter about this for the reboot IPI (the NMI
> case does not have that issue).
> 
> CPU 0                   CPU 1                      CPU 2
> 
> native_stop_other_cpus                             <INTERRUPT>
>    send_IPI_allbutself                              ...
>                          <IPI>
>                          sysvec_reboot
>                            wait_for_others();
>                                                     </INTERRUPT>
>                                                     <IPI>
>                                                     sysvec_reboot
>                                                     wait_for_others();
>                            stop_this_cpu();           stop_this_cpu();
>                              set_cpu_online(false);     set_cpu_online(false);
> 
> Something like the uncompiled below.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -68,5 +68,6 @@ bool intel_find_matching_signature(void
>  int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
>  
>  extern struct cpumask cpus_stop_mask;
> +atomic_t cpus_stop_in_ipi;

extern 

>  
>  #endif /* _ASM_X86_CPU_H */
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -721,7 +721,7 @@ bool xen_set_default_idle(void);
>  #define xen_set_default_idle 0
>  #endif
>  
> -void __noreturn stop_this_cpu(void *dummy);
> +void __noreturn stop_this_cpu(bool sync);
>  void microcode_check(struct cpuinfo_x86 *prev_info);
>  void store_cpu_caps(struct cpuinfo_x86 *info);
>  
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -791,9 +791,10 @@ bool xen_set_default_idle(void)
>  }
>  #endif
>  
> +atomic_t cpus_stop_in_ipi;
>  struct cpumask cpus_stop_mask;
>  
> -void __noreturn stop_this_cpu(void *dummy)
> +void __noreturn stop_this_cpu(bool sync)
>  {
>  	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
>  	unsigned int cpu = smp_processor_id();
> @@ -801,6 +802,16 @@ void __noreturn stop_this_cpu(void *dumm
>  	local_irq_disable();
>  
>  	/*
> +	 * Account this CPU and loop until the other CPUs reached this
> +	 * point. If they don't react, the control CPU will raise an NMI.
> +	 */
> +	if (sync) {
> +		atomic_dec(&cpus_stop_in_ipi);
> +		while (atomic_read(&cpus_stop_in_ipi))
> +			cpu_relax();
> +	}
> +
> +	/*
>  	 * Remove this CPU from the online mask and disable it
>  	 * unconditionally. This might be redundant in case that the reboot
>  	 * vector was handled late and stop_other_cpus() sent an NMI.
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -788,7 +788,7 @@ static void native_machine_halt(void)
>  
>  	tboot_shutdown(TB_SHUTDOWN_HALT);
>  
> -	stop_this_cpu(NULL);
> +	stop_this_cpu(false);
>  }
>  
>  static void native_machine_power_off(void)
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -125,7 +125,7 @@ static int smp_stop_nmi_callback(unsigne
>  		return NMI_HANDLED;
>  
>  	cpu_emergency_disable_virtualization();
> -	stop_this_cpu(NULL);
> +	stop_this_cpu(false);
>  
>  	return NMI_HANDLED;
>  }
> @@ -137,7 +137,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
>  {
>  	apic_eoi();
>  	cpu_emergency_disable_virtualization();
> -	stop_this_cpu(NULL);
> +	stop_this_cpu(true);
>  }
>  
>  static int register_stop_handler(void)
> @@ -189,6 +189,7 @@ static void native_stop_other_cpus(int w
>  	 */
>  	cpumask_copy(&cpus_stop_mask, cpu_online_mask);
>  	cpumask_clear_cpu(this_cpu, &cpus_stop_mask);
> +	atomic_set(&cpus_stop_in_ipi, num_online_cpus() - 1);
>  
>  	if (!cpumask_empty(&cpus_stop_mask)) {
>  		apic_send_IPI_allbutself(REBOOT_VECTOR);
> @@ -235,10 +236,12 @@ static void native_stop_other_cpus(int w
>  	local_irq_restore(flags);
>  
>  	/*
> -	 * Ensure that the cpus_stop_mask cache lines are invalidated on
> -	 * the other CPUs. See comment vs. SME in stop_this_cpu().
> +	 * Ensure that the cpus_stop_mask and cpus_stop_in_ipi cache lines
> +	 * are invalidated on the other CPUs. See comment vs. SME in
> +	 * stop_this_cpu().
>  	 */
>  	cpumask_clear(&cpus_stop_mask);
> +	atomic_set(&cpus_stop_in_ipi, 0);
>  }
>  
>  /*
> 


Thanks,
Phil
-- 

