MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17582.26845.522459.204811@domain.hid>
Date: Fri, 7 Jul 2006 15:59:57 +0200
Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
In-Reply-To: <1152278610.5035.12.camel@domain.hid>
References: <44ACF5FA.2050205@domain.hid> <1152196379.4978.74.camel@domain.hid>
	<17581.41221.527736.416354@domain.hid>
	<1152258866.5017.4.camel@domain.hid>
	<17582.13798.272437.979081@domain.hid>
	<1152278610.5035.12.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > > xnpod_acc_exec_time() is called from within xnpod_schedule() that is
 > > called from within xnpod_migrate_thread() at a time where
 > > threadout->sched is the wrong pointer.
 > 
 > Gasp. Unfortunately, we are trapped by an exception case, and I don't
 > see any better approach.

We could reimplement an xnpod_migrate_thread() which suspend the calling
thread and wake up a server thread on the destination CPU, this server
thread migrating the suspended thread by changing its sched pointer
outside of xnpod_schedule().

Or we can get rid of xnpod_migrate_thread(), it is currently not used by
any skin.

-- 


					    Gilles Chanteperdrix.

