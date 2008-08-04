Message-ID: <4896B492.4000404@domain.hid>
Date: Mon, 04 Aug 2008 09:49:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <001b01c8f600$0c5a5a60$09201fac@domain.hid>
In-Reply-To: <001b01c8f600$0c5a5a60$09201fac@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Buffer over flow in /proc/xenomai/stat
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
To: Atsushi Katagiri <a-katagiri@domain.hid>
Cc: xenomai@xenomai.org

Atsushi Katagiri wrote:
> Hello all.
> 
> This is a small patch that fixes a serious bug.
> 
> When we open /proc/xenomai/stat, function stat_seq_open kmalloc the area, write the data and increment iter->nentries.
> The last increment of this value reaches "count",
> and at the next iteration "stat_info->cpu = cpu;"  overwrites zero on illegal address!
>

Did you actually see this bug happen?

This code takes a snapshot of the IRQ and thread lists, that are identified by
two fingerprint values (intr_rev, thrq_rev). The only way to have iter->nentries
greater than count at some point, would be to see more IRQ/thread descriptors
being linked to their respective lists on-the-fly while we scan them. But in
that case, the current fingerprint value would stop matching the snapshot value
as well, causing the loops to restart, re-allocating sufficient space to hold
all the data.

If you did see this bug happen, please tell us a bit more about your setup.

> Here is my proposal of the fix..
> 
> =====patch start=====>
> diff -Nur xenomai-2.4.4-org/ksrc/nucleus/module.c xenomai-2.4.4/ksrc/nucleus/module.c
> --- xenomai-2.4.4-org/ksrc/nucleus/module.c 2008-06-02 00:44:48.000000000 +0900
> +++ xenomai-2.4.4/ksrc/nucleus/module.c 2008-07-29 09:46:45.000000000 +0900
> @@ -443,6 +443,9 @@
>    int cpu = 0;
>    int err;
>  
> +  if (iter->nentries >= count)
> +   break;
> +
>    /* ...over all shared IRQs on all CPUs */
>    while (1) {
>     stat_info = &iter->stat_info[iter->nentries];
> @@ -464,7 +467,9 @@
>     stat_info->pf = 0;
>  
>     iter->nentries++;
> -  };
> +   if (iter->nentries >= count)
> +    break;
> +  }
>   }
>  
>   seq = file->private_data;
> <=====patch end=====
> 
> I hope someone who knows this function well will solve the problem.
> 
> Regards,
> 
> Atsushi KATAGIRI
> Software Engineer
> A&D Company, Limited
> Tokyo, Japan
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

