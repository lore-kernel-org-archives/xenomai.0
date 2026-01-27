Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66371335547
	for <xenomai@lists.linux.dev>; Tue, 27 Jan 2026 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507787; cv=none; b=GZBbJTGRkA7CCPPbL9WGt0z2tnm5pzEcq1MDXmu/QLGFkvOkkNt7TxhczcQ8y/cX0GMDMavzULnDGuEucZwqyIFgEFZuwFADagXB6VcPXKdlQA62egXZRBnz3Li55mBwKIcOWPyygwgPRKwYQ4DTlsyKuckmM/bxtvZlQ3h7i5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507787; c=relaxed/simple;
	bh=9YwUnFDtX0UDUiGnMk2BXLSrnjZxBtgVeaGNySjKMt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Frubrz1uC1rELdkNN1MeF0xpCfyw0WeJ+5tBFvI4h1RAg8S04hGpgPlwG/168ilxSUUGl+W4o1jNm4EWCANTSnprfcHnXsQKu8r1pWmDgjkkm67XUAY5VEFGV7KhHp1jTza2w/PHL/vGvGi73L1W4lmauPBiSoZyilNgrnf+rfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=B8ibTj+h; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="B8ibTj+h"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF6291F766;
	Tue, 27 Jan 2026 09:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769507777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jf4TejsZgWjYt4J6lvvW8VpX9OOfh/cC1iA6yyipch4=;
	b=B8ibTj+hufb+qPXUWcd3Sl4y8PjHQiP7K6ZCBEQ8XUUqZMHbDmdGfm7QFniGq5PQxYToyn
	YL+WwAkE33v1c7vckHMyjjExsD9J57jz8qKK2PeEVuB5QuNEcjBEus2FoF1c1f0ihxGITQ
	REjbYWIxF9B0Ek8Xb9RmeC+eJZGZPrkFYCAvBnpEQqT+Xq6ZLtVN6HIyYlT93MG71XIils
	JkDbK4KwcuMYYGF6DGvjkbJXgwL+0X8FqpuaDV++F5oj2dqssuSiMsk8wS3bg3sOu2D1Vr
	tt2VO3J693Vyg3+WBu6jd8nToGNtsU1VnQB9myTP6UE4A9SWYGeodl7zqnrIfQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: CPU Hotplug Splat
In-Reply-To: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at> (Richard
	Weinberger's message of "Mon, 26 Jan 2026 17:28:04 +0100 (CET)")
References: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 27 Jan 2026 10:56:12 +0100
Message-ID: <87o6mfxttv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedtvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeeugedtgfduffduleejteeujeejieelteelveehfeektdefvdduleeugefggffhgfenucffohhmrghinhepohhpvghnshhushgvrdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeevhfeivdeludfhjeeiiedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrth
X-GND-State: clean

Richard Weinberger <richard@nod.at> writes:

> Hi!
>
> While toying around with CPU affinities I noticed that offlining a CPU
> triggers reliable a crash. Is this known?
>
> [   32.812858] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   32.812879] #PF: supervisor read access in kernel mode
> [   32.812881] #PF: error_code(0x0000) - not-present page
> [   32.812883] PGD 0 P4D 0 
> [   32.812886] Oops: Oops: 0000 [#1] SMP PTI IRQ_PIPELINE
> [   32.812892] CPU: 4 UID: 0 PID: 36 Comm: migration/4 Not tainted 6.17.0-g970519241701-dirty #38 PREEMPT(voluntary) 
> [   32.812896] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [   32.812898] IRQ stage: Linux
> [   32.812899] Stopper: multi_cpu_stop+0x0/0x110 <- __stop_cpus.constprop.0+0x79/0xc0
> [   32.812909] RIP: 0010:proxy_irq_handler+0x13/0x30
> [   32.812914] Code: 9d 5b e9 00 11 ee 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 05 6c 96 41 02 48 8b bf
> [   32.812917] RSP: 0018:ffff9dcf0018cfd0 EFLAGS: 00010287
> [   32.812920] RAX: ffff8fdea8989000 RBX: 0000000000000000 RCX: ffff8fde00e64108
> [   32.812922] RDX: ffff8fde00e64000 RSI: ffff8fde3bd1dac0 RDI: 0000000000000000
> [   32.812923] RBP: ffff8fde00ea6200 R08: ffff8fde00e64100 R09: 0000000000000000
> [   32.812938] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8fde00fad600
> [   32.812940] R13: 000000000000001b R14: ffff9dcf0005bd00 R15: 0000000000000004
> [   32.812947] FS:  0000000000000000(0000) GS:ffff8fdea8989000(0000) knlGS:0000000000000000
> [   32.812950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   32.812952] CR2: 0000000000000000 CR3: 0000000058a30000 CR4: 00000000000006f0
> [   32.812954] Call Trace:
> [   32.812976]  <IRQ>
> [   32.812978]  handle_synthetic_irq+0x9b/0x1b0
> [   32.812988]  arch_do_IRQ_pipelined+0x85/0x460
> [   32.812995]  </IRQ>
> [   32.812996]  <TASK>
> [   32.812999]  sync_current_irq_stage+0x159/0x160
> [   32.813003]  inband_irq_restore+0x5d/0x80
> [   32.813008]  multi_cpu_stop+0xdd/0x110

The crash above is a timer event still pending in the inband IRQ log
after the tick proxy was dismantled on that CPU, bad.

-- 
Philippe.
