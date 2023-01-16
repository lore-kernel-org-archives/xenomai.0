Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECC6FB7
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 20:26:37 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id bf43so44209759lfb.6
        for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KOkAeBDkc3BBCByF99hdajGzyKYs9Rf177gTLMYmR04=;
        b=KEB6KbANOPDg2MO1TIvuHI6s3kKEPDswgSw7bpBa8ISRe5GazQ8utNXMb3aqo7x9uy
         139OOoBUUU8DkbykuNOcNkOH/uhREk7utXVwFM4o8ZQLuj559VnRgoZX5eLnRDO+cDgM
         J0RbS39n/lVf7XbrMLGspi+kpl48UJS1F/lz3f8uUuT8pyPvn8f2ftZpzeryhWCaSo7j
         SG/yndkfwaF6J/FoStmwGeLsjlrwrDVth/PKLAJQSL2ObLjnbpIyINjrLgaa5t3EZk8U
         ip48vNvNpAvTZR8EScqBEDlCNRJu/HFofmIBbP9qmRn7mjnvTUXw5vEq9Zlqv4PpxxIU
         sdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOkAeBDkc3BBCByF99hdajGzyKYs9Rf177gTLMYmR04=;
        b=q0SuTlAbDV0RTizQ/IPy0DGNPjuqc7gwuRfKOepWU5zj7wE4MsT0vuPsFSaovQdfuq
         bbYmdrab3WF3PMj+Nl7C4k8rEPuR1rlUbZZ2g/r7D8hGzdQ9dJFlHBtjsEXdPQU/gL63
         beYE93PsNYCMivfn8hBjUpX8v9vroVgmIU1tVgWe86nfW6gabJaeWH2tpKLPPJk5Rc1n
         KG1bdFOZYvVW4phBgnVejz6VVCTJzC46TU/BU2SO6/Kl6jJWQwERRXkxFAYywNTgs0V0
         Zs5iVUQisJbDny3ENTfREzGeP9h1I1xvCq14OH4NzxnGxoDAHejmRwoFAl+vIo3VJUOF
         2bSw==
X-Gm-Message-State: AFqh2krcfAxCVYTcZkz+KAQkBEFY2CICfEwd2YxUvzQ9U/ippTBMdArx
	0w0MKFCtMg+i4nU5edk4di2wnGjsYfMiw48DrBZr8w==
X-Google-Smtp-Source: AMrXdXuLmHyU+crDvSXUjB3gk+ttnUtJtXvrcYnf1c80f/mpFs1VteuwWW3WfyZ0MCxsEObFQ0TY701t0ShZ2DG+cws=
X-Received: by 2002:ac2:54b0:0:b0:4c1:aad6:2f9f with SMTP id
 w16-20020ac254b0000000b004c1aad62f9fmr16994lfk.683.1673900795667; Mon, 16 Jan
 2023 12:26:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DB7PR10MB245971E67E0E4183BD4D4F5CECFD9@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
 <ed5d41d3-cadc-67dd-72b7-bbe680d36134@siemens.com> <CALLqZ8SU192LLP+8noH1QeK1Djvi8E+xRi8r172pXhp99604eg@mail.gmail.com>
 <b401122e-7d0d-b63a-2689-81bd4284af8b@siemens.com>
