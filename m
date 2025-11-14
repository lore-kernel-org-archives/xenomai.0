Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E72D8375
	for <xenomai@lists.linux.dev>; Fri, 14 Nov 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144549; cv=none; b=Re/sJMKGuiCAeE7skD/uCuCVpuT50MwRheJlviJzFMqutEKD2UYYqU9PkraRnDBAyK7xmkCJy8fmNKHv2UzKodb/c5q5pB1eQMbg+Zu6F7fRiM02ShDW7F/ZnUBSZq4/a875Lw+E84VSsy5KWWhlIjbp88saNQWmraXO62RU3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144549; c=relaxed/simple;
	bh=GumiCiyqYbxDQJamd43+KBhBE88L3uLPmXUvxy0r4/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e+fakwkj+DU0aSSgeJ3+x027egMI3Bk89c/hCZYTigLllVKmj2GR8bK7jZti3beUdAGCPUpxR8C8ZhB06HL794UkVfJhFzJXKMRBCMv14L+qgSXm1l3udo+viOjU+pm59U1JwmQ644qhVHo7Zg7+nwzT7CIf8gXoBwyBNCcxvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzQ2TD/r; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzQ2TD/r"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so1497478f8f.2
        for <xenomai@lists.linux.dev>; Fri, 14 Nov 2025 10:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763144546; x=1763749346; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTmZW78szLYE0Ueoyhp9eVyYn7YbGYkUhIXZRpgY8qg=;
        b=KzQ2TD/ruCt5QP6xC2PICDwMxuYVn3ra3ByUgWzISRkOZBiXfkESQ8XS4nchPy7fPT
         xRYZNNtdze2E3WuMc9a/qK42gF/QimEr9EbyfRnQgEvbPCjFf5lQr1ts3+/hhzMQP+Xw
         U3pOzmR2lyuGCZX8ynYVTgoRVnWZovV0p3BEFD+0m1z1PvRwintIhd3jPRMOfzGb5PwP
         IK53X0JRmuvpvglUSOotPL4hxxnUWcsWyXasunxmpO+LVhkUHKQE0bYD5p9HtBHc0ylf
         UsPsdoukN3Rx+2UY91EfTj+TZl7frCuPQOLJ20aXv8Rqcb2RdFOyKCAunIj10vlw39Rn
         jjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144546; x=1763749346;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTmZW78szLYE0Ueoyhp9eVyYn7YbGYkUhIXZRpgY8qg=;
        b=kylRcRw28QnlfaNXuj2cPbv6m2EFlDDGfm1L6nYdHb0q7j56h9ty/dP4kIDoCQgG97
         DrjwIeirtRXUiB2AoO5NkQq9+mEpIsZgexptIGsXoDL961QlqF50HQA+MgSsW++WrX/w
         IsN9lsM7lN8JZIm5RJBvKx11+auAD3oK4YoFCnlOZ5iOpUUh3TBktvgnudgGzqob0CN7
         0zGRCfHqZWdOhr11zd8bWpRo6vNPp72sV5oNG5BO7/QaGmvM6vRxBvxGN9pVmkT/h1iP
         YxlqNfqcYHP8v+Z8aFD2Q4T2ntFxIK+UEX7FNj1j3adp1SxgmloW48pZ7/uVyeAQVMlp
         5rTQ==
X-Gm-Message-State: AOJu0YxdyF4RsegA+mWMrqcT4PxWSdEatpZG0SBhmwEPzXbndaGCKYyg
	jlJGczmjySrdajm5HW9XTDrOZoPEC21OmEKJIPPoRHZZETPuCLkS8LFu7mSjog==
X-Gm-Gg: ASbGncsh81DqR/TsJAdx55Zrk/KPE85agKWFX/lO8ogfcI7tFBOnZ+CylRTUkim8X4p
	Ukp4Tt7TTOc/ksIOJqAE8zlOMvNvRc1J3I+gia9OUUkf+fMBRiyqj2F3xPTz/VKZ6ZSV2hrErV5
	Huw0Gp5tpH5nna56sLj3i8D1wi557ifJSZ++4Dmo3Uc533JRFIvPxi87OP9n9DIylDwNRoquxMk
	cb1iFuDugyo/ICik4U6GmmHQW6++mRDNR+vZCVzdiipUmKbbuTIfKEl+P2DfnhykUi/KiYjo73L
	Y0t0GdNiES23acvnzyzk4BTRBW1gnDIvH/2LvCGMtwFkEd1BLUF7zSmMqoG4S2aZ5YfWW6nfoF4
	1v0XY/APbiZItq53Xza0KW4KUUCCnwtcg0/Ibh0TkN+8qDjf8tieM2wW3OrPeJzhHWvxLynaycV
	mN4g==
