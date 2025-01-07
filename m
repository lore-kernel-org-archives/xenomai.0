Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1E1F1913
	for <xenomai@lists.linux.dev>; Tue,  7 Jan 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257867; cv=none; b=SSIkVGGABEpW5tNPlRHljLMYI8VZ70h47KAH1V6yxag4Dv/4CuNvfDRSCaCZDZfkFZqSN+UWHYrkhEJqIe/otAfoFz12NB55mhtF5+c1Cz0hqwVJ/t8SOVGD4pa3DME5tbJ18cghLXQJaH1jVOi41KErnTu/xkYQeZqdy3hzkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257867; c=relaxed/simple;
	bh=mIJecl3ScS0OdEgw+T/YRsuylIikbk+SSsFrZpfsiBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LgnwX8qE6sjpNYxyRoULRwHy8GyiEOi1XgH3nxC+8Ut2+8dj8jcHtgTxVk+mo5dkcjcYxDCB+sjSuKmNqmtK5+ceGSdk7kYnD71tz+jL5mAOruIwTdZosLCv9WxCaib7alEIqMhoYfvlVC58LX80L1RMyuKm4ipq8NsqdVNrtU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43626213fffso96310995e9.1
        for <xenomai@lists.linux.dev>; Tue, 07 Jan 2025 05:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736257864; x=1736862664;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIJecl3ScS0OdEgw+T/YRsuylIikbk+SSsFrZpfsiBw=;
        b=nK/XrbbWDL8xHHt0gWE/dOrx6CsheAvwxX4FlWVj596o007k7eHk3xNYfW8teMKodE
         +qnFQy4+rQMBdJZNtaPo6ymAjafsJSNVBfNz5Ap1xduVbAcKypfpH5j/NlikuGEcgbY6
         Rd71KN9w/X7tFfFhmBZPOXUxej3ICrSa+cv8LboMmU79X0uZyApbbCDWJnfeFw8jQNLE
         Mc6QWb1wwjyhCCEeoDbj4F0zKga1sa9xTEvygI6mbXbCOTJl4KRbob4kJiuCUnjloYSu
         CIqfPalmGtUM/IPHes3kRb4E7pv97hfiay4TLeLgkZXENmJPs4U9B2ZlfsLaZGbF+z4i
         Bubw==
X-Gm-Message-State: AOJu0YzibB+SAduXwxdWpz0tda8WLUAEo25hw2yDtGq5tMk1gldruNRW
	0eNuShV/Kjb5Jn1IfBEgbRGVZfJRjntA3mP2KqPH/bqiwEvj95kGWqw8YA==
X-Gm-Gg: ASbGnctvGFgTqNXDzjD/k0VqtZOplqITdTifE7fh5MlvEafR6+TfyZgeIbLV9QoY+t4
	5dpCDtMg93T3xXA5BwiChg7sIEZeDCvGndbsrZt2qNt45N1681qGRsCSvX+U/QxwVm0V5D77lnj
	gAPUNoT8vPVSrt2ERFSqrTh/ED0WbF/R5DZbI7nd5spY1JaNfy5+8VGTloJTK+d6f/cVk6SbnKf
	MOhrsFvndZCp7VkfoNhmExcKuJ6MkexHSWTUCK2yQ==
X-Google-Smtp-Source: AGHT+IEkZVfHkSmevexmCsHU3YAQWNACa8c0C1pDDG2LeDhorxqfgQaQ476lF6YEwPFr5BASXmtO5w==
X-Received: by 2002:a5d:64e2:0:b0:38a:6183:77b9 with SMTP id ffacd0b85a97d-38a7912c9cfmr2871016f8f.6.1736257863957;
        Tue, 07 Jan 2025 05:51:03 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a67c77a90sm12379028f8f.54.2025.01.07.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:51:03 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: shanmu <shanmu1901@gmail.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Porting Dovetail and EVL on RISC-V
In-Reply-To: <CALt0BK+_cLFefPng1md_Pv5UkuhF9Hz6+HXJgj0353vPv0qo8g@mail.gmail.com>
	(shanmu's message of "Tue, 7 Jan 2025 21:30:33 +0800")
References: <CALt0BK+_cLFefPng1md_Pv5UkuhF9Hz6+HXJgj0353vPv0qo8g@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 07 Jan 2025 14:50:58 +0100
Message-ID: <87ttaahgvx.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

shanmu <shanmu1901@gmail.com> writes:

Hi,

> Hi, all,
>
> I=E2=80=99m trying to get EVL running on RISC-V and have made some progre=
ss.
> I rebased the `wip/dovetail-riscv` branch onto the
> `linux-evl/v6.12-evl-rebase` branch (though it seems more reasonable to
> rebase `linux-evl/v6.12-evl-rebase` onto `wip/dovetail-riscv`, anyway)
> and

You may want to cherry pick the patch stack starting from
#264c0deebb4e65 to the tip of rebase/v6.12-evl on top of
wip/dovetail-riscv, that may yield an easier merge process.

> added some architecture-specific code. For `libevl`,
> I added the `vdso.h` for the RISC-V architecture.
> While running the tests of `libevl`, it encountered a
> `check_hard_irqs_disabled` WARNING in the `dovetail_context_switch` funct=
ion.
> I=E2=80=99ll address this issue as soon as possible and submit the patch.
>

Thanks for this work.

> If anyone else is working on this, please let me know so we can
> coordinate efforts and ensure smoother progress on RISC-V support!

AFAIC, not working on this (only maintaining a consolidated upstream
tree with the contributions received for the risc-v port).

--=20
Philippe.
