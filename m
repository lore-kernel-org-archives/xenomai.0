Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCFD532
	for <xenomai@lists.linux.dev>; Tue, 17 Jan 2023 19:28:13 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id br9so13267579lfb.4
        for <xenomai@lists.linux.dev>; Tue, 17 Jan 2023 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD5Yh5P1g2c3H9f8wpDL9FKT4Suuo71tEqHZQQOKgvk=;
        b=1e/9EreBPSDJUtHJ72YIlOa7xFL6adL135fwqqxe0izUxa4io6lufgdT4ma0C9HQOB
         CDcaKI1Is2OH+mF4gFxDUKLkU5KplrowlFudyidvGKaZgxZGI5FBl5q5Jlo5X+xFNW5a
         5VEnINZ2RU6sB4qm+T3li8Fw7r/vTB4nDjxsnOAaAmnr/Me4Wkov5Dusp1yMaYMwoKj6
         QH4quiBtShYelx4JgDAhc9y+Bo9YnuGF6rzg/q3HLJoUQpyrHTwr6zf6sqN4WNqSKpl1
         s1wvH7znwS1eogtSo7Sxrs4B1E2/UThR8xLH/YeGnNpVvkgGg+XC6cS9SKnbCxSGmp/u
         OWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD5Yh5P1g2c3H9f8wpDL9FKT4Suuo71tEqHZQQOKgvk=;
        b=pqE16XFMbEjK0pVMLV5yMOBP9Y1GnoSi/Oz/av8VdYFSnhxaBgCkc/KlIVkZnUfp8G
         UeW7Is0mvXIQNTXiKKEIjH41UjvuQZPklG3HRwIE4+XvrBB03Yvr217xCqNmv15vBii8
         REC1OS+TRugP9lRVVZTxItdw/klf6OW87gOogsRad59Pq8u2Ex7Q9Ct6jkMkzk1vH+vd
         bH6mCOXObS8z7GzmCluhscK71O1Oes9vyCs0XEj4d19A2hz91pFBh7u0QlV+a6A9vAbB
         3hzZSABUpj6uGvr0A3sSqZbG/RonJs1x0HPQw36bauqVdUriKTJ4E+4KyOOnEjP98SYj
         qBsQ==
X-Gm-Message-State: AFqh2krRP+i0fqDTh6Q09Ef7MEaHW2RoyXkUV8LTfx5X4pewb/HS/uVn
	9IyGrrUfVd1VKs1nCX3f7U3y4l1ty8G4ZkZ8WjHuyKhfH3lN2Q==
X-Google-Smtp-Source: AMrXdXtLrmgMAoYJUi9UwU6eArDQGaKNjq5aLTUE5UkurRjLNymNE3TTVaxG+h5DYOuqBfpN6RUVuVW4Ye+GZyeudjs=
X-Received: by 2002:ac2:43a6:0:b0:4cc:80bb:802a with SMTP id
 t6-20020ac243a6000000b004cc80bb802amr246612lfl.658.1673983691597; Tue, 17 Jan
 2023 11:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DB7PR10MB245971E67E0E4183BD4D4F5CECFD9@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
 <ed5d41d3-cadc-67dd-72b7-bbe680d36134@siemens.com> <CALLqZ8SU192LLP+8noH1QeK1Djvi8E+xRi8r172pXhp99604eg@mail.gmail.com>
 <b401122e-7d0d-b63a-2689-81bd4284af8b@siemens.com> <CALLqZ8T1s9KN_s0=5u0=up-8E-KLx0L0rbRK=zZT4ybc4B9i0A@mail.gmail.com>
 <DB7PR10MB245911DDA609584F8C2682D1ECC69@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB7PR10MB245911DDA609584F8C2682D1ECC69@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 17 Jan 2023 14:28:00 -0500
