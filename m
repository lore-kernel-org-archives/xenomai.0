Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45DECFAF.60304@domain.hid>
References: <45DECFAF.60304@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 14:25:13 +0100
Message-Id: <1172237113.26738.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

On Fri, 2007-02-23 at 12:27 +0100, Steven Scholz wrote:

> #ifdef CONFIG_IPIPE
>         if (unlikely(!ipipe_root_domain_p))
>                 return;
> #endif /* CONFIG_IPIPE */
> 
> When stepping trough I only see him getting into schedule() but leaving
> it in the above lines and in include/linux/proc_fs.h:proc_net_fops_create() ...
> 

This is exactely the kind of issue which 1.6-02 is expected to solve;
this bug has been identified with all earlier versions, so there must be
another spot where the latter fix is missing in the Adeos patch.

-- 
Philippe.



