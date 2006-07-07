Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17582.26845.522459.204811@domain.hid>
References: <44ACF5FA.2050205@domain.hid> <1152196379.4978.74.camel@domain.hid>
	<17581.41221.527736.416354@domain.hid>
	<1152258866.5017.4.camel@domain.hid>
	<17582.13798.272437.979081@domain.hid>
	<1152278610.5035.12.camel@domain.hid>
	<17582.26845.522459.204811@domain.hid>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 16:25:32 +0200
Message-Id: <1152282333.5035.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2006-07-07 at 15:59 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > > xnpod_acc_exec_time() is called from within xnpod_schedule() that is
>  > > called from within xnpod_migrate_thread() at a time where
>  > > threadout->sched is the wrong pointer.
>  > 
>  > Gasp. Unfortunately, we are trapped by an exception case, and I don't
>  > see any better approach.
> 
> We could reimplement an xnpod_migrate_thread() which suspend the calling
> thread and wake up a server thread on the destination CPU, this server
> thread migrating the suspended thread by changing its sched pointer
> outside of xnpod_schedule().
> 

No, really. A small hack to get per-thread accounting should not trigger
a storm of fundamental changes like this.

> Or we can get rid of xnpod_migrate_thread(), it is currently not used by
> any skin.
> 

It's a fundamental feature for placing SMP jobs, and kernel-based
Xenomai threads could not rely on sched_setscheduler() to do it. Let's
keep this service, and simply pass the sched pointer to the accumulation
routine; I was wrong initially suggesting the opposite. IOW, let's avoid
smashing a squadron of flies with nukes...

-- 
Philippe.