Message-ID: <CALLqZ8RMnou=0s-2Hcq-Xm5R7j3HVYNbN=aMHCPcHzY6ZfPJGg@mail.gmail.com>
Subject: Re: Process hangs after upgrade
To: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2023 at 12:03 PM Schuman Eelco (DC-AE/ESW5)
<Eelco.Schuman@boschrexroth.nl> wrote:
>
> > On Fri, Jan 13, 2023 at 12:15 PM Jan Kiszka <jan.kiszka@siemens.com> wr=
ote:
> > >
> > > On 13.01.23 17:51, Greg Gallagher wrote:
> > > On Fri, Jan 13, 2023 at 8:52 AM Jan Kiszka <jan.kiszka@siemens.com> w=
rote:
> > > >
> >> > > On 12.01.23 16:26, Schuman Eelco (DC-AE/ESW5) wrote:
> >> >>> Hi,
> >> >>>
> >> >>> I'm trying to upgrade a system from Linux 4.4 to v5.10.y-dovetail =
with Xenomai 3.2.2 on a Zynq 7000 ARMv7 board.
> >> >>> I'm seeing scheduling problems, e.g. sleep 1 does not finish.
> >> >>>
> >> >>> The IRQ pipeline torture tests run OK:
> >> >>> [    0.992675] Starting IRQ pipeline tests...
> >> >>> [    0.992687] IRQ pipeline: high-priority torture stage added.
> >> >>> [    1.005789] irq_pipeline-torture: CPU0 initiates stop_machine()
> >> >>> [    1.011772] irq_pipeline-torture: CPU1 responds to stop_machine=
()
> >> >>> [    1.021390] CPU1: proxy tick device registered (325.00MHz)
> >> >>> [    1.026881] CPU0: proxy tick device registered (325.00MHz)
> >> >>> [    1.035773] irq_pipeline-torture: CPU0: irq_work handled
> >> >>> [    1.041099] irq_pipeline-torture: CPU0: in-band->in-band irq_wo=
rk trigger works
> >> >>> [    1.048430] irq_pipeline-torture: CPU0: stage escalation reques=
t works
> >> >>> [    1.048436] irq_pipeline-torture: CPU0: irq_work handled
> >> >>> [    1.060276] irq_pipeline-torture: CPU0: oob->in-band irq_work t=
rigger works
> >> >>> [    2.113302] CPU1: proxy tick device unregistered
> >> >>> [    2.117930] CPU0: proxy tick device unregistered
> >> >>> [    2.126014] IRQ pipeline: torture stage removed.
> >> >>> [    2.130654] IRQ pipeline tests OK.
> >> >>>
> >> >>>
> >> >>> There is a warning in the kernel logs:
> >> >>>
> >> >>>      0.000000] ------------[ cut here ]------------
> >> >>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:174=
2 irq_pipeline_init+0x20/0x84
> >> >>
> >> >> This complains that hard-IRQs would be on while they must not. All
> >> >> that in fairly early boot code.
> >> >>
> >> >>> [    0.000000] Modules linked in:
> >> >>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.157-=
xenomai #2
> >> >>> [    0.000000] Hardware name: Xilinx Zynq Platform
> >> >>> [    0.000000] IRQ stage: Linux
> >> >>> [    0.000000] [<c0014460>] (unwind_backtrace) from [<c0011400>] (=
show_stack+0x10/0x14)
> >> >>> [    0.000000] [<c0011400>] (show_stack) from [<c03aac8c>] (dump_s=
tack+0xdc/0xfc)
> >> >>> [    0.000000] [<c03aac8c>] (dump_stack) from [<c03a7b08>] (__warn=
+0xa4/0xcc)
> >> >>> [    0.000000] [<c03a7b08>] (__warn) from [<c03a7ba8>] (warn_slowp=
ath_fmt+0x78/0xb0)
> >> >>> [    0.000000] [<c03a7ba8>] (warn_slowpath_fmt) from [<c04d1e20>] =
(irq_pipeline_init+0x20/0x84)
> >> >>> [    0.000000] [<c04d1e20>] (irq_pipeline_init) from [<c04c6d4c>] =
(start_kernel+0x28c/0x4b8)
> >> >>> [    0.000000] [<c04c6d4c>] (start_kernel) from [<00000000>] (0x0)
> >> >>> [    0.000000] ---[ end trace 58996bc4bee07162 ]---
> >> >>> [    0.000000] IRQ pipeline enabled
> >> >>>
> >> >>> The system and applications run OK with only one core in use.
> >> >>>
> >> >>> Is there something missing in the Linux config or anything else I =
can try?
> >> >>
> >> >> Not sure. We don't have a Zynq in the test lab or at least as
> >> >> reference image here. It might be that dovetail is missing some
> >> >> bits for this SoC, e.g. a patch analogously to [1] for
> >> >> drivers/gpio/gpio-zynq.c. Adding Philippe for possibly more insight=
s.
> >> >>
> >> >> ARM multi-core is generically fine, see our QEMU target
> >> >> (https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2F
> >> >> source.denx.de%2FXenomai%2Fxenomai-images%2F-%2Fjobs%2F552798&data=
=3D05%7C01%7CEelco.Schuman%40boschrexroth.nl%7Cbde2fcb830c7453eb24e08daf7ff=
f75c%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638094975982300406%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DX9HSPXZaFPte2sxFfS5OTd683dFqMhWRpRcGXX%2F=
tRDg%3D&reserved=3D0 e.g.). But our only physical armhf target in the lab i=
s a single-core beaglebone.
> >> >>
> >> >> Jan
> >> >>
> >> >> [1]
> >> >> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fs
> >> >> ource.denx.de%2FXenomai%2Flinux-dovetail%2F-%2Fcommit%2F3d3e5a1659d
> >> >> 69c9dc96471efa542dc05fcc58e56&data=3D05%7C01%7CEelco.Schuman%40bosc=
hr
> >> >> exroth.nl%7Cbde2fcb830c7453eb24e08daf7fff75c%7C0ae51e1907c84e4bbb6d
> >> >> 648ee58410f4%7C0%7C0%7C638094975982300406%7CUnknown%7CTWFpbGZsb3d8e
> >> >> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> >> >> C3000%7C%7C%7C&sdata=3DOwo4KNn2Bo6r8yKJaI0ZrJNKTQ7woM4eOjYCb74M6ZA%=
3D
> >> >> &reserved=3D0
> >> >>
> >> >> --
> >> >> Siemens AG, Technology
> >> >> Competence Center Embedded Linux
> >> >>
> >> >>
> >> >>
> >> > If Philippe doesn't have time for an immediate answer I can try one
> >> > of my zynq boards this weekend.  I reserved some time for ipipe
> >> > things, I can add this to the list and see if I can help.
> >>
> >> That would be great! I have one zync board literally at my feet as
> >> well, but setting all that up will take the usual time...
> >>
> >> Jan
> >>
> >> --
> >> Siemens AG, Technology
> >> Competence Center Embedded Linux
> >>
> >
> >I reproduced the issue (pretty sure), I can look at it this week if that=
 helps.  Just to confirm, Eelco, to reproduce I can create a thread and cal=
