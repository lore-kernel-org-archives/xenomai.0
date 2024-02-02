Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5714AD31
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894051; cv=none; b=SObebZ8Z4uh3GPFh/iY2F/i1kqIrM8LzhonvKt/bSd7v/nmmcFcU6tVeKm41GEKwY7KZVX7ROFD6lomeHQj/aNQMl1t2PXEuGlL8LEZwnVsEyzmRiSqLYxUYC7NrYOotIihW7YbY8oGNRCRU95y1r7UYF6xScrdY3L1H6Rad9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894051; c=relaxed/simple;
	bh=iUwF9G6qrIEhbys+SPEm9IIcFgxoxUZpWjJ1nP3zz4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLVYfO49TO/Up0H3Wg514GpWfr1bJ1vCGW8paywBEGtcFPimkluBF5p7MJ9Ejm3NGgsRrsNCZN+eRjdYiWhjtPYt5p36tk+c5ypK4sopVjVdj31LQmoRNrUj5to176vlzYQWL52iS8066O9pU/cDlC8jORWJsFWNg4AbpIGUtn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oc5EazP5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc5EazP5"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1590469a12.1
        for <xenomai@lists.linux.dev>; Fri, 02 Feb 2024 09:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706894049; x=1707498849; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNxuWcdNpx3iclNs1AuqT4WF+ExEZDs4WJRnPCixgBs=;
        b=Oc5EazP5cTai4ZI5157qJR3RUjBy7hxyKGi2vkqPMOOEcjIm5+NUNsgfU0hgEFuMK+
         p2wmyYASIrLicyeLHoyzguca+P+WF+3DxlVCvF7SQKyKB1dvoRNZpGowugQ41Kflwns/
         Qi/VA/wCe5FIiJBlRjdQnOAqj5dFua5Te4FnyFluXeOL4texR/2bJy0G3GSdvU3hLh5C
         B0jeYFWY/vouWqJxP8x5SeHJzPB7HR7PYYTpqCKN/0dniENR9S1srHB+Wq1fkw/G3YFr
         5E3fYyCFKytxsbEQwUCGscPxsBJIWw47olt3RErnpNfYtwXUH1GpjMRsdeDe3zP/YCI3
         wYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894049; x=1707498849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNxuWcdNpx3iclNs1AuqT4WF+ExEZDs4WJRnPCixgBs=;
        b=spOc7JHTyL0/gV8aVm111fEiT+x4zjtmvkf8cq1dm4Aby17yRu5T7H/tU4xntjJaxE
         D6tO3IfhAz893drQLqOAyjrOZJyW3nc0bYIvAvG7mbmoug2UySjh3MIUvqGp8wDo7qvN
         aVw6jRWsHrpcGkYDtBmS8e2BTm0KNi8Vy9L2wx+rESHawdOSu6qc1oy1inATLaWomecH
         pXiOR3cyAsonqHmdB5QP7wwD9taoxm2pnUQO8D+WeAAlmw8aI6HcV6PVVIUPGTf0j0y/
         wsVXd9FEBrlkDXuGKF5PItz99yCjAhBgwFKteLRu9Hy+PU357AzNfLUfRRpEgmttaagM
         BtqA==
X-Gm-Message-State: AOJu0YzNLpcPPfiDzW24jHdIW2v0b0jvcrqvtowa6GBZGcsK3RJWPV3H
	cNSdrma+s2FF0zTXMk85zynOD+ZzZC7PMM6A1wKf9UMA6i55cKYKmspvWQ0UTE4m2Cj4Nnmx0zC
	8gk4B0EbHVvN5ULcncVeebTq3E80=
X-Google-Smtp-Source: AGHT+IFRCJCNFh8oKipQxsYJTYA3YP2x4P0GFVrtznLLlKxNMr8/PhQUuF5Q9biPgRussCFlwSC+1akUU7izJgh1A18=
X-Received: by 2002:a17:90a:db4f:b0:295:f30d:ae1 with SMTP id
 u15-20020a17090adb4f00b00295f30d0ae1mr8682126pjx.8.1706894048915; Fri, 02 Feb
 2024 09:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 2 Feb 2024 18:13:56 +0100
Message-ID: <CAFLxGvw+oSFroW3rY9FD9hnDKUbZ5E7w4is9Z1QCbODar5b6qQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:55=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> Hi all,
>
> this series adds the 32-bit compat support for arm64 to xenomai 3.
> It allows us to run arm(hf) applications on arm64 kernels.
>
> Best regards,
> Clara Kowalsky
>
> Clara Kowalsky (7):
>   compat support: cobalt: Move 32-bit compat files to generic
>   compat support: cobalt/arm: Refactor registers
>   compat support: cobalt/arm64: Add compat support and clean-up
>   compat support: cobalt/arm64: Update ABI revision level
>   compat support: cobalt/posix/syscall: Use syscall_get_arguments()
>   compat support: lib/cobalt: Fix VFP detection for arm on arm64
>   compat support: cobalt/arm64: Enable compat support for arm64
>
>  .../arch/arm/include/asm/xenomai/syscall.h    |   4 +-
>  .../arch/arm/include/asm/xenomai/syscall32.h  |   8 +-
>  kernel/cobalt/arch/arm64/Kconfig              |   2 +-
>  .../arch/arm64/include/asm/xenomai/syscall.h  |  10 +-
>  .../arm64/include/asm/xenomai/syscall32.h     |  12 ---
>  .../arm64/include/asm/xenomai/uapi/features.h |   2 +-
>  .../arch/x86/include/asm/xenomai/syscall32.h  | 102 ------------------
>  .../asm-generic}/xenomai/syscall32-table.h    |   6 +-
>  .../include/asm-generic/xenomai/syscall32.h   |  78 +++++++++++++-
>  kernel/cobalt/posix/syscall.c                 |  16 +--
>  kernel/cobalt/posix/syscall.h                 |   2 +-
>  kernel/cobalt/trace/cobalt-posix.h            |   4 +-
>  lib/cobalt/arch/arm/features.c                |   5 +
>  .../arch/arm/include/asm/xenomai/syscall.h    |  65 ++++++-----
>  14 files changed, 143 insertions(+), 173 deletions(-)
>  delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall3=
2.h
>  delete mode 100644 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.=
h
>  rename kernel/cobalt/{arch/x86/include/asm =3D> include/asm-generic}/xen=
omai/syscall32-table.h (94%)

Do you changes really need to fixes on the dovtail side?
I needed this one:

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 6f8fa0ed55fa..ef9c75296c0d 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -86,6 +86,12 @@ static void el0_svc_common(struct pt_regs *regs,
int scno, int sc_nr,
       int ret;

       regs->orig_x0 =3D regs->regs[0];
+
+       if (scno =3D=3D 0x000F0042 && is_compat_task()) {
+               scno =3D regs->regs[0] | __OOB_SYSCALL_BIT;
+       }
+
       regs->syscallno =3D scno;

So, basically what arm32 does in the entry code.

--=20
Thanks,
//richard
