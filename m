Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02A7EAC6
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 08:23:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90F231BF205;
	Fri, 22 Sep 2023 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695371023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V903EDjm/tF4fytcSecQ/qMckgEPN/Wys/bPGUERYLI=;
	b=FdLhZiVf/x0u1avnISlBsA08mq0FLmsxCA1ys753eflp/eNe5wn/B9osmsJAg0HxNupULB
	FGMFT51SXRpdhlhQuwpZYeb+MszavyUlL0upJzVEyjiMXl6kCgUgxOFumONsb1V3/YU44D
	X7kUuZGCTKi2tpzTH5k7nWunsDSCarTx24Pnmig93yeveGXP3G2/2BXDS/ta74dWOzfYCZ
	HplFUqHUBLmd6tpSaIKp9pjGamAphZNhXkEw1FXIrOQwAjejPP/cqK5ZMBLNJFYV34SwRx
	O9oZ5NsxOoq+3Fnuuoq6ibPnUo40OW5HSMs+SRZFHfQG+fxfb1ZSzhyShxnfqg==
References: <1eb4952e-f76f-4831-87e1-5effe76700ca@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [dovetail-5.10] Re: tracing: irq_pipeline: add pipeline awareness
Date: Fri, 22 Sep 2023 10:18:35 +0200
In-reply-to: <1eb4952e-f76f-4831-87e1-5effe76700ca@siemens.com>
Message-ID: <87cyyamx9x.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> what is this fixme in 5.10.y-dovetail-rebase (and only there) about?
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3e0ae1168069..8d10bdfd8ccf4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
>
> ...
>
> @@ -7229,10 +7231,10 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  			break;
>  		/* Now, we're going to swap */
>  		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
> -			local_irq_disable();
> +			hard_local_irq_disable();
>  			update_max_tr(tr, current, smp_processor_id(), NULL);
> -			local_irq_enable();
> -		} else {
> +			hard_local_irq_enable();
> +		} else {	/* FIXME: irq_pipeline */
>  			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
>  						 (void *)tr, 1);
>  		}
>
> To my understanding, tracing_snapshot_write() will only be called in-
> band, no?
>
> Jan

Yes, but I'm still pondering the implications of the in-band vs oob
concurrent accesses on the upstream commit #c5d30d6aa as a fix for a SMP
race between buffer swap & write ops. Assuming this is not an issue
eventually, the code would look like this:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d10bdfd8ccf4..46cdc6ecf64a9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7168,7 +7168,9 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 
 static void tracing_swap_cpu_buffer(void *tr)
 {
+	hard_local_irq_disable();
 	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
+	hard_local_irq_enable();
 }
 
 static ssize_t
@@ -7234,7 +7236,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			hard_local_irq_disable();
 			update_max_tr(tr, current, smp_processor_id(), NULL);
 			hard_local_irq_enable();
-		} else {	/* FIXME: irq_pipeline */
+		} else {
 			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
 						 (void *)tr, 1);
 		}
-- 
Philippe.