In-Reply-To: <b401122e-7d0d-b63a-2689-81bd4284af8b@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 16 Jan 2023 15:26:24 -0500
Message-ID: <CALLqZ8T1s9KN_s0=5u0=up-8E-KLx0L0rbRK=zZT4ybc4B9i0A@mail.gmail.com>
Subject: Re: Process hangs after upgrade
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 13, 2023 at 12:15 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 13.01.23 17:51, Greg Gallagher wrote:
> > On Fri, Jan 13, 2023 at 8:52 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 12.01.23 16:26, Schuman Eelco (DC-AE/ESW5) wrote:
> >>> Hi,
> >>>
> >>> I'm trying to upgrade a system from Linux 4.4 to v5.10.y-dovetail with Xenomai 3.2.2 on a Zynq 7000 ARMv7 board.
> >>> I'm seeing scheduling problems, e.g. sleep 1 does not finish.
> >>>
> >>> The IRQ pipeline torture tests run OK:
> >>> [    0.992675] Starting IRQ pipeline tests...
> >>> [    0.992687] IRQ pipeline: high-priority torture stage added.
> >>> [    1.005789] irq_pipeline-torture: CPU0 initiates stop_machine()
> >>> [    1.011772] irq_pipeline-torture: CPU1 responds to stop_machine()
> >>> [    1.021390] CPU1: proxy tick device registered (325.00MHz)
> >>> [    1.026881] CPU0: proxy tick device registered (325.00MHz)
> >>> [    1.035773] irq_pipeline-torture: CPU0: irq_work handled
> >>> [    1.041099] irq_pipeline-torture: CPU0: in-band->in-band irq_work trigger works
> >>> [    1.048430] irq_pipeline-torture: CPU0: stage escalation request works
> >>> [    1.048436] irq_pipeline-torture: CPU0: irq_work handled
> >>> [    1.060276] irq_pipeline-torture: CPU0: oob->in-band irq_work trigger works
> >>> [    2.113302] CPU1: proxy tick device unregistered
> >>> [    2.117930] CPU0: proxy tick device unregistered
> >>> [    2.126014] IRQ pipeline: torture stage removed.
> >>> [    2.130654] IRQ pipeline tests OK.
> >>>
> >>>
> >>> There is a warning in the kernel logs:
> >>>
> >>>      0.000000] ------------[ cut here ]------------
> >>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1742 irq_pipeline_init+0x20/0x84
> >>
> >> This complains that hard-IRQs would be on while they must not. All that
> >> in fairly early boot code.
> >>
> >>> [    0.000000] Modules linked in:
> >>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.157-xenomai #2
> >>> [    0.000000] Hardware name: Xilinx Zynq Platform
> >>> [    0.000000] IRQ stage: Linux
> >>> [    0.000000] [<c0014460>] (unwind_backtrace) from [<c0011400>] (show_stack+0x10/0x14)
> >>> [    0.000000] [<c0011400>] (show_stack) from [<c03aac8c>] (dump_stack+0xdc/0xfc)
> >>> [    0.000000] [<c03aac8c>] (dump_stack) from [<c03a7b08>] (__warn+0xa4/0xcc)
> >>> [    0.000000] [<c03a7b08>] (__warn) from [<c03a7ba8>] (warn_slowpath_fmt+0x78/0xb0)
> >>> [    0.000000] [<c03a7ba8>] (warn_slowpath_fmt) from [<c04d1e20>] (irq_pipeline_init+0x20/0x84)
> >>> [    0.000000] [<c04d1e20>] (irq_pipeline_init) from [<c04c6d4c>] (start_kernel+0x28c/0x4b8)
> >>> [    0.000000] [<c04c6d4c>] (start_kernel) from [<00000000>] (0x0)
> >>> [    0.000000] ---[ end trace 58996bc4bee07162 ]---
> >>> [    0.000000] IRQ pipeline enabled
> >>>
> >>> The system and applications run OK with only one core in use.
> >>>
> >>> Is there something missing in the Linux config or anything else I can try?
> >>
> >> Not sure. We don't have a Zynq in the test lab or at least as reference
> >> image here. It might be that dovetail is missing some bits for this SoC,
> >> e.g. a patch analogously to [1] for drivers/gpio/gpio-zynq.c. Adding
> >> Philippe for possibly more insights.
> >>
> >> ARM multi-core is generically fine, see our QEMU target
> >> (https://source.denx.de/Xenomai/xenomai-images/-/jobs/552798 e.g.). But
> >> our only physical armhf target in the lab is a single-core beaglebone.
> >>
> >> Jan
> >>
> >> [1]
> >> https://source.denx.de/Xenomai/linux-dovetail/-/commit/3d3e5a1659d69c9dc96471efa542dc05fcc58e56
> >>
> >> --
> >> Siemens AG, Technology
> >> Competence Center Embedded Linux
> >>
> >>
> >
> > If Philippe doesn't have time for an immediate answer I can try one of
> > my zynq boards this weekend.  I reserved some time for ipipe things, I
> > can add this to the list and see if I can help.
>
> That would be great! I have one zync board literally at my feet as well,
> but setting all that up will take the usual time...
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>

I reproduced the issue (pretty sure), I can look at it this week if
that helps.  Just to confirm, Eelco, to reproduce I can create a
thread and call sleep(1) and I should see the process hang?

-Greg
