Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304981E9B32
	for <xenomai@lists.linux.dev>; Tue,  7 Jan 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256650; cv=none; b=Mx6x5c5Jltom/xTUuzqPMAupnC2knV2b3PRGPxZd6wSYfF3tJ0pES911zzkVWfunJJbOBFsMVOVEcYMpQvJPithVgUCtdws+gPMGdlV0Qke41W1yBbh28QUhR6L4UcRyuMo0iYYhncAP4yd/8ZqExPeofzTX/b+83CsqzYlyw24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256650; c=relaxed/simple;
	bh=z1w+vcwBxoYa+XmwKnNk42a0wzEQIHHFq9hAZCAxWhQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cR4aAJ4bgDT2LQU9f/YztFXW6KE1hhOmKOja01z8rCXnTxKiF6FDvEA6EbUtzcyB6tHpySg7/eZBrt3W8tvxXSFk8JBzOCcG+hBDR9UnYtshU8m3bXEv0Mvs1psD/ZmW/4RH5vJlE3YCkqn6tPMAmCy1GC/xixQjktrgEXbSJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeaFIVm1; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeaFIVm1"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e549be93d5eso6129292276.1
        for <xenomai@lists.linux.dev>; Tue, 07 Jan 2025 05:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736256646; x=1736861446; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z1w+vcwBxoYa+XmwKnNk42a0wzEQIHHFq9hAZCAxWhQ=;
        b=BeaFIVm1a0lwc2yToKczJdZFXT3siVAmySoyTHOD4lDPcGc0tAZmET8JR/SG5Lsm+L
         JU9z5fUNNf31zUzRvWnMCmHljyEgsVmAv8l6WtWOyPY4iNFJC0+iczQLlnrdeeepQaP7
         SSsIj+Z2SZNl46brwXwgCC58iMSuwMfyt/jjobcpeqIj5HGehRb+Ake4LNrVGBsJ0CQk
         4sCJfWJg0sAr7RksqjG31bNaF2S2SSQHYZskoDGJq6XqiaWLzUOKASrqn+rj7wyMAEJG
         ssTGbACoMxxl/K0cKsh8/bNJqUhyE6xVdGEoyDt2LZUrMQFnr/xIWkzpubjUC+UpKtJa
         GbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736256646; x=1736861446;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1w+vcwBxoYa+XmwKnNk42a0wzEQIHHFq9hAZCAxWhQ=;
        b=f9Z9kccaNJRDVeLeG6ccZ6yb8RLG5qFdyGf9L0U8d3OFnr2M++zREDapty9DvSg+uq
         RV6Dt0TnmSYJDUWCz+QY1B+w75iPkL7KN4pSeHlStbbEa0wdaixNzcQwTujvYOcXTOCR
         cGn9lNfL738hzWBuRgxyfc+71Ju9jTma4RG1P12d2HPkclkb0i0JyrUiIatNu4vCvVze
         VC05dlhlW6gc6zxXgwFwkzTJQ5fZKGiJE90HvLxYEOudQ+LhVmD+NjjXXiYtH/GQ4jTl
         IpKbSC65VVhn4pEWeSwxQlPgkU6icI+17L7rcGuglapGU34NrTzo398nsJSHh1edMNqX
         XDrw==
X-Gm-Message-State: AOJu0Yy4T4MjUkuZLw0hzbhrOCuWVMVgLfwtszb4K3Yy3usXjT8+N+4V
	Q3FC8+76vVpV04ytFFXAvDFNwcTN7rs8lNiN8E1gPqUugmdtpGjZbTHr/uxAatlQ6TJWjJL3s4p
	2pNVpfyTgmI7h6ad6eMrpxzFux2eIYQGOBi78ag==
X-Gm-Gg: ASbGncu9rCRaV+4CY2aem0muGz+BFUk2D0nUwxZtshIp8/1TKTSrhPbRgVaVtQCrom1
	OXyjvIJZAl9+GdKCaz/O87OvHHkewWCbXdloe1H8=
X-Google-Smtp-Source: AGHT+IFEFKzKChXz+7ET/Ne4vhZEpOsGFrRzrReZD/134gSk5TntfrxjO51QqX9Y01gt9ZziHLf1Zm8TZeRcHHdhHJ0=
X-Received: by 2002:a05:690c:4983:b0:6ef:aae1:ac6f with SMTP id
 00721157ae682-6f3f80d6257mr449648817b3.3.1736256645699; Tue, 07 Jan 2025
 05:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: shanmu <shanmu1901@gmail.com>
Date: Tue, 7 Jan 2025 21:30:33 +0800
X-Gm-Features: AbW1kvYGtLBOs-Bv4Am9hqYfi0VHfrvPPVCo_3RJi33rMphpwh-OHd9t5sntqmw
Message-ID: <CALt0BK+_cLFefPng1md_Pv5UkuhF9Hz6+HXJgj0353vPv0qo8g@mail.gmail.com>
Subject: Porting Dovetail and EVL on RISC-V
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, all,

I=E2=80=99m trying to get EVL running on RISC-V and have made some progress=
.
I rebased the `wip/dovetail-riscv` branch onto the
`linux-evl/v6.12-evl-rebase` branch (though it seems more reasonable to
rebase `linux-evl/v6.12-evl-rebase` onto `wip/dovetail-riscv`, anyway) and
added some architecture-specific code. For `libevl`,
I added the `vdso.h` for the RISC-V architecture.
While running the tests of `libevl`, it encountered a
`check_hard_irqs_disabled` WARNING in the `dovetail_context_switch` functio=
n.
I=E2=80=99ll address this issue as soon as possible and submit the patch.

If anyone else is working on this, please let me know so we can
coordinate efforts and ensure smoother progress on RISC-V support!
