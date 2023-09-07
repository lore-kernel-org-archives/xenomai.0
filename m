Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395D63A3
	for <xenomai@lists.linux.dev>; Thu,  7 Sep 2023 21:41:36 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-501bd164fbfso2311290e87.0
        for <xenomai@lists.linux.dev>; Thu, 07 Sep 2023 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694122894; x=1694727694; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G2c4gcX8qallGvVhqu2gIRwbXnS22MXjmeoQY0TDVxw=;
        b=ofh+DnJ4/3p+18ZKk0ihManlRjp3T8b7RE6daj1bM+zIYBEdMtou+w0MaG0+TUmN4a
         ZT6G4WcCzcLlWqmnocOvaIuESpWvpnFFneDjp9HR6g2lA5L0W5pscCq8NHMR2eIvYVei
         0OJjdOevT3fKs9tJbOniQurBlLV0EeX9VXDZIq/qd/xoGu5UwJGAq3Pczx9pne4ldHrq
         x+Tmir6sK2QyUYv8NFs04ara9tEAZxEwYpWzRZtKdgtWve3D45fxdeCAcD0OEul0ybL6
         L5ztkgcCojKzLUdYBt9ZVcNCFFMOI9pSQ2Ep3SqdIIopyqZbMoE3pbqOkxuQgWbZODY/
         M/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694122894; x=1694727694;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2c4gcX8qallGvVhqu2gIRwbXnS22MXjmeoQY0TDVxw=;
        b=VH/oF2rJtS3Knsw9VFXuNOK6Q8nOsxwa8Tbfhlc/1Br1pAq2EGeqD88N2Hd8Qvlt95
         qMAI1M/IQrMvrEdbQETprQQZx9QvjrMNVJUty5lzlRQSwqyFiRYeFXPmGIXOwUAqGG/N
         F9r0u9ohOCMSMhBLiAffGWJMz4YLMIVWhhtWOGLHuQpKxEErhhdawwrRRyeyoI1A2ScO
         2+a9fud8NPd4ia5Ug3mbmFebsELV8aO9QgnTUq2afn6v3Eln918PHknlrvONI1XW8HCK
         caAnwt28unbtbtL7/iZv6xZPIZ2LaJE33+XZtnmwmZ+Ji3Dkd//3iY+KIHIaP3Cp/Nz4
         JNhA==
X-Gm-Message-State: AOJu0Yzxv8WndrJ1+QD/LFoUYOg69Pg5m0jr25FUB4bdWbXR9j9CE6rz
	HYTgCs5eIuVVbE93iBrZ4+M5BlCwkb22OZG+fkIVJbl62ww=
X-Google-Smtp-Source: AGHT+IHUPtRp450BxPWJbi0XeV/4Yx2iu5elGtbug8JOiIuTUnwBspwqQ7tMp1pXD065l3ClphJ8p7nudrEWWpPofqo=
X-Received: by 2002:a19:5e02:0:b0:500:c709:5845 with SMTP id
 s2-20020a195e02000000b00500c7095845mr407244lfb.4.1694122893878; Thu, 07 Sep
 2023 14:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yuri Zaporozhets <yuri.zaporozhets@gmail.com>
Date: Thu, 7 Sep 2023 23:41:23 +0200
Message-ID: <CAEkURaZYn=DByS6ikEzVQGxOUtMbYd2A6_PAVYbkMowmomQvYQ@mail.gmail.com>
Subject: Re: [PATCH] clock : avoid panic on xnclock_set_wallclock() call
 during COBALT_STATE_WARMUP
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Jan,

Could you please apply the patch from Florent? It seems this problem
is still not fixed...
Thanks in advance!

From: Jan Kiszka <jan.kiszka@siemens.com>
To: florent pirou <florent.pirou@intel.com>, xenomai@lists.linux.dev
Subject: Re: [PATCH] clock : avoid panic on xnclock_set_wallclock()
call during COBALT_STATE_WARMUP
Date: Thu, 8 Dec 2022 08:20:31 +0100 [thread overview]
Message-ID: <e725d402-ec1c-bc60-5ec4-cc3bef3d452a@siemens.com> (raw)
In-Reply-To: <20221206113707.31311-1-florent.pirou@intel.com>

On 06.12.22 12:37, florent pirou wrote:
> The nkvdso variable should not  be unconditionally referenced in
> xnclock_set_wallclock().
>
> Call-stack:
> ```
> IRQ stage: Linux
> RIP: 0010:xnclock_set_wallclock+0xba/0x1a0
> Code: 7a 01 00 4c 8b 25 e6 39 35 01 e8 31 a2 f6 ff 48 c7 c7 60 3e 4c 82 48 29 c3
>  48 8b 05 70 f9 9c 01 48 89 de 48 89 1d c6 39 35 01 <48> 89 58 40 4c 29 e6 e8 fa
>   fb ff ff 48 c7 c1 10 cb 01 82 ba 29 01
>   RSP: 0000:ffffffff82403e70 EFLAGS: 00010012
>   RAX: 0000000000000000 RBX: 172c603286674a4f RCX: 0000000000000008
>   RDX: 000000000f424000 RSI: 172c603286674a4f RDI: ffffffff824c3e60
>   RBP: 0000000000000000 R08: 0000000000000123 R09: ffffffff8201cb10
>   R10: 00000000fffff000 R11: 3fffffffffffffff R12: 0000000000000000
>   R13: 0000000000000000 R14: 0000000000000200 R15: 000000002b4448a4
>   FS:  0000000000000000(0000) GS:ffff888869000000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000040 CR3: 000000000840c001 CR4: 00000000000626b0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    do_settimeofday64+0x137/0x1c0
>    rth_timer_init+0x60/0x7e
>    x86_late_time_init+0x12/0x2f
>    start_kernel+0x4d8/0x577
>    secondary_startup_64_no_verify+0xb0/0xbb
> ```
>
> Kernel panic happens when the clock is set using do_settimeofday64(),
> implicitly calling xnclock_set_wallclock(), during the cobalt_runstate
> COBALT_STATE_WARMUP state, while nkvdso is NULL.
>
> Yuri Zaporozhets: Crash in xnclock_set_wallclock() if time/date is set early
> https://lore.kernel.org/all/CAEkURaZO-2uDFwx3ZnS=229z5XZT27WbeFs3kS5Qdq7MMPAiKw@mail.gmail.com/T/
>
> Signed-off-by: florent pirou <florent.pirou@intel.com>
> ---
>  kernel/cobalt/clock.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
> index 2b9efad4e..b1b9a3b0e 100644
> --- a/kernel/cobalt/clock.c
> +++ b/kernel/cobalt/clock.c
> @@ -282,6 +282,11 @@ void xnclock_set_wallclock(xnticks_t epoch_ns)
>   xnsticks_t old_offset_ns, offset_ns;
>   spl_t s;
>
> + /*
> + * Check if time/date is set earlier than cobalt_init
> + */
> + if (!nkvdso) return;
> +
>   /*
>   * The epoch of CLOCK_REALTIME just changed. Since timeouts
>   * are expressed as monotonic ticks, we need to apply the


-- 
Regards,
Yuri
