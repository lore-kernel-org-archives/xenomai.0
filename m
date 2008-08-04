Message-ID: <005b01c8f615$db466930$09201fac@domain.hid>
From: "Atsushi Katagiri" <a-katagiri@domain.hid>
References: <001b01c8f600$0c5a5a60$09201fac@domain.hid>
	<4896B492.4000404@domain.hid>
Date: Mon, 4 Aug 2008 18:38:31 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Buffer over flow in /proc/xenomai/stat
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

Yes, I actually encountered this bug and my Linux was crashed by NULL pointer dereference.

I think this is a very simple bug.
It happens "everytime" we open /proc/xenomai/stat,
because the last iter->nentries++; (line 466) surely reaches the value of the count,
and the next iteration, line 449, surely overwrites zero on out of the kmalloced area.

If you doubt of it, please try the next debug code.

Regards,
Atsushi KATAGIRI

--- xenomai-2.4.4-org/ksrc/nucleus/module.c 2008-06-02 00:44:48.000000000 +0900
+++ xenomai-2.4.4/ksrc/nucleus/module.c 2008-08-04 17:54:12.000000000 +0900
@@ -382,6 +382,8 @@
  iter = kmalloc(sizeof(*iter)
          + (count - 1) * sizeof(struct stat_seq_info),
          GFP_KERNEL);
+ printk("iter=%x size=%d count=%d\n",iter,(int)(sizeof(*iter)
+         + (count - 1) * sizeof(struct stat_seq_info)),count); //+++++debug
  if (!iter)
   return -ENOMEM;
 
@@ -437,17 +439,29 @@
   xnlock_put_irqrestore(&nklock, s);
  }
 
+ int nentries_old = -1; //+++++debug
+
  /* Iterate over all IRQ numbers, ... */
  for (irq = 0; irq < XNARCH_NR_IRQS; irq++) {
   xnintr_t *prev = NULL;
   int cpu = 0;
   int err;
 
+//  if (iter->nentries >= count)
+//   break;
+
   /* ...over all shared IRQs on all CPUs */
   while (1) {
    stat_info = &iter->stat_info[iter->nentries];
    stat_info->cpu = cpu;
 
+//+++++debug----->
+   if(nentries_old != iter->nentries){
+    printk("stat_info=%x nentries=%d\n",stat_info,(int)(iter->nentries));
+    nentries_old = iter->nentries;
+   }
+//+++++debug<-----
+
    err = xnintr_query(irq, &cpu, &prev, intr_rev,
         stat_info->name,
         &stat_info->csw,
@@ -464,7 +478,9 @@
    stat_info->pf = 0;
 
    iter->nentries++;
-  };
+//   if (iter->nentries >= count)
+//    break;
+  }
  }
 
  seq = file->private_data;

----- Original Message ----- 
From: "Philippe Gerum" <rpm@xenomai.org>
To: "Atsushi Katagiri" <a-katagiri@domain.hid>
Cc: <xenomai@xenomai.org>
Sent: Monday, August 04, 2008 4:49 PM
Subject: Re: [Xenomai-core] [PATCH] Buffer over flow in /proc/xenomai/stat


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


