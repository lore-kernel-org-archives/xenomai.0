Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33B5C8F
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:04:07 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id B33EFE0008
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:03:58 +0000 (UTC)
X-Envelope-To: rpm@xenomai.org
X-Envelope-To: xenomai@xenomai.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 751CEAC003C;
	Thu, 18 Aug 2022 07:03:57 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id d71so597686pgc.13;
        Thu, 18 Aug 2022 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ZnCc7DcRu94D1RWUqeNzgN78aBqhGwxMHgjnwwPvdyc=;
        b=bNtRhKtU8iqMdK5esVW+6lOm+hkxda3uyN19tKnXjC1IOLbAHQVASd97oQELkje2NX
         g92EJS9W6JNMoKq9qIM8ngucjHaG9hI6TNdupnC52A4EduSoN7AmKBtHFO5xUaekxeuC
         NqOX5COjGdYlIib53fMiZNaGdQ/ZNkdgnEJY9Igg8XeDnpjtUAEo6m4GeEsHtGF+yibt
         RNJI35hTk8pNSfVQ+Xyn4S0Kf6wvvrDqIL2sFsHOV4J374uH5qnlyDZN07j8syZKD/8J
         h0RPq8sf8W7bIPVsTl+MSen4cVewHQ6JXNBVSWq1Aa5MJx09cU4RkVZj6ZVyZ4war6bd
         GgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ZnCc7DcRu94D1RWUqeNzgN78aBqhGwxMHgjnwwPvdyc=;
        b=CJPv4qAVcbRu9VY4ntM0NJcf6+JvGCQNoRrd2EddqTioKbl+i4XU0eb8wQvtiPM2rM
         wqFB0Tl0bSje3JSlUqtgV7jOcq7BdQkQmBfhl1V5TnLrWAnSrTfUDaOaTLL3bLd4Jo/0
         wgaU4iJ1RJW+UF7iEi77ihG+CAS6gEDamg4IEkKGo/0n2dyY6JCinN6PclloYM4EebDJ
         /d+0nE99IVWqFRcz5tjNWYYCyT/OLd/L3kkoobjNMJ68GiVp9xOXzdDajg3wZ/yNzRZj
         fmFQFyZCco4GILNqRcw52WdBBUW6vTjmzkSRS6/xD/eSvebNI+u18JAm1qXaUDovr97n
         cHkg==
X-Gm-Message-State: ACgBeo1f88QNvHkIviIvreFQPxOXAxtxEsHgXdC7uhejIonHaqJ8zV+8
	7VV31u3zgzCO6XtDyI6VDflMNMfHv6dOy9F1OAgVEGoSxnk=
X-Google-Smtp-Source: AA6agR47ExHkPNy87Efe5WYDzwpW+HYGHWnnrik0MYPoqD79tj1+W8tXIo8Iki3ATEV+jjy5Ki9lODgEaFKydqonwwM=
X-Received: by 2002:a63:1202:0:b0:427:7f15:4711 with SMTP id
 h2-20020a631202000000b004277f154711mr1472162pgl.550.1660806235985; Thu, 18
 Aug 2022 00:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAGjgvr9G4JpZ+krfnX9xWwbTiT6JbtG_2jUWiFJyqVtvFk=MKg@mail.gmail.com>
 <646b8cce-c73e-4976-3787-b3b337679915@siemens.com> <87zgg5iyys.fsf@xenomai.org>
In-Reply-To: <87zgg5iyys.fsf@xenomai.org>
From: Yucong Chen <slaoub@gmail.com>
Date: Thu, 18 Aug 2022 15:03:44 +0800
Message-ID: <CAGjgvr97PJjQ38XB7KbrWPx+pBMCWGxgLwDz7+B--TwdO-cM8Q@mail.gmail.com>
Subject: Re: Linux-xenomai hangs at "Starting kernel ..." on Jetson TX1
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, jonathanh@nvidia.com, 
	josephl@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass (spool3: domain of gmail.com designates 209.85.215.171 as permitted sender) client-ip=209.85.215.171; envelope-from=slaoub@gmail.com; helo=mail-pg1-f171.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=bNtRhKtU;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (spool.mail.gandi.net: domain of slaoub@gmail.com designates 209.85.215.171 as permitted sender) smtp.mailfrom=slaoub@gmail.com

Hi all,
The problem running xenomai on Jetson TX1 has been resolved.
The problem is with a patch submitted in February 2019.
Specific information is as follows::
    arm64: tegra: Fix timer node for Tegra210
    commit d9931a1869fbd9d59bee30ef49d2356b468cdf47
I rolled back the DTS file modified by the patch, and then the
Linux kernel with xenomai enabled can start smoothly.

thx=EF=BC=81
   cyc

On Mon, 15 Aug 2022 at 18:27, Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
> > On 11.08.22 11:03, Yucong Chen wrote:
> >> Hi all,
> >> I'm very sorry to bother you, I'm currently working on xenomai
> >> evaluation, mainly to observe the real-time performance of xenomai on
> >> different hardware platforms. Recently, I encountered some problems
> >> when porting Xenomai to Nvidia Jetson TX1. We tried for a while and
> >> couldn't locate the problem, so please help me analyze the root cause
> >> of the following problems. The specific problem is described as
> >> follows:
> >>        1. Kernel version: 5.15-dovetail,
> >> https://source.denx.de/Xenomai/linux-dovetail
> >>        2. Compile the kernel method:
> >> https://elinux.org/Jetson/TX1_Upstream_Kernel
> >>        3. The kernel of 5.15-dovetail can be successfully started, but
> >> xenomai is not enabled, and the dtb file in the 5.15-dovetail
> >> directory is used to replace the official dtb (Corresponding kernel
> >> version is 4.4) file provided by Nvidia
> >>        4. Recompile the 5.15 kernel, but enable xenomai and use the
> >> dtb file in the 5.15-dovetail directory
> >>        5. The 5.15-xenomai kernel compiled in step 4 cannot be
> >> started, and stays in the "Starting kernel ..." stage
> >> (linux-5.15-xenomai+upstream dtb combination cannot be started)
> >>        6. On the basis of step 5, we used the official dtb file
> >> provided by nvidia. The kernel can be started, but it will be stuck in
> >> other places (linux-5.15-xenomai+nvidia dtb). In any case, the kernel
> >> can be loaded and executed. The reason why the system does not start
> >> normally is the mismatch between the linux kernel and the dtb file.
> >>
> >
> > It's likely more complex than that. If the kernel/dtb tuple starts with
> > Xenomai off but not with Xenomai on, you have something IRQ or timer
> > related not working as expected. The reason might be that some irqchip
> > or timer needed on that platform has not yet been enabled for use with
> > Dovetail. Philippe, was the Jetson platform enabled/tested already?
> >
>
> Some people have expressed interest in enabling Xenomai for this
> platform years ago, but nobody contributed any code. I never worked on
> this hardware either.
>
> --
> Philippe.
