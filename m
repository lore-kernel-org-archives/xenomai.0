Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C721C19F
	for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578947; cv=none; b=K31V0+En8lAPmEAiXuaLLblevgP0IbrKsuTII223MwfawngC9wpEfVXg/2t1QE9VkRN5KsGRI+nKFvXh7r7wHaeeQOkVer2Ouq74dlZVVf7YxBwaiTnFNezXvOL6h3tZQ8PJHS+tDTE8G1IJ/shx/VIoT5n9sEC5yWQSUXF5OZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578947; c=relaxed/simple;
	bh=SCDz0wp5mhiBqkYAAQGApFuJ1YA/zFqHdljLLJFoIo4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=QxtOJ2tj57RY2ujQYKj1Xxhk90dpDUXbsA25bqXUu1wipPOzSxBwnUpNC9WFirShmfL1Z9DeYvlrHLMuo9CY8io5f22PniyCQLLPlCS46xeEuxilDVb73kDrq4r1T0ythvjiGVSn+oxq8azerzuRdsUdRq82RvtCLaEJkDkdf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VJ+U1FQJ; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VJ+U1FQJ"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202502261408536b7825fa0c94fdfc47
        for <xenomai@lists.linux.dev>;
        Wed, 26 Feb 2025 15:08:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=018bVP1atHhCkEFAYNwIcqRbuJP2pJXns1n6PDq4OEw=;
 b=VJ+U1FQJM0uy3jF2ic/5w8BzXOS0QkySr9O/eJNfyrR0uHj6Yx6/eBYtwS4OKRMFw7Cc4j
 bG3S4Y9vhmwtsTQZl8y/PeFZXvwb9UGg2KZgprT+7JhmkoflClot2I3UaIMhaDNoRSLk1iEw
 ZU+HTBmU++xXnK5KtRuuF2qNVHD0oRvbMyjqc9nJ6c0ZmKosLT/2iKwFr+DoJ1TeZ4eZjSh6
 njUlmgzJqS2mfzOTqcHZIY9qI9D0Ys1lkoarv81uNAwHUwwqFgrbRNmMcgA2aqy9iTnJqN26
 bR4qjTvZGKFrxYbrhz7qVH4P+SUIspOcBw0vVJkgAQ5jxMfXHS0uyMWg==;
Message-ID: <8ca54aaf8095e2a7df7197610642d778e8c8602c.camel@siemens.com>
Subject: Dovetail boot hang on x86, kvm
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 26 Feb 2025 15:08:52 +0100
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

Hi all,

Jan recently reported the following boot hang on his KVM system when
the host was running at high load:

[    0.005000] x2apic enabled
[    0.008000] APIC: Switched APIC routing to: cluster x2apic
[    0.009000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.012000] Kernel panic - not syncing: timer doesn't work through Inter=
rupt-remapped IO-APIC
[    0.012000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.8+ #13=
6
[    0.012000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[    0.012000] IRQ stage: Linux
[    0.012000] Call Trace:
[    0.012000]  <TASK>
[    0.012000]  dump_stack_lvl+0x8b/0xd0
[    0.012000]  panic+0x112/0x2e0
[    0.012000]  panic_if_irq_remap+0x19/0x20
[    0.012000]  check_timer+0x1fd/0x620
[    0.012000]  ? lock_release+0x214/0x2a0
[    0.012000]  setup_IO_APIC+0x17a/0x1d0
[    0.012000]  apic_intr_mode_init+0xd0/0xe0
[    0.012000]  x86_late_time_init+0x20/0x40
[    0.012000]  start_kernel+0x8d7/0x970
[    0.012000]  x86_64_start_reservations+0x20/0x20
[    0.012000]  x86_64_start_kernel+0x87/0x90
[    0.012000]  common_startup_64+0x13e/0x148
[    0.012000]  </TASK>

I revisited timer_irq_works() and friends, where the necessary Dovetail
specific changes are in place.

If my interpretation is correct the Dovetail enabled guest does not
receive a timer IRQ while making progress (reading TSC).

Is there something we could do? Seems the KVM (host) was too busy to
inject the timer IRQs and that this could happen on vanilla Linux the
same way...

Best regards,
Florian