l sleep(1) and I should see the process hang?
> >
> >-Greg
>
>
> Hi Greg, many thanks for looking at this issue. Yes, a 'sleep(1)' in an a=
pplication or thread hangs the process.  I noticed that the proxy tick does=
 not get any interrupts:
>
>           CPU0       CPU1
>  24:          0          5     SIRQC  24 Edge          in-band work
>  25:          0          0     GIC-0  27 Edge          gt
>  26:      94785      94399     GIC-0  29 Edge     oob  twd
>  27:          0          0     GIC-0  37 Level         arm-pmu
>  28:          0          0     GIC-0  38 Level         arm-pmu
>  29:         43          0     GIC-0  39 Level         f8007100.adc
>  32:          0          0     GIC-0  45 Level         f8003000.dmac
>  33:          0          0     GIC-0  46 Level         f8003000.dmac
>  34:          0          0     GIC-0  47 Level         f8003000.dmac
>  35:          0          0     GIC-0  48 Level         f8003000.dmac
>  36:          0          0     GIC-0  49 Level         f8003000.dmac
>  37:          0          0     GIC-0  72 Level         f8003000.dmac
>  38:          0          0     GIC-0  73 Level         f8003000.dmac
>  39:          0          0     GIC-0  74 Level         f8003000.dmac
>  40:          0          0     GIC-0  75 Level         f8003000.dmac
>  41:          0          0     GIC-0  54 Level         eth0
>  43:       2840          0     GIC-0  57 Level         cdns-i2c
>  45:        463          0     GIC-0  59 Level         xuartps
>  46:          0          0     GIC-0  64 Level    oob  [nyce-kmod]
>  48:          0          0     SIRQC  48 Edge          Inband sirq
>  49:          0          0     SIRQC  49 Edge          Inband sirq
>  50:          0          0     SIRQC  50 Edge          Inband sirq
>  51:          0          0     SIRQC  51 Edge          proxy tick
> IPI0:          0          0  CPU wakeup interrupts
> IPI1:          0          0  Timer broadcast interrupts
> IPI2:        321        528  Rescheduling interrupts
> IPI3:          5          2  Function call interrupts
> IPI4:          0          0  CPU stop interrupts
> IPI5:          0          0  IRQ work interrupts
> IPI6:          0          0  completion interrupts
>
> Is this because xnintr_host_tick() is not called, e.g. from xnintr_core_c=
lock_handler() ?
>
>
> Best regards,
>
> Eelco
>
>
I would start looking there, that looks suspicious to me.  Prior to
the sleep() call proxy tick does get interrupts?

-Greg