X-Google-Smtp-Source: AGHT+IHUBppQIg9b1x6JTbznUzsNPm817B93tN8orVQtRVo13QZ3UYLijdeKdIdwvMQAEgA/g906OA==
X-Received: by 2002:a05:6000:240e:b0:42b:3746:3b87 with SMTP id ffacd0b85a97d-42b595b7fddmr4004156f8f.52.1763144545514;
        Fri, 14 Nov 2025 10:22:25 -0800 (PST)
Received: from bogeyman ([2a01:e0a:f57:6270:428b:3280:55df:97c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b14bsm10974526f8f.9.2025.11.14.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:22:25 -0800 (PST)
From: Philippe Gerum <philippe.gerum@gmail.com>
X-Google-Original-From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH dovetail v3 0/8] riscv: Add Dovetail support
In-Reply-To: <76574cc0-c85c-4d71-beb6-1233799799d6@siemens.com> (Tobias
	Schaffner's message of "Thu, 13 Nov 2025 13:26:11 +0100")
References: <20251113121003.416012-1-tobias.schaffner@siemens.com>
	<76574cc0-c85c-4d71-beb6-1233799799d6@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 14 Nov 2025 19:22:19 +0100
Message-ID: <87ikfc5vac.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Tobias,

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi Philippe,
>
> The EVL testsuite is running successfully on QEMU with this set of patche=
s.
>

Nice work.

> I=E2=80=99d like to ask how we should proceed from here.
>
> If possible, I=E2=80=99d like to merge the RISC-V components for
> xenomai-images so that we can set up an initial testing pipeline. To
> do that, we=E2=80=99ll need a development branch that integrates the Dove=
tail
> and EVL components, which can be referenced.
>
> My private testing branch[1] is currently based on v6.12-evl1-rebase,
> but I=E2=80=99m happy to port it to whichever version you=E2=80=99d prefe=
r to continue
> with.
>

You now have maintainer access to the
linux-dovetail.git/wip/dovetail-riscv and linux-evl.git/wip/evl-riscv
branches. You should be able to maintain the Dovetail and EVL core ports
from those separate trees. Both branches should be considered as
rebasable. Those kernel trees contain the riscv bits I once harvested on
the mailing list some time ago, so by no mean up to date. You can
definitely replace them at will.

You also have maintainer access to the libevl.git/wip/libevl-riscv branch
(rebasable too), which I just forked off the -next branch.  I'll pull
from the former branch when deemed ready. Please keep in sync with
-next, not master.

linux-evl/wip/evl-riscv and libevl/wip/libevl-riscv can be the source
trees for xenomai-images at the moment, until merged.

The Dovetail kernel tree should not contain any EVL-specific bit so that
other real-time cores (e.g. x3 Cobalt) can use it seamlessly as well,
the EVL tree should include the Dovetail tree plus the EVL core with
riscv support.

The Dovetail patch set should introduce riscv support piecemeal, in a
way which allows us to bisect code when chasing regressions by enabling
features incrementally, from mere interrupt pipelining to alternate
scheduling of oob threads, along with oob networking, oob device support
(gpio, clocksources, timers). Of course, as development goes on, we end
up with individual fixes stacked on top of this ideal series of
commits. From time to time, these fixes are squashed into the commits
forming the fundamental series I just mentioned.

e.g. looking at rebase/v6.17-dovetail, the fundamental series adding
Dovetail support piecemeal goes from 12e0fbdff1d45 to
c09b64e1767a2. Commits on top of this range are fixes to this series,
which we may squash at some point, when forward porting to some upcoming
kernel release (this normally happens during the upstream -rc cycle).

As you know, the EVL tree for a newer kernel release is obtained from
forking off the matching Dovetail tree, forward porting the EVL bits
from the latest release. Pretty straightforward. Here again, we may have
Dovetail fixes landing on top, and EVL fixes as well. The latter are
never squashed though. Any merge-related change to the EVL bits most
often appears explicitly in an individual commit, because there are very
few places for merge conflicts with upstream changes in the EVL code
base, so we are usually able to merge seamlessly, we have to compile and
run it for finding issues in most cases.

Eventually, the plan is to merge wip/dovetail-riscv and wip/evl-riscv
into the linux-dovetail and linux-evl trees when ready. A working
initial port of EVL to some riscv hardware would indicate that such port
is ready for inclusion.

Basing the initial riscv port on v6.12.y-cip would benefit people who
need an SLTS kernel. However, this would also double the initial
maintenance work on your end, since we are going to need a port to v6.18
which is brewing here. What's your take on this?

--=20
Philippe.
