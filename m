Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40C7EF
	for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 16:52:06 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id bf43so33945137lfb.6
        for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 08:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J7qEXIygJuLpJ365xq+Usa1WU+hFFRAzltePLFRBHzs=;
        b=cPPZ2ishSjtTr68+gmIWWQul0x0vuwFXQYVOMUdU5rQY1SZH/tDlqFRCnJqwWqOcC/
         oABbnWQ1tb53j/No08kVqOHUcrvJZtWL0qr8p4QefewAle5PtAzKfua0wdTUC56ubJjy
         53UTDc7xoKPzHaonLcNRkhiYbbhGYltoWEiAM1xLu318j+rbtR+VvYDI8yaIG5TbIL/j
         3tRNi+WAanrkf0HIQt97Y/WBlZdqPx6GyQH/Dkv/iuaOsMnvki/3k+2P6bri9X3AemxP
         IRyXA45If1pG7iEwTJtLt5xh8K/i71SukIEc/DZzBdy/cNAqPAcmYNfEWtf+8G43mZgy
         EXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7qEXIygJuLpJ365xq+Usa1WU+hFFRAzltePLFRBHzs=;
        b=TDaIWLbCpv2aUUyGPb+fZj2q+jxn62/r8K1znmZsdCgiZsEz+ZcHpm8zq3ChpCMpPj
         sa1vkVx0AgCSeJ31bYFl/y1ODOxw2kVU81mx6iyBnlSZWwS6l4xXlrVtW4/zaK80Loe8
         c7PQ6hTnEz5xUTe1EobP0pSVPKdmd50zCrom1e98sATRkIJfyWQhqw/937HYa+Bb55cd
         EBsUD2DXar9RyH6kyP2243tPPpc3OWTpyFnZ2ysMJYGzZOgfgUbdxfwE8SGbnYSCAv/Q
         VWuvWg40raEqbCcUsXKUT5XwM19TAaGv7gpFN4+hjqtOFF+SilhiGzjyHUjll2eYCEUJ
         6lgQ==
X-Gm-Message-State: AFqh2kpabVvUu/5Jd5LH7fyB2uh9l9fan2frd9ney/ZOIWl7VS6/Xnry
	nU3R9l8KFqvR/7mrIvOF9F/c2MS1m991rWyLL5k0Xg==
X-Google-Smtp-Source: AMrXdXv4IRfVvN4gl7Yt3ytnmm/Z9U/I3bpCrx8gtsjypA5ZvXmRI0z4nAaru/qQx6zhWTuBxPOX+JgnDSAUz2Gpkgk=
X-Received: by 2002:a05:6512:1196:b0:4cb:4350:94a3 with SMTP id
 g22-20020a056512119600b004cb435094a3mr3902325lfr.630.1673628724877; Fri, 13
 Jan 2023 08:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DB7PR10MB245971E67E0E4183BD4D4F5CECFD9@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
 <ed5d41d3-cadc-67dd-72b7-bbe680d36134@siemens.com>
In-Reply-To: <ed5d41d3-cadc-67dd-72b7-bbe680d36134@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 13 Jan 2023 11:51:53 -0500
Message-ID: <CALLqZ8SU192LLP+8noH1QeK1Djvi8E+xRi8r172pXhp99604eg@mail.gmail.com>
Subject: Re: Process hangs after upgrade
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 13, 2023 at 8:52 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 12.01.23 16:26, Schuman Eelco (DC-AE/ESW5) wrote:
> > Hi,
> >
> > I'm trying to upgrade a system from Linux 4.4 to v5.10.y-dovetail with Xenomai 3.2.2 on a Zynq 7000 ARMv7 board.
> > I'm seeing scheduling problems, e.g. sleep 1 does not finish.
> >
> > The IRQ pipeline torture tests run OK:
> > [    0.992675] Starting IRQ pipeline tests...
> > [    0.992687] IRQ pipeline: high-priority torture stage added.
> > [    1.005789] irq_pipeline-torture: CPU0 initiates stop_machine()
> > [    1.011772] irq_pipeline-torture: CPU1 responds to stop_machine()
> > [    1.021390] CPU1: proxy tick device registered (325.00MHz)
> > [    1.026881] CPU0: proxy tick device registered (325.00MHz)
> > [    1.035773] irq_pipeline-torture: CPU0: irq_work handled
> > [    1.041099] irq_pipeline-torture: CPU0: in-band->in-band irq_work trigger works
> > [    1.048430] irq_pipeline-torture: CPU0: stage escalation request works
> > [    1.048436] irq_pipeline-torture: CPU0: irq_work handled
> > [    1.060276] irq_pipeline-torture: CPU0: oob->in-band irq_work trigger works
> > [    2.113302] CPU1: proxy tick device unregistered
> > [    2.117930] CPU0: proxy tick device unregistered
> > [    2.126014] IRQ pipeline: torture stage removed.
> > [    2.130654] IRQ pipeline tests OK.
> >
> >
> > There is a warning in the kernel logs:
> >
> >      0.000000] ------------[ cut here ]------------
> > [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1742 irq_pipeline_init+0x20/0x84
>
> This complains that hard-IRQs would be on while they must not. All that
> in fairly early boot code.
>
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.157-xenomai #2
> > [    0.000000] Hardware name: Xilinx Zynq Platform
> > [    0.000000] IRQ stage: Linux
> > [    0.000000] [<c0014460>] (unwind_backtrace) from [<c0011400>] (show_stack+0x10/0x14)
> > [    0.000000] [<c0011400>] (show_stack) from [<c03aac8c>] (dump_stack+0xdc/0xfc)
> > [    0.000000] [<c03aac8c>] (dump_stack) from [<c03a7b08>] (__warn+0xa4/0xcc)
> > [    0.000000] [<c03a7b08>] (__warn) from [<c03a7ba8>] (warn_slowpath_fmt+0x78/0xb0)
> > [    0.000000] [<c03a7ba8>] (warn_slowpath_fmt) from [<c04d1e20>] (irq_pipeline_init+0x20/0x84)
> > [    0.000000] [<c04d1e20>] (irq_pipeline_init) from [<c04c6d4c>] (start_kernel+0x28c/0x4b8)
> > [    0.000000] [<c04c6d4c>] (start_kernel) from [<00000000>] (0x0)
> > [    0.000000] ---[ end trace 58996bc4bee07162 ]---
> > [    0.000000] IRQ pipeline enabled
> >
> > The system and applications run OK with only one core in use.
> >
> > Is there something missing in the Linux config or anything else I can try?
>
> Not sure. We don't have a Zynq in the test lab or at least as reference
> image here. It might be that dovetail is missing some bits for this SoC,
> e.g. a patch analogously to [1] for drivers/gpio/gpio-zynq.c. Adding
> Philippe for possibly more insights.
>
> ARM multi-core is generically fine, see our QEMU target
> (https://source.denx.de/Xenomai/xenomai-images/-/jobs/552798 e.g.). But
> our only physical armhf target in the lab is a single-core beaglebone.
>
> Jan
>
> [1]
> https://source.denx.de/Xenomai/linux-dovetail/-/commit/3d3e5a1659d69c9dc96471efa542dc05fcc58e56
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
>

If Philippe doesn't have time for an immediate answer I can try one of
my zynq boards this weekend.  I reserved some time for ipipe things, I
can add this to the list and see if I can help.

-Greg
