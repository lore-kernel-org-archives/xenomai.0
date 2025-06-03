Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99F26290
	for <xenomai@lists.linux.dev>; Tue,  3 Jun 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958940; cv=none; b=He+7F0zqyY6qJEgyJ1E3PQi4buh2m7830DCmkRHFxRPogvNQTGQqv8qu2qJqrRyb/PcByz+Za9Z3u+4iqShYli1NwJqb57XrozU6IVFYum3o1m8uS7c3/bU/5zLbeE7FnQo3Gx7k2Jg+6EEI/poLL7XwQ8K6IoMRHQfZV2X22Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958940; c=relaxed/simple;
	bh=Hodv3TleU2DK9wB5ghO/37vpIr2IVIzwqhQq1R2jiZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=moovaqmWAZn8KDcNPHG7VPPxpc5KBr0V7dWKRaO5Hq1aRYMydH3vyxNWEMVQC99yOX5Wd3JyQzRRq6L/fdKUbp29pZr2rNy+c2qAE/oUoQPGEv8o/RZUQTes5wbfAYLwl7CUYiLfax1vsPUxRLKTnP094q4H8OqlBkyj4tRdc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=kBWi5NhN; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="kBWi5NhN"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202506031355311b6db47fe39f5e7b4c
        for <xenomai@lists.linux.dev>;
        Tue, 03 Jun 2025 15:55:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=z1hffMgOWVTE5yjFJOeRpK+UzR50+vVSwXG1xxq8358=;
 b=kBWi5NhNYGSVpJCkJOBpAx34semtD6gnAFeoYdfidproO1+4Yza/mTOKlLokK8y7qOZkLZ
 PysxJpTMmKOAMSEWYU/dOzvSiptywtunsCrGC/NtaC4xT8w8HyjyKeG4EteGjvB0xiSqXYoC
 6wetnZgG6BOwAxy55I/0KYhjrcf+790hyuSPJRx596UPE9CF1/gw+NWi0W7KL57C0ssABh/6
 tQBFWXzqKqEXT+tiUbaxqM1fsf3ofPB6R2eYmSfYew/LWXMB5GIxzxSNwOWkikLfO2bj9+5V
 SmjSGgIrf7KlXwtsmzMqkL/dH35A83iqSj8w+J8d9+KSRse0CoG+qi3Q==;
Message-ID: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
Subject: Dovetail 6.15: x86: Invalid wait context
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 03 Jun 2025 15:55:30 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe,

the following is taken from our CI, testing Dovetail 6.15.
On x86 we have an invalid wait context reported:

[  151.574032]=20
[  151.574039] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  151.574043] [ BUG: Invalid wait context ]
[  151.574046] 6.15.0 #1 Not tainted
[  151.574048] -----------------------------
[  151.574048] swapper/0/0 is trying to lock:
[  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake_up+=
0x21/0x60
[  151.574063] other info that might help us debug this:
[  151.574064] context-{2:2}
[  151.574065] no locks held by swapper/0/0.
[  151.574066] stack backtrace:
[  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 #1 P=
REEMPT(full)=20
[  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
6.3-debian-1.16.3-2~bpo12+1 04/01/2014
[  151.574079] IRQ stage: Linux
[  151.574083] Call Trace:
[  151.574086]  <IRQ>
[  151.574088]  dump_stack_lvl+0x79/0xe0
[  151.574095]  __lock_acquire+0x942/0xbf0
[  151.574104]  lock_acquire+0xe2/0x2f0
[  151.574107]  ? __wake_up+0x21/0x60
[  151.574111]  ? find_held_lock+0x2b/0x80
[  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
[  151.574120]  ? __wake_up+0x21/0x60
[  151.574122]  __wake_up+0x21/0x60
[  151.574125]  xnpipe_wakeup_proc+0x152/0x590
[  151.574132]  handle_synthetic_irq+0xc2/0x250
[  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
[  151.574141]  </IRQ>
[  151.574142]  <TASK>
[  151.574144]  sync_current_irq_stage+0xaa/0x110
[  151.574147]  inband_irq_enable+0x42/0x60
[  151.574151]  cpuidle_idle_call+0x17d/0x200
[  151.574155]  do_idle+0x89/0xd0
[  151.574158]  cpu_startup_entry+0x29/0x30
[  151.574160]  rest_init+0xf0/0x190
[  151.574164]  start_kernel+0x632/0x700
[  151.574179]  x86_64_start_reservations+0x18/0x30
[  151.574185]  x86_64_start_kernel+0x78/0x80
[  151.574188]  common_startup_64+0x13e/0x148
[  151.574198]  </TASK>

That seems to be triggered by the Xenomai 3 smokey testsuite.

Any ideas?

armhf/arm64 seem to be fine.

Best regards,
Florian
