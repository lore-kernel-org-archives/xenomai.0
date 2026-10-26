Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025361;
	b=UOJ5ky6iWk6GxYEOtKPmzcAsdvl/DENqEJtGNCueQVTQrrDtJB6HyqXh56MJsotKbkGZ
	 u5htZS/gialLOIV3YCUe3vDRF/nJjtKiI7YZtud6gRngr7MB6pMySH/IFlzEFB57C85N0
	 Ir2fbkZBWpfOHfdCRDVOaGmcKAIa08LKxjqQ/j+b468lhymMCalmWmGln2q3FjfKcjiV7
	 VQLWY7hFqXU+uDEQMc99Ta8bj8rqbz3PLChHXry7MJhAgI0QKobokXiuylvb/WkYaCOx7
	 J/FrhECKxvFmt3RGPPGD9hPdEbRoUdq+NGUUo5L8eBSj3oo01/J35mfnoYtMPFvJacw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025361;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-Flowmailer-Platform:Feedback-ID;
	bh=gYo5hvrOtFD4FjNy5jpzv/QRZRGIiBO6pW5qaAuGW8Y=;
	b=Alv7Mee4Qj6rheszTB8pKHdtjvCudD+NwQ/BHCejGCj40RxarISYR9/fq13p8mtywFjc
	 B/cwk70mnRukuDuPhbEo+EsB50wEpC0sNbDkkRG8jkYzKItixSSBwz2pIld3FmdCd7q3q
	 L0zayQJ8RLf9Kr1lvNGJIsdo3IQk0Bpsrd+s3K8+rDA7k1490tZ2o1YvB4q+S9hTm65/m
	 HTpEEqtJY4yac4XeZd21OCgbUWhCv3zL4vpmcJBVM218ptCb5JRVr26l4sf/QjQ6rV7hM
	 KnSIo9wt0fBB3fylhwPNIQ+6GXpeQ7rh/EcwoMITdS6Fyc3bY+MYsXlrqJyQF5twBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=OFahomMP;
	arc=none smtp.remote-ip=185.136.64.228
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC7606A31A
	for <xenomai@lists.linux.dev>; Mon, 26 Oct 2026 14:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66CC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=OFahomMP
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20261026143550d89a79dede000207ac
        for <xenomai@lists.linux.dev>;
        Mon, 26 Oct 2026 15:35:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gYo5hvrOtFD4FjNy5jpzv/QRZRGIiBO6pW5qaAuGW8Y=;
 b=OFahomMPxRHCo+89jH2AJiAZvGHj5eQcug1JrPoxLPUjOrHNo+pRDSSJIF0X01BCgzdL36
 ltMsrPj64fINR4sB1cL0eyt571t6GVPQdG6bsHdQG2nfc4F9CRFdBldIY7e6SawYpCrpEolT
 ySpuaZ/N/zjBoS2k2jaaEojVVWb8eb5ygkor9QiSji6HPaQwl18fiqfxcq/z1j0EH1oivOuN
 YZdMfEQvfcJBNR9jRS4Kuu/28+BRise75FNo7QLfhXNhsSmNfDn3ln/1JYznp5f5jSeSZc2d
 hP2yUdeOTPcm+FL86wbDNo1M1RTbJqErDKMaGQPM4BTsWg+aZprRghag==;
Message-ID: <eec03efd38a42874e7ff4c7fca7246208e49ef03.camel@siemens.com>
Subject: Dovetail 7.3 release candidate available
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Date: Mon, 26 Oct 2026 15:35:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

I just pushed a first Dovetail release candidate based on Linux 7.3 to
the repository. The release candidate is available in the=C2=A0

    wip/flo/v7.3-dovetail-rebase

branch.

Please test this release candidate as much as you can. If you plan to
use that release in production: Let us know. We did not decide on
Dovetail=20

Main necessary adjustments - specific to Linux 7.3:

    - The preemption counter run out of space. We can no longer place
      the Dovetail specific IRQ stage and OOB flags there. Those flags=20
      are now located in the arch specific struct thread_info
      structures.

      See some notes in the "review hints" section below.

    - As a consequence the Dovetail specific HAVE_PERCPU_PREEMPT_COUNT
      configuration option has been removed completely.

The following tests were already done, more testing necessary:

    - All Xenomai 3 supported architectures (arm, arm64, x86):
      Build tests (all off, PIPELINE, PIPELINE+Dovetail): success
      Xenomai 3 CI testsuite: success (virtual targets only so far)

    - Xenomai 3 testsuite on Hyper-V: success

    - riscv: Build tests: success
             (all off, PIPELINE, PIPELINE+Dovetail)


Known (minor) issues:

    - Build warnings around noinstr:
      vmlinux.o: warning: objtool: inband_irq_disable+0x0: call to check_in=
band_stage() leaves .noinstr.text section
      vmlinux.o: warning: objtool: inband_irq_enable+0x11: call to check_in=
band_stage() leaves .noinstr.text section
      vmlinux.o: warning: objtool: ct_idle_exit+0x1: call to inband_irq_sav=
e() leaves .noinstr.text section

Missing / next steps:

    - Expect a final history (git commit) cleanup
    - Move to final branch (most likely v7.3.y-dovetail-rebase)
    - Rebase evl
    - riscv: Run the Xenomai 4 testsuite (once evl has been rebased)

Review hints:

    - The new API replacing the preemption counter resides in
      include/dovetail/thread_info_accessors.h and consists of

      - pipeline_enter(void);
      - pipeline_leave(void);
      - pipeline_oob_stage_enter(void);
      - pipeline_oob_stage_leave(void);
      - in_pipeline(void);
      - running_inband(void);
      - running_oob(void);

      I really hope that I chose suitable names...

    - Files manually touched during (multiple) rebase operations:
      	arch/riscv/include/asm/syscall.h
	arch/riscv/kernel/traps.c
	arch/x86/entry/syscall_32.c
	arch/x86/entry/syscall_64.c
	arch/x86/include/asm/idtentry.h
	arch/x86/include/asm/thread_info.h
	arch/x86/kernel/fpu/core.c
	arch/x86/kvm/x86.c
	drivers/base/regmap/regmap-irq.c
	drivers/clocksource/hyperv_timer.c.
	drivers/mailbox/qcom-ipcc.c
	drivers/spi/spi.c
	drivers/tty/serial/8250/8250_core.c
	include/dovetail/thread_info.h
	include/linux/dmaengine.h
	include/linux/entry-common.h
	include/linux/gfp.h
	include/linux/preempt.h
	include/linux/spinlock.h
	include/linux/spinlock_api_up.h
	kernel/irq/Kconfig
	kernel/locking/lockdep.c
	kernel/printk/printk.c
	lib/vdso/Kconfig
	net/core/page_pool.c
	net/socket.c

That said: Happy testing! Feedback highly appreciated.

Best regards,
Florian

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

